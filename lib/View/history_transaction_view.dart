import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tubesfix/client/TransaksiClient.dart';
import 'package:tubesfix/entity/Transaksi.dart';
import 'review_page.dart';

class TransactionHistoryPage extends StatefulWidget {
  const TransactionHistoryPage({Key? key}) : super(key: key);

  @override
  State<TransactionHistoryPage> createState() => _TransactionHistoryPageState();
}

class _TransactionHistoryPageState extends State<TransactionHistoryPage> {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  late Future<List<Transaction>> _transactionsFuture;

  @override
  void initState() {
    super.initState();
    _transactionsFuture = _fetchTransactions();
  }

  Future<List<Transaction>> _fetchTransactions() async {
    final token = await _storage.read(key: 'token');
    if (token == null) {
      throw Exception("User not authenticated");
    }
    return await TransactionClient.fetchTransactions(token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFE0AC53)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Transaction History',
          style: TextStyle(
            color: Color(0xFFE0AC53),
            fontFamily: 'Inter',
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: FutureBuilder<List<Transaction>>(
        future: _transactionsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'No transactions found',
                style: TextStyle(color: Colors.white),
              ),
            );
          } else {
            final transactions = snapshot.data!;
            return Card(
              color: Colors.black,
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: transactions.length,
                  itemBuilder: (context, index) {
                    final transaction = transactions[index];
                    return Column(
                      children: [
                        Card(
                          color: Colors.black,
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            side: const BorderSide(
                              color: Color(0xFFE0AC53),
                              width: 1.5,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  transaction.date,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontFamily: 'Inter',
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  transaction.service,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontFamily: 'Inter',
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  transaction.price,
                                  style: const TextStyle(
                                    color: Color(0xFFE0AC53),
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const ReviewPage(),
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFFE0AC53),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5.0),
                                      ),
                                    ),
                                    child: const Text(
                                      'Review',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Inter',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                      ],
                    );
                  },
                ),
              ),
            );
          }
        },
      ),
      backgroundColor: Colors.black,
    );
  }
}
