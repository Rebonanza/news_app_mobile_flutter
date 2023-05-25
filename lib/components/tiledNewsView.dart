import 'package:flutter/material.dart';
import '../pages/newsView.dart';
import '../model/article_model.dart';
import '../controller/api_data_source.dart';

class TiledNewsView extends StatelessWidget {
  TiledNewsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
          child: FutureBuilder(
        future: ApiDataSource.instance.loadListHeadline(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            return _buildErrorSection();
          } else if (snapshot.hasData) {
            ArticleModel news = ArticleModel.fromJson(snapshot.data);
            return ListView.builder(
                itemCount: news.articles!.length,
                itemBuilder: (context, index) =>
                    customTile(context, news.articles![index]));
          }
          return _buildLoadingSection();
        },
      )),
    ]);
  }

  Widget customTile(BuildContext context, Articles news) {
    int newsDescriptionLength = news.description.split(' ').length;
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => NewsViewPage()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: Colors.grey[200], borderRadius: BorderRadius.circular(10)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              child: Image.network(
                news.urlToImage,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      child: Text(
                    getTruncatedTitle(news.title!, 60),
                  )),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${newsDescriptionLength >= 200 ? (newsDescriptionLength / 200).floor() : (newsDescriptionLength / 200 * 60).floor()} ${newsDescriptionLength >= 200 ? "mins" : "secs"} read",
                        style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                      ),
                      Text(
                        news.publishedAt!,
                        style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getTruncatedTitle(String actualString, int maxLetters) {
    return actualString.length > maxLetters
        ? actualString.substring(0, maxLetters) + "..."
        : actualString;
  }
}

Widget _buildErrorSection() {
  return Text("Error");
}

Widget _buildLoadingSection() {
  return Center(
    child: CircularProgressIndicator(),
  );
}
