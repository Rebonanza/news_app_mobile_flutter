import '../services/api_service.dart';

class ApiDataSource {
  static ApiDataSource instance = ApiDataSource();

  Future<Map<String, dynamic>> loadListHeadline() {
    return ApiService.get(
        "https://newsapi.org/v2/top-headlines?country=id&apiKey=5c1fad11b09c4a64be1b9cad7a77f2d3");
  }

  Future<Map<String, dynamic>> getSearchNews(String? text) {
    return ApiService.get(
        "https://newsapi.org/v2/everything?q=${text}&apiKey=5c1fad11b09c4a64be1b9cad7a77f2d3");
  }
}
