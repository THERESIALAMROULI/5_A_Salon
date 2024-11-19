import 'package:flutter/material.dart';
import 'package:tubesfix/View/payment.dart';


class transactionView extends StatelessWidget {
  final Map? data;

  const transactionView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    String username = data?['username'] ?? 'Guest';
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Color(0xFFE0AC53)),
            onPressed: () {},
          ),
          title: Text(
            'Transaction',
            style: TextStyle(
              color: Color(0xFFE0AC53),
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                          'Hi $username!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Let's complete the transaction",
                          style: TextStyle(color: Colors.grey[400]),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Icon(Icons.list_alt, color: Color(0xFFE0AC53)),
                            const SizedBox(width: 8),
                            Text(
                              'Transaction List',
                              style: TextStyle(
                                color: Color(0xFFE0AC53),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const Divider(color: Color(0xFFE0AC53)),
                        const TransactionListItem(
                          name: 'Haircut',
                          quantity: 1,
                          price: 70000,
                        ),
                        const TransactionListItem(
                          name: 'Treatment',
                          quantity: 1,
                          price: 90000,
                        ),
                        const TransactionListItem(
                          name: 'Voucher',
                          quantity: 1,
                          price: -48000,
                        ),
                        const Divider(color: Color(0xFFE0AC53)),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('SubTotal',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  )),
                              Text('Rp. 112.000',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        PaymentMethodSection(),
                        const SizedBox(height: 16),
                        VoucherSection(),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFE0AC53),
                    minimumSize: const Size.fromHeight(50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PaymentView()),
                    );
                  },
                  child: const Text(
                    'Continue Payment',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TransactionListItem extends StatelessWidget {
  final String name;
  final int quantity;
  final int price;

  const TransactionListItem({
    super.key,
    required this.name,
    required this.quantity,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              name,
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),

          Expanded(
            flex: 1,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '× $quantity',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            ),
          ),

          Expanded(
            flex: 2,
            child: Text(
              '${price < 0 ? '-' : ''}Rp. ${price.abs()}',
              textAlign: TextAlign.right,
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
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
        Row(
          children: [
            Icon(Icons.account_balance_wallet, color: Color(0xFFE0AC53)),
            const SizedBox(width: 8),
            Text(
              'Payment Method',
              style: TextStyle(
                color: Color(0xFFE0AC53),
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xFFE0AC53)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Image.asset(
                'assets/images/icon_bri.png', 
                width: 50,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bank Rakyat Indonesia',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'Last Used',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.radio_button_checked, color: Color(0xFFE0AC53)),
            ],
          ),
        ),
        
        const SizedBox(height: 16),
        
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            foregroundColor: Color(0xFFE0AC53), 
            side: BorderSide(color: Color(0xFFE0AC53)), 
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: () {},
          child: Center(
            child: Text(
              'Select Other Payments',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class VoucherSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.percent, color: Color(0xFFE0AC53)),
                const SizedBox(width: 8),
                Text(
                  'Voucher',
                  style: TextStyle(
                    color: Color(0xFFE0AC53),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xFFE0AC53)),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                children: [
                  Icon(Icons.receipt_long, color: Color(0xFFE0AC53), size: 18),
                  const SizedBox(width: 4),
                  Text(
                    '-Rp48RB',
                    style: TextStyle(
                      color: Color(0xFFE0AC53),
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        const Divider(
          color: Color(0xFFE0AC53),
          thickness: 1,
        ),
      ],
    );
  }
}

