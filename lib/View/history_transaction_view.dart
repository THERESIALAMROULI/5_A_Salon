import 'package:flutter/material.dart';
import 'review_page.dart';

class TransactionHistoryPage extends StatelessWidget {
  const TransactionHistoryPage({Key? key}) : super(key: key);

  final List<Map<String, String>> transactions = const [
    {
      "date": "Oct 8, 2024",
      "service": "Haircut",
      "price": "Rp 50.000",
    },
    {
      "date": "Sept 6, 2024",
      "service": "Creambath Scalp",
      "price": "Rp 90.000",
    },
    {
      "date": "Aug 7, 2024",
      "service": "Mustache Trim",
      "price": "Rp 40.000",
    },
    {
      "date": "Jul 12, 2024",
      "service": "Beard Trim, Mustache Trim",
      "price": "Rp 85.000",
    },
    {
      "date": "Jun 15, 2024",
      "service": "Shaving, Haircut, Coloring",
      "price": "Rp 150.000",
    },
  ];

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
      body: Card(
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
                      side: const BorderSide(color: Color(0xFFE0AC53), width: 1.5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            transaction["date"]!,
                            style: const TextStyle(color: Colors.white, fontSize: 14, fontFamily: 'Inter'),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            transaction["service"]!,
                            style: const TextStyle(color: Colors.white, fontSize: 16, fontFamily: 'Inter'),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            transaction["price"]!,
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
                                  MaterialPageRoute(builder: (context) => const ReviewPage()),
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
                   // Prevents adding extra space after the last card
                    const SizedBox(height: 12),
                ],
              );
            },
          ),
        ),
      ),
      backgroundColor: Colors.black,
    );
  }
}