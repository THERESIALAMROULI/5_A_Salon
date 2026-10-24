import 'package:flutter/material.dart';

/// VoucherPage displays active discount vouchers available for the customer.
/// Styled with Atma Barber's signature dark-gold coupon card aesthetic.
class VoucherPage extends StatelessWidget {
  const VoucherPage({super.key});

  @override
  Widget build(BuildContext context) {
    final vouchers = const [
      {
        'title': 'Diskon New Member 20%',
        'code': 'NEWATMA20',
        'desc': 'Potongan 20% untuk semua layanan potong rambut',
        'expiry': '31 Des 2026',
      },
      {
        'title': 'Diskon Grooming VIP Rp 15.000',
        'code': 'GROOMVIP15',
        'desc': 'Minimal transaksi Rp 50.000 di Atma Barber',
        'expiry': '15 Nov 2026',
      },
      {
        'title': 'Cashback Shaving & Towel Rp 10.000',
        'code': 'SHAVE10K',
        'desc': 'Khusus layanan Hot Towel Shave & Mustache',
        'expiry': '28 Feb 2027',
      },
      {
        'title': 'Paket Komplit Haircut + Treatment',
        'code': 'KOMPLITATMA',
        'desc': 'Potongan Rp 25.000 paket styling lengkap',
        'expiry': '30 Apr 2027',
      },
    ];

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
          'Voucher Promo',
          style: TextStyle(
            color: Color(0xFFE0AC53),
            fontFamily: 'Inter',
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        itemCount: vouchers.length, 
        itemBuilder: (context, index) {
          final item = vouchers[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 14.0),
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(
                color: const Color(0xFFE0AC53).withOpacity(0.35),
                width: 1.2,
              ),
            ),
            color: Colors.grey[900], 
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE0AC53).withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFE0AC53).withOpacity(0.4)),
                    ),
                    child: const Icon(Icons.confirmation_number_outlined, color: Color(0xFFE0AC53), size: 24),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['title']!,
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          item['desc']!,
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 11,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(color: const Color(0xFFE0AC53).withOpacity(0.4)),
                              ),
                              child: Text(
                                item['code']!,
                                style: const TextStyle(
                                  color: Color(0xFFE0AC53),
                                  fontFamily: 'Inter',
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Exp: ${item['expiry']}',
                              style: const TextStyle(fontSize: 11, color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Row(
                            children: [
                              const Icon(Icons.check_circle, color: Colors.black, size: 20),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  "Voucher ${item['code']} berhasil diterapkan!",
                                  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                          backgroundColor: const Color(0xFFE0AC53),
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                      Navigator.pop(context, item);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE0AC53),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      elevation: 2,
                    ),
                    child: const Text(
                      'Pakai',
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Inter',
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
