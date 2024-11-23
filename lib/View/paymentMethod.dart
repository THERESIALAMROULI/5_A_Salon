import 'package:flutter/material.dart';

// Halaman utama untuk Payment Method
class PaymentMethodScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("PaymentMethodScreen loaded");
    return Scaffold(
      backgroundColor: Colors.black,
      body: PaymentMethodPage(),
    );
  }
}

// Widget utama untuk menampilkan halaman pembayaran
class PaymentMethodPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Judul Halaman
                    Text(
                      "Payment Method",
                      style: TextStyle(
                        color: Color(0xFFE0AC53),
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),

                    // Virtual Account Section
                    _buildSectionTitle("Virtual Account"),
                    SizedBox(height: 8),
                    _buildPaymentOptions(context, isVirtualAccount: true),

                    SizedBox(height: 16),

                    // E-Wallet Section
                    _buildSectionTitle("E-Wallet"),
                    SizedBox(height: 8),
                    _buildPaymentOptions(context, isVirtualAccount: false),
                  ],
                ),
              ),
            ),
          ),

          // Tombol Select Payment di bagian bawah
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildSelectPaymentButton(),
          ),
        ],
      ),
    );
  }

  // Fungsi untuk membuat judul section
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(color: Colors.white, fontSize: 18),
    );
  }

  // Fungsi untuk membuat daftar opsi pembayaran
  Widget _buildPaymentOptions(BuildContext context, {required bool isVirtualAccount}) {
    final options = isVirtualAccount
        ? [
            {"icon": "assets/images/icon_bri.png", "label": "Bank Rakyat Indonesia"},
            {"icon": "assets/images/icon_bni.png", "label": "Bank Negara Indonesia"},
            {"icon": "assets/images/icon_bca.png", "label": "Bank Central Asia"},
            {"icon": "assets/images/icon_mandiri.png", "label": "Bank Mandiri"},
            {"icon": "assets/images/icon_bsi.png", "label": "Bank Syariah Indonesia"},
            {"icon": "assets/images/icon_bankpapua.png", "label": "Bank Papua"},
          ]
        : [
            {"icon": "assets/images/icon_dana.png", "label": "DANA Rp. 23,000"},
            {"icon": "assets/images/icon_ovo.png", "label": "OVO Rp. 45,000"},
            {"icon": "assets/images/icon_gopay.png", "label": "Gopay Tautkan"},
          ];

    return Column(
      children: options
          .map((option) => _buildPaymentOptionRow(
                context,
                iconPath: option['icon']!,
                label: option['label']!,
              ))
          .toList(),
    );
  }

  // Fungsi untuk membuat baris opsi pembayaran
  Widget _buildPaymentOptionRow(BuildContext context, {required String iconPath, required String label}) {
    return Row(
      children: [
        Image.asset(iconPath, width: 36, height: 36), // Ukuran ikon
        SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: TextStyle(color: Colors.white),
          ),
        ),
        Radio(
          value: label,
          groupValue: null, // Placeholder untuk state management
          onChanged: (value) {},
          activeColor: Color(0xFFE0AC53),
        ),
      ],
    );
  }

  // Fungsi untuk membuat tombol Select Payment
  Widget _buildSelectPaymentButton() {
    return ElevatedButton(
      onPressed: () {}, // Fungsi untuk melanjutkan pembayaran
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFFE0AC53),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        minimumSize: Size(double.infinity, 50),
      ),
      child: Text(
        "Select Payment",
        style: TextStyle(color: Colors.black, fontSize: 16),
      ),
    );
  }
}

// Fungsi utama aplikasi
void main() {
  runApp(MaterialApp(
    home: PaymentMethodScreen(),
    debugShowCheckedModeBanner: false,
  ));
}