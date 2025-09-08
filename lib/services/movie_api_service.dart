import 'dart:convert';
import 'package:http/http.dart' as http;

class MovieApiService {
  static const String _baseUrl =
      "https://movies-ratings2.p.rapidapi.com/ratings";

  static const Map<String, String> _headers = {
    "x-rapidapi-host": "movies-ratings2.p.rapidapi.com",
    "x-rapidapi-key": "ef845b65b8mshcd4e4a717fbb46cp1d60e6jsnbca51b2c9699",
  };

  /// Fetch movie ratings by IMDB id (e.g. tt0111161)
  static Future<Map<String, dynamic>> getRatings(String imdbId) async {
    final Uri url = Uri.parse("$_baseUrl?id=$imdbId");

    final response = await http.get(url, headers: _headers);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception(
          "Failed to load ratings: ${response.statusCode} - ${response.reasonPhrase}");
    }
  }
}
