import 'package:flutter/material.dart';

class PaymentMethodScreen extends StatefulWidget {
  @override
  _PaymentMethodScreenState createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  String? selectedPaymentMethod; 

  @override
  Widget build(BuildContext context) {
    final paymentOptions = [
      {"icon": "assets/images/icon_bri.png", "label": "Bank Rakyat Indonesia"},
      {"icon": "assets/images/icon_bni.png", "label": "Bank Negara Indonesia"},
      {"icon": "assets/images/icon_bca.png", "label": "Bank Central Asia"},
      {"icon": "assets/images/icon_mandiri.png", "label": "Bank Mandiri"},
      {"icon": "assets/images/icon_bsi.png", "label": "Bank Syariah Indonesia"},
      {"icon": "assets/images/icon_bankpapua.png", "label": "Bank Papua"}, 
      {"icon": "assets/images/icon_bpd.png", "label": "Bank BPD DIY"},
    ];

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
          "Payment Method",
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
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionHeader("Virtual Account", Icons.swap_horiz),
                    const SizedBox(height: 8),
                    ...paymentOptions.sublist(0, 7).map((option) => _buildPaymentOption(
                          iconPath: option['icon']!,
                          label: option['label']!,
                        )), 
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),

            ElevatedButton(
              onPressed: () {
                if (selectedPaymentMethod != null) {
                  Navigator.pop(context, selectedPaymentMethod); 
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Please select a payment method!",
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE0AC53),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text(
                "Select Payment",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Inter', fontSize: 16, fontWeight: FontWeight.w600
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFFE0AC53)),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            color: Color(0xFFE0AC53),
            fontFamily: 'Inter', fontSize: 18, fontWeight: FontWeight.w900
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentOption({required String iconPath, required String label}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      children: [
        Image.asset(
          iconPath,
          width: 55,
          height: 55,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(color: Color(0xFFE0AC53), fontFamily: 'Inter', fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ),
        Radio<String>(
          value: label,
          groupValue: selectedPaymentMethod,
          onChanged: (value) {
            setState(() {
              selectedPaymentMethod = value; 
              print("Selected Payment Method: $selectedPaymentMethod"); 
            });
          },
          activeColor: const Color(0xFFE0AC53),
        ),
      ],
    ),
  );
}



}
