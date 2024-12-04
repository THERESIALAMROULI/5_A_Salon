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
        title: const Text(
          'Transaction History',
          style: TextStyle(
            color: Colors.white, 
          ),
        ),
        centerTitle: true, 
        backgroundColor: Colors.black, 
        iconTheme: const IconThemeData(
          color: Colors.white, 
        ),
      ),
      body: ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          final transaction = transactions[index];
          return Card(
            color: Colors.black,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transaction["date"]!,
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    transaction["service"]!,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    transaction["price"]!,
                    style: const TextStyle(
                      color: Color(0xFFE0AC53),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const ReviewPage()), 
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFE0AC53),
                          shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0), 
                                ),
                        ),
                        child: const Text(
                          'Review',
                          style: TextStyle(
                            color: Colors.white, 
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {
                          
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFE0AC53),
                          shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0), 
                                ),
                        ),
                        child: const Text(
                          'Book again',
                          style: TextStyle(
                            color: Colors.white, 
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
      backgroundColor: Colors.black,
    );
  }
}
