import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tubesfix/client/api_config.dart';
import 'package:tubesfix/entity/Review.dart';

class ReviewClient {
  static String get baseUrl => ApiConfig.baseUrl;

  static Future<bool> addReview(String token, Review review) async {
    final response = await http.post(
      Uri.parse('$baseUrl/reviews'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode(review.toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final res = json.decode(response.body);
      return res['success'] ?? true;
    } else {
      throw Exception('Failed to add review');
    }
  }

  static Future<Review?> fetchReviewByPesanan(String token, int idPesanan) async {
    final response = await http.get(
      Uri.parse('$baseUrl/reviews/$idPesanan'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data != null ? Review.fromJson(data) : null;
    } else {
      throw Exception('Failed to fetch review');
    }
  }

  static Future<bool> deleteReview(String token, int id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/reviews/$id'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body)['success'];
    } else {
      throw Exception('Failed to delete review');
    }
  }

  /// Fetches all customer reviews associated with a specific barber.
  static Future<List<Review>> fetchReviewsByBarber(int barberId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/reviews/barber/$barberId'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((jsonItem) => Review.fromJson(jsonItem)).toList();
      } else {
        return [];
      }
    } catch (_) {
      return [];
    }
  }
}
