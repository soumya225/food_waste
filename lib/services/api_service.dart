import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  String? apiKey = dotenv.env['FDC_API_KEY'];

  factory ApiService() {
    return _instance;
  }

  ApiService._internal();

  Future<dynamic> fetchFoods(String query) {
    String url = Uri.encodeFull('https://api.nal.usda.gov/fdc/v1/foods/search?api_key=$apiKey&query=$query&pageSize=20&dataType=Foundation,SR Legacy');

    return get(Uri.parse(url));
  }
}

