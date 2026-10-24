import 'package:flutter/material.dart';

/// PaymentMethodScreen allows customers to choose their preferred bank for Virtual Account payment.
/// Polished with Atma Barber's dark-and-gold card design system.
class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  String? selectedPaymentMethod;

  final paymentOptions = const [
    {"icon": "assets/images/icon_bri.png", "label": "Bank Rakyat Indonesia"},
    {"icon": "assets/images/icon_bni.png", "label": "Bank Negara Indonesia"},
    {"icon": "assets/images/icon_bca.png", "label": "Bank Central Asia"},
    {"icon": "assets/images/icon_mandiri.png", "label": "Bank Mandiri"},
    {"icon": "assets/images/icon_bsi.png", "label": "Bank Syariah Indonesia"},
    {"icon": "assets/images/icon_bankpapua.png", "label": "Bank Papua"}, 
    {"icon": "assets/images/icon_bpd.png", "label": "Bank BPD DIY"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFE0AC53)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Pilih Metode Pembayaran",
          style: TextStyle(
            color: Color(0xFFE0AC53),
            fontFamily: 'Inter',
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionHeader("Virtual Account Bank", Icons.account_balance_rounded),
                    const SizedBox(height: 12),
                    ...paymentOptions.map((option) => _buildPaymentOption(
                          iconPath: option['icon']!,
                          label: option['label']!,
                        )),
                    const SizedBox(height: 16),
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
                        "Silakan pilih metode pembayaran bank terlebih dahulu",
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.redAccent,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE0AC53),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                minimumSize: const Size(double.infinity, 50),
                elevation: 4,
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check_circle_outline, color: Colors.black, size: 20),
                  SizedBox(width: 8),
                  Text(
                    "Gunakan Metode Ini",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Inter',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFFE0AC53), size: 20),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            color: Color(0xFFE0AC53),
            fontFamily: 'Inter',
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentOption({required String iconPath, required String label}) {
    final isSelected = selectedPaymentMethod == label;

    return Card(
      color: Colors.grey[900],
      margin: const EdgeInsets.only(bottom: 10.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(
          color: isSelected ? const Color(0xFFE0AC53) : const Color(0xFFE0AC53).withOpacity(0.25),
          width: isSelected ? 1.8 : 1.0,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () {
          setState(() {
            selectedPaymentMethod = label;
          });
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFE0AC53).withOpacity(0.3)),
                ),
                child: Image.asset(
                  iconPath,
                  width: 50,
                  height: 32,
                  errorBuilder: (_, __, ___) => const Icon(
                    Icons.account_balance,
                    color: Color(0xFFE0AC53),
                    size: 28,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    color: isSelected ? const Color(0xFFE0AC53) : Colors.white,
                    fontFamily: 'Inter',
                    fontSize: 14,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                  ),
                ),
              ),
              Radio<String>(
                value: label,
                groupValue: selectedPaymentMethod,
                onChanged: (value) {
                  setState(() {
                    selectedPaymentMethod = value;
                  });
                },
                activeColor: const Color(0xFFE0AC53),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
