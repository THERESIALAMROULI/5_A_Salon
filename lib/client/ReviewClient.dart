import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tubesfix/entity/Review.dart';

class ReviewClient {
  static const String _baseUrl = 'http://192.168.0.106/laravel_tubes/public/api/reviews';

  static Future<List<Review>> fetchReviewsByBarber(int barberId) async {
    final url = '$_baseUrl/barber/$barberId';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      if (jsonResponse.isEmpty) {
        return [];
      }
      return jsonResponse.map((data) => Review.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load reviews for barber ID: $barberId');
    }
  }
}
