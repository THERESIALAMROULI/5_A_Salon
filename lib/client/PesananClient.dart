import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:tubesfix/entity/Pesanan.dart' as MyPesanan;

class PesananClient {
  
  static const String _baseUrl = 'http://192.168.64.229/laravel_tubes/public/api/pesanan';

  // Function to fetch all Pesanans (READ)
  Future<List<Pesanan>> fetchPesanans() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((json) => Pesanan.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load Pesanans');
    }
  }

  
  Future<Pesanan> createPesanan(Pesanan Pesanan) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(Pesanan.toJson()),
    );

    if (response.statusCode == 201) {
      return Pesanan.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create Pesanan');
    }
  }
}