import 'package:tubesfix/entity/Pelanggan.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class PelangganClient {
  static final String url = '192.168.0.106'; 
  static final String endpoint = '/laravel_tubes/public/api/pelanggan'; 

  static Future<List<Pelanggan>> fetchAll() async {
    try {
      var response = await get(Uri.http(url, endpoint));
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);
      Iterable list = json.decode(response.body)['data'];
      return list.map((e) => Pelanggan.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Pelanggan> find(id) async {
    try {
      var response = await get(Uri.http(url, '$endpoint/$id'));
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);
      return Pelanggan.fromJson(json.decode(response.body)['data']);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> create(Pelanggan pelanggan) async {
    try {
      var response = await post(
        Uri.parse('http://192.168.0.106/laravel_tubes/public/api/pelanggan'),
        headers: {"Content-Type": "application/json"},
        body: pelanggan.toRawJson(),
      );

      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode != 201) throw Exception(response.reasonPhrase);
      return response;
    } catch (e) {
      print("Error occurred: $e");
      return Future.error(e.toString());
    }
  }

  static Future<Response> update(Pelanggan pelanggan) async {
    try {
      var response = await put(
        Uri.http(url, '$endpoint/${pelanggan.id}'),
        headers: {"Content-Type": "application/json"},
        body: pelanggan.toRawJson(),
      );
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);
      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> destroy(id) async {
    try {
      var response = await delete(Uri.http(url, '$endpoint/$id'));
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);
      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Map<String, dynamic>> login(String username, String password) async {
  final url = Uri.parse('http://192.168.0.106/laravel_tubes/public/api/login');

  try {
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to login: ${response.body}');
    }
  } catch (e) {
    throw Exception('Error: $e');
  }
}

}
