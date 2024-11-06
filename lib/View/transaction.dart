import 'package:flutter/material.dart';

class transactionView extends StatelessWidget {
  const transactionView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: TransactionScreen(),
        ),
      ),
    );
  }
}

class TransactionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Transaction',
            style: TextStyle(
              color: Colors.orange,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Card(
            color: Colors.grey[900],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hi Budi!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Let's complete the transaction",
                    style: TextStyle(color: Colors.white),
                  ),
                  const Divider(color: Colors.grey),
                  TransactionListItem(name: 'Haircut', quantity: 1, price: 70000),
                  TransactionListItem(name: 'Treatment', quantity: 1, price: 90000),
                  TransactionListItem(name: 'Voucher', quantity: -1, price: 48000),
                  const Divider(color: Colors.grey),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('SubTotal', style: TextStyle(color: Colors.white)),
                        Text('Rp. 112.000', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  PaymentMethodSection(),
                  const SizedBox(height: 8),
                  VoucherSection(),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              minimumSize: const Size.fromHeight(50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            onPressed: () {},
            child: const Text(
              'Continue Payment',
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}

class TransactionListItem extends StatelessWidget {
  final String name;
  final int quantity;
  final int price;

  const TransactionListItem({
    required this.name,
    required this.quantity,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('$name x $quantity', style: TextStyle(color: Colors.white)),
          Text('Rp. ${price.abs()}', style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}

class PaymentMethodSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Payment Method', style: TextStyle(color: Colors.orange)),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.orange),
            borderRadius: BorderRadius.circular(8),
          ),
          child: ListTile(
            leading: Image.asset(
              'assets/bri_logo.png', // Add your logo here
              width: 40,
            ),
            title: Text('Bank Rakyat Indonesia', style: TextStyle(color: Colors.white)),
            trailing: Icon(Icons.radio_button_checked, color: Colors.orange),
          ),
        ),
        TextButton(
          onPressed: () {},
          child: const Text('Select Other Payments', style: TextStyle(color: Colors.orange)),
        ),
      ],
    );
  }
}

class VoucherSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.orange),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: Icon(Icons.card_giftcard, color: Colors.orange),
        title: Text('Voucher', style: TextStyle(color: Colors.orange)),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text('Rp.48.000', style: TextStyle(color: Colors.black)),
        ),
      ),
    );
  }
}
