import 'dart:math';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tubesfix/View/pdfViewer.dart';

class CouponEdge extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final double radius = 8;

    for (double x = 0; x <= size.width; x += radius * 2) {
      path.addOval(Rect.fromCircle(
        center: Offset(x + radius, radius),
        radius: radius,
      ));
    }

    path.addRect(Rect.fromLTWH(0, radius, size.width, size.height - radius));

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class EBookingView extends StatelessWidget {
  final int total;
  final Map dataformat;
  final Map? data;

  const EBookingView({Key? key, required this.total, required this.dataformat, this.data}) : super(key: key);

  String _generateOrderNumber() {
    final random = Random();
    return List.generate(18, (_) => random.nextInt(10).toString()).join();
  }

  String _generateBookingID() {
    final random = Random();
    const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    return List.generate(8, (_) => characters[random.nextInt(characters.length)])
        .join();
  }

  @override
  Widget build(BuildContext context) {
    final String orderNumber = _generateOrderNumber(); 
    final String bookingID = _generateBookingID(); 
    final String qrData = 'https://youtu.be/NY0ffyEu6uo?si=JZs_wMSXWfnC-OF_';

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
            'E-Booking',
            style: TextStyle(
              color: Color(0xFFE0AC53),
              fontFamily: 'Inter',
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 16),
                Card(
                  color: const Color(0xFFE0AC53),
                  margin: EdgeInsets.zero,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildDetailRow(
                              label: 'ORDER NUMBER',
                              value: orderNumber,
                              isCopyable: true,
                            ),
                            const Divider(
                              color: Color(0xFFB98F48),
                              thickness: 1,
                              height: 8,
                            ),
                            _buildDetailRow(
                              label: 'PAYMENT METHODS',
                              value: 'Bank Transfer',
                            ),
                            const SizedBox(height: 8),
                            _buildDetailRow(
                              label: 'TOTAL COST',
                              value: 'Rp. ${total.toStringAsFixed(0)}',
                            ),
                            const SizedBox(height: 8),
                            _buildDetailRow(
                              label: 'APPOINTMENT DATE',
                              value: '01 Jan 2024',
                            ),
                            const SizedBox(height: 16),
                            Center(
                              child: Column(
                                children: [
                                  const Text(
                                    'ID BOOKING',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Inter',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 18,
                                      vertical: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFE5C692),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      bookingID, 
                                      style: const TextStyle(
                                        color: Color(0xFFF8EFE0),
                                        fontFamily: 'Inter',
                                        fontSize: 18,
                                        fontWeight: FontWeight.w900
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      ClipPath(
                        clipper: CouponEdge(),
                        child: Card(
                          color: const Color(0xFF1C1B1B),
                          margin: EdgeInsets.zero,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(16),
                              bottomRight: Radius.circular(16),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 16, bottom: 16),
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: QrImageView(
                                    data: qrData,
                                    size: 130,
                                    backgroundColor: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: const Padding(
                                    padding: EdgeInsets.only(left: 16.0),
                                    child: Text(
                                      '*Scan QR at Barbershop',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontFamily: 'Inter',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _buildActionButton(
                      icon: Icons.share,
                      label: 'Share',
                      onPressed: () {
                      },
                    ),
                    const SizedBox(width: 24),
                    _buildActionButton(
                      icon: Icons.print,
                      label: 'Print',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PdfViewerPage(
                              bookingID: bookingID,
                              name: dataformat["nama"], 
                              email: data?['email'] ?? "guest@guest.com",
                              phoneNumber: data?['phone'] ?? "08123456789", 
                              total: total,
                              date: "20 Sept 2024", 
                              publicationDate: "16 Sept 2024", 
                              services: dataformat['servicesPdf'],
                              data: data,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Transactions that have been confirmed cannot be refunded/changed',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.red,
                        fontFamily: 'Inter',
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Divider(
                      color: Color(0xFF2D2211),
                      thickness: 1,
                      height: 16,
                    ),
                    const Text(
                      'Atma Barber',
                      style: TextStyle(
                        color: Colors.grey,
                        fontFamily: 'Inter',
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'NPWP: 012.345.678.9-000.000\nJl. Malioboro No. 99, Gedung A Lt. 2\nYogyakarta, Daerah Istimewa Yogyakarta - 55271',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.grey,
                        fontFamily: 'Inter',
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Divider(
                      color: Color(0xFF2D2211),
                      thickness: 1,
                      height: 16,
                    ),
                    GestureDetector(
                      onTap: () {
                      },
                      child: const Text(
                        'Need help? Contact us',
                        style: TextStyle(
                          color: Color(0xFFE0AC53),
                          fontFamily: 'Inter',
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow({
    required String label,
    required String value,
    bool isCopyable = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFFEED1A0),
            fontFamily: 'Inter',
            fontSize: 11,
            fontWeight: FontWeight.w600
          ),
        ),
        Row(
          children: [
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontFamily: 'Inter',
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
            if (isCopyable)
              IconButton(
                icon: const Icon(
                  Icons.copy,
                  size: 16,
                  color: Color(0xFFA57B33),
                ),
                onPressed: () {
                },
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          color: const Color(0xFFE0AC53),
        ),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: onPressed,
          child: Text(
            label,
            style: const TextStyle(
              color: Color(0xFFE0AC53),
              fontFamily: 'Inter',
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}
