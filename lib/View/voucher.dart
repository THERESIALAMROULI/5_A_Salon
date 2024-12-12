import 'package:flutter/material.dart';

class VoucherPage extends StatelessWidget {
  const VoucherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, 
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
          'Vouchers',
          style: TextStyle(
            color: Color(0xFFE0AC53),
            fontFamily: 'Inter',
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: 5, 
                itemBuilder: (context, index) {
                  return VoucherCard(index: index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class VoucherCard extends StatelessWidget {
  final int index;
  const VoucherCard({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      color: Color(0xFFE0AC53), 
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        title: Text(
          'Voucher #${index + 1}', 
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white, 
          ),
        ),
        subtitle: const Text(
          'Expires: 31/12/2024',
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
        trailing: ElevatedButton(
          onPressed: () {

            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Voucher Redeemed'),
                content: const Text('You have redeemed this voucher.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
          },
          child: const Text('Use'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFFE0AC53),  
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            side: BorderSide(
              color: Colors.black, 
              width: 1, 
            ),
          ),
        ),
      ),
    );
  }
}
