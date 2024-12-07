import 'package:flutter/material.dart';
import 'package:tubesfix/View/payment.dart';
import 'package:tubesfix/View/paymentMethod.dart';

class TransactionListItem extends StatelessWidget {
  final String nama;
  final int quantity;
  final int price;

  const TransactionListItem({
    super.key,
    required this.nama,
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
              nama,
              style: const TextStyle(color: Colors.white, fontFamily: 'Inter', fontSize: 14, fontWeight: FontWeight.w600),
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
                  style: const TextStyle(color: Colors.white, fontFamily: 'Inter', fontSize: 12, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              'Rp. ${price.toStringAsFixed(0)}',
              textAlign: TextAlign.right,
              style: const TextStyle(color: Colors.white, fontFamily: 'Inter', fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

class transactionView extends StatefulWidget {
  final Map dataformat;
  final Map? data;

  const transactionView({super.key, required this.dataformat, this.data});

  @override
  _transactionViewState createState() => _transactionViewState();
}

class _transactionViewState extends State<transactionView> {

  String selectedPaymentMethod = "Bank Rakyat Indonesia"; 
  String selectedPaymentIcon = "assets/images/icon_bri.png"; 

  final paymentOptions = {
    "Bank Rakyat Indonesia": "assets/images/icon_bri.png",
    "Bank Negara Indonesia": "assets/images/icon_bni.png",
    "Bank Central Asia": "assets/images/icon_bca.png",
    "Bank Mandiri": "assets/images/icon_mandiri.png",
    "Bank Syariah Indonesia": "assets/images/icon_bsi.png",
    "Bank Papua": "assets/images/icon_bankpapua.png", 
    "Bank BPD DIY": "assets/images/icon_bpd.png",     
    "DANA": "assets/images/icon_dana.png",
    "OVO": "assets/images/icon_ovo.png",
    "Gopay": "assets/images/icon_gopay.png",
  };

  @override
  Widget build(BuildContext context) {
    String name = widget.dataformat['nama'] ?? 'Guest';
    List services = widget.dataformat['prices'] ?? [];
    int total = widget.dataformat['total'] ?? 0;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
            'Transaction',
            style: TextStyle(
              color: Color(0xFFE0AC53),
              fontFamily: 'Inter',
              fontSize: 24,
              fontWeight: FontWeight.w700,
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
                          'Hi $name!',
                          style: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'Inter',
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          "Let's complete the transaction",
                          style: TextStyle(color: Colors.grey, fontFamily: 'Inter',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: const [
                            Icon(Icons.list_alt, color: Color(0xFFE0AC53)),
                            SizedBox(width: 8),
                            Text(
                              'Transaction List',
                              style: TextStyle(
                                color: Color(0xFFE0AC53),
                                fontFamily: 'Inter',
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        const Divider(color: Color(0xFFE0AC53)),
                        ...services.map((service) {
                          return TransactionListItem(
                            nama: service['name'],
                            quantity: 1,
                            price: service['price'],
                          );
                        }).toList(),

                        const Divider(color: Color(0xFFE0AC53)),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'SubTotal',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Inter', fontSize: 14, fontWeight: FontWeight.w600
                                ),
                              ),
                              Text(
                                'Rp. $total',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Inter', fontSize: 14, fontWeight: FontWeight.w600
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: const [
                            Icon(Icons.account_balance_wallet, color: Color(0xFFE0AC53)),
                            SizedBox(width: 8),
                            Text(
                              'Payment Method',
                              style: TextStyle(
                                color: Color(0xFFE0AC53),
                                fontFamily: 'Inter', fontSize: 16, fontWeight: FontWeight.w700
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            border: Border.all(color: Color(0xFFE0AC53)),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Image.asset(
                                selectedPaymentIcon,
                                width: 50,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      selectedPaymentMethod,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Inter', fontSize: 14, fontWeight: FontWeight.w600
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: Colors.grey[800],
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: const Text(
                                        'Selected',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Inter', fontSize: 12, fontWeight: FontWeight.w600
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            foregroundColor: const Color(0xFFE0AC53),
                            side: const BorderSide(color: Color(0xFFE0AC53)),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PaymentMethodScreen(),
                              ),
                            );
                            if (result != null && paymentOptions.containsKey(result)) {
                              setState(() {
                                selectedPaymentMethod = result;
                                selectedPaymentIcon = paymentOptions[result]!;
                                print("Selected Method: $selectedPaymentMethod");
                                print("Selected Icon: $selectedPaymentIcon");
                              });
                            }else{
                              print("null");
                            }
                          },
                          child: const Center(
                            child: Text(
                              'Select Other Payments',
                              style: TextStyle(
                                fontFamily: 'Inter', fontSize: 16, fontWeight: FontWeight.w600
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        // VoucherSection(),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE0AC53),
                    minimumSize: const Size.fromHeight(50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PaymentView(
                          total: total,
                          bankName: selectedPaymentMethod, 
                          bankIcon: selectedPaymentIcon,
                          dataformat: widget.dataformat,
                          data: widget.data,
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    'Continue Payment',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Inter', fontSize: 16, fontWeight: FontWeight.w600
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
                    fontFamily: 'Inter', fontSize: 16, fontWeight: FontWeight.w700
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
                      fontFamily: 'Inter', fontSize: 14, fontWeight: FontWeight.w600
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
