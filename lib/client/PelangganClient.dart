import 'package:tubesfix/entity/Pelanggan.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tubesfix/client/api_config.dart';

class PelangganClient {
  static String get url => ApiConfig.authority;
  static String get endpoint => '${ApiConfig.basePath}/pelanggan';

  static Future<List<Pelanggan>> fetchAll() async {
    try {
      var response = await get(Uri.http(url, endpoint));
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);
      final decoded = json.decode(response.body);
      final List list = decoded is Map ? (decoded['data'] ?? []) : (decoded as List);
      return list.map((e) => Pelanggan.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Pelanggan> find(id) async {
    try {
      var response = await get(Uri.http(url, '$endpoint/$id'));
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);
      final decoded = json.decode(response.body);
      final data = decoded is Map && decoded.containsKey('data') ? decoded['data'] : decoded;
      return Pelanggan.fromJson(data);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> create(Pelanggan pelanggan) async {
    try {
      var response = await post(
        Uri.parse('${ApiConfig.baseUrl}/pelanggan'),
        headers: {"Content-Type": "application/json"},
        body: pelanggan.toRawJson(),
      );
      if (response.statusCode != 201) throw Exception(response.reasonPhrase);
      return response;
    } catch (e) {
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

  Future<Map<String, dynamic>> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('${ApiConfig.baseUrl}/login'),
      body: json.encode({
        'username': username, 
        'password': password,
      }),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;
      final token = data['token'];
      final storage = FlutterSecureStorage();
      await storage.write(key: 'token', value: token);
      return data;
    } else {
      return {}; 
    }
  }

  Future<void> fetchPelangganData(String token) async {
    final response = await http.get(
      Uri.parse('${ApiConfig.baseUrl}/pelanggan'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
    } else {
      print('Failed to fetch data');
    }
  }

  Future<void> logout() async {
    final storage = FlutterSecureStorage();

    try {
      String? token = await storage.read(key: 'token');

      if (token == null) {
        return;
      }

      final response = await http.post(
        Uri.parse('${ApiConfig.baseUrl}/logout'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        await storage.delete(key: 'token');
      } else {
        print('Logout failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during logout: $e');
    }
  }

  Future<Map<String, dynamic>> fetchProfile(String token) async {
    final response = await http.get(
      Uri.parse('${ApiConfig.baseUrl}/pelanggan/profile'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load profile: ${response.statusCode}");
    }
  }  

  Future<Map<String, dynamic>> updateProfile({
    required String token,
    String? name,
    String? username,
    String? email,
    String? phone,
    String? password,
  }) async {
    try {
      final response = await http.put(
        Uri.parse('${ApiConfig.baseUrl}/pelanggan/profile'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          if (name != null) 'nama': name,
          if (username != null) 'username': username,
          if (email != null) 'email': email,
          if (phone != null) 'telepon': phone,
          if (password != null) 'password': password,
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception("Failed to update profile: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error updating profile: $e");
    }
  }

  Future<bool> changePassword({
    required String token,
    required String currentPassword,
    required String newPassword,
  }) async {
    final response = await http.post(
      Uri.parse('${ApiConfig.baseUrl}/change-password'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'current_password': currentPassword,
        'new_password': newPassword,
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }                                                            
}
