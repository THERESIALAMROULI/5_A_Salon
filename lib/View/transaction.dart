import 'package:flutter/material.dart';
import 'package:tubesfix/View/payment.dart';
import 'package:tubesfix/View/paymentMethod.dart';
import 'package:tubesfix/View/voucher.dart';

/// TransactionListItem displays a single selected grooming service and its price.
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
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: const Color(0xFFE0AC53).withOpacity(0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.check_rounded, color: Color(0xFFE0AC53), size: 14),
              ),
              const SizedBox(width: 10),
              Text(
                nama,
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'Inter',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Text(
            'Rp $price',
            style: const TextStyle(
              color: Color(0xFFE0AC53),
              fontFamily: 'Inter',
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

/// transactionView displays the order breakdown, selected services, subtotal,
/// and payment method choice before proceeding to payment.
class transactionView extends StatefulWidget {
  final Map dataformat;
  final Map? data;

  const transactionView({super.key, required this.dataformat, this.data});

  @override
  State<transactionView> createState() => _transactionViewState();
}

class _transactionViewState extends State<transactionView> {
  String selectedPaymentMethod = "Bank Rakyat Indonesia"; 
  String selectedPaymentIcon = "assets/images/icon_bri.png"; 

  final paymentOptions = const {
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
    final String name = widget.dataformat['nama'] ?? 'Pelanggan';
    final List services = widget.dataformat['prices'] ?? [];
    final int total = widget.dataformat['total'] ?? 0;
    final String serviceNames = services.map((service) => service['name']).join(', ');

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
          'Konfirmasi Pesanan',
          style: TextStyle(
            color: Color(0xFFE0AC53),
            fontFamily: 'Inter',
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Customer Greeting Card
            Card(
              color: Colors.grey[900],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(color: const Color(0xFFE0AC53).withOpacity(0.3), width: 1.2),
              ),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE0AC53).withOpacity(0.15),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.person_rounded, color: Color(0xFFE0AC53), size: 22),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Halo, $name!',
                              style: const TextStyle(
                                color: Colors.white,
                                fontFamily: 'Inter',
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const Text(
                              "Periksa detail pemesanan salon Anda",
                              style: TextStyle(
                                color: Colors.grey,
                                fontFamily: 'Inter',
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Divider(color: Color(0xFFE0AC53), height: 1),
                    const SizedBox(height: 14),

                    // Transaction List Title
                    Row(
                      children: const [
                        Icon(Icons.receipt_long_rounded, color: Color(0xFFE0AC53), size: 18),
                        SizedBox(width: 8),
                        Text(
                          'Daftar Layanan Dipilih',
                          style: TextStyle(
                            color: Color(0xFFE0AC53),
                            fontFamily: 'Inter',
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // Services Items List
                    ...services.map((service) {
                      return TransactionListItem(
                        nama: service['name'],
                        quantity: 1,
                        price: (service['price'] as num).toInt(),
                      );
                    }).toList(),

                    const SizedBox(height: 10),
                    const Divider(color: Color(0xFFE0AC53), height: 1),
                    const SizedBox(height: 12),

                    // Subtotal Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Subtotal',
                          style: TextStyle(
                            color: Colors.white70,
                            fontFamily: 'Inter',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'Rp $total',
                          style: const TextStyle(
                            color: Color(0xFFE0AC53),
                            fontFamily: 'Inter',
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Payment Method Header
                    Row(
                      children: const [
                        Icon(Icons.account_balance_wallet_rounded, color: Color(0xFFE0AC53), size: 18),
                        SizedBox(width: 8),
                        Text(
                          'Metode Pembayaran',
                          style: TextStyle(
                            color: Color(0xFFE0AC53),
                            fontFamily: 'Inter',
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // Selected Payment Card
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        border: Border.all(color: const Color(0xFFE0AC53).withOpacity(0.5)),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.grey[900],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Image.asset(
                              selectedPaymentIcon,
                              width: 44,
                              height: 28,
                              errorBuilder: (_, __, ___) => const Icon(
                                Icons.account_balance,
                                color: Color(0xFFE0AC53),
                                size: 28,
                              ),
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  selectedPaymentMethod,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Inter',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                const Text(
                                  "Virtual Account",
                                  style: TextStyle(color: Colors.grey, fontSize: 11),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE0AC53).withOpacity(0.15),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Text(
                              'Terpilih',
                              style: TextStyle(
                                color: Color(0xFFE0AC53),
                                fontFamily: 'Inter',
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Button to change payment method
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: const Color(0xFFE0AC53).withOpacity(0.6)),
                        minimumSize: const Size.fromHeight(44),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PaymentMethodScreen(),
                          ),
                        );
                        if (result != null && paymentOptions.containsKey(result)) {
                          setState(() {
                            selectedPaymentMethod = result;
                            selectedPaymentIcon = paymentOptions[result]!;
                          });
                        }
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.swap_horiz_rounded, color: Color(0xFFE0AC53), size: 18),
                          SizedBox(width: 6),
                          Text(
                            'Ganti Metode Pembayaran Lain',
                            style: TextStyle(
                              color: Color(0xFFE0AC53),
                              fontFamily: 'Inter',
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Continue to Payment Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE0AC53),
                minimumSize: const Size.fromHeight(52),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 4,
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
                      layananAmbil: serviceNames,
                      data: widget.data,
                    ),
                  ),
                );
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.lock_outline_rounded, color: Colors.black, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'Lanjutkan ke Pembayaran',
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
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
