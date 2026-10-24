import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tubesfix/client/api_config.dart';
import 'package:tubesfix/entity/Transaksi.dart';

class TransactionClient {
  static String get baseUrl => ApiConfig.baseUrl;

  static Future<List<Transaction>> fetchTransactions(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/transaction-history'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> transactionData = json.decode(response.body)['transactions'];
      return transactionData.map((data) => Transaction.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load transactions');
    }
  }
}
