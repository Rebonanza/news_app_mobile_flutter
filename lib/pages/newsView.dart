import 'package:flutter/material.dart';
import '../model/article_model.dart';
import '../controller/api_data_source.dart';

class NewsViewPage extends StatefulWidget {
  const NewsViewPage({Key? key}) : super(key: key);

  @override
  State<NewsViewPage> createState() => _NewsViewPageState();
}

class _NewsViewPageState extends State<NewsViewPage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        child: FutureBuilder(
        future: ApiDataSource.instance.loadListHeadline(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            // Jika data ada error maka akan ditampilkan hasil error
            return _buildErrorSection();
          }
          if (snapshot.hasData) {
            // Jika data ada dan berhasil maka akan ditampilkan hasil datanya
            Article articles = Article.fromJson(snapshot.data);
            return ArticleContainer(size: size);
          }
          return _buildLoadingSection();
        },
      ),
  
    );
  }
}


  Widget _buildArticle(BuildContext context, size, Article news) {
    return Container(
        width: size.width,
        child: Stack(
          alignment: Alignment.topLeft,
          children: [
            ClipRRect(
              child: Image(
                fit: BoxFit.cover,
                image: NetworkImage(news.urlToImage),
                height: size.height,
                width: size.width,
              ),
            ),
            Container(
              width: size.width,
              height: size.height,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    // const Color(0xCC000000),
                    const Color(0x00000000),
                    const Color(0x00000000),
                    const Color(0xCC000000),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.only(top: 30, left: 10),
                  child: Icon(
                    Icons.arrow_back,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              // alignment: Alignment.bottomCenter,
              child: Container(
                width: size.width,
                margin: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      news.title,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: NetworkImage(news.urlToImage))),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  news.source,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  news.publishedAt,
                                  style: TextStyle(color: Colors.grey[400]),
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 40),
                          child: Row(
                            children: [
                              Icon(
                                Icons.bookmark_outlined,
                                color: Colors.white,
                                size: 30,
                              ),
                              Icon(
                                Icons.share,
                                color: Colors.white,
                                size: 30,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10, right: 40),
                      height: 3,
                      decoration: BoxDecoration(color: Colors.white),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10, right: 40),
                      child: Text(news.description,
                          style: TextStyle(
                            color: Colors.white,
                          )),
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }



 Widget _buildErrorSection() {
    return Text("Error");
  }

   Widget _buildLoadingSection() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }