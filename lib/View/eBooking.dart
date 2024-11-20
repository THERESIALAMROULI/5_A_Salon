import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

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
  @override
  Widget build(BuildContext context) {
    final String qrData = 'https://youtu.be/NY0ffyEu6uo?si=JZs_wMSXWfnC-OF_';

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Color(0xFFE0AC53)),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            'E-Booking',
            style: TextStyle(
              color: Color(0xFFE0AC53),
              fontSize: 24,
              fontWeight: FontWeight.bold,
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
                  color: Color(0xFFE0AC53),
                  margin: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
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
                              value: '1564550825747980288',
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
                              value: 'Rp. 112.000',
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
                                  Text(
                                    'ID BOOKING',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 18,
                                      vertical: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Color(0xFFE5C692),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      'WS23XNHR',
                                      style: TextStyle(
                                        color: Color(0xFFF8EFE0),
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
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
                          color: Color(0xFF1C1B1B),
                          margin: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
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
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 16.0),
                                    child: Text(
                                      '*Scan QR at Barbershop',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                        fontStyle: FontStyle.italic,
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
                        // ini share, rencanannya pdf langsung ke wa atau email gitu
                      },
                    ),
                    const SizedBox(width: 24),
                    _buildActionButton(
                      icon: Icons.print,
                      label: 'Print',
                      onPressed: () {
                        // print pdf nanti disini
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Transactions that have been confirmed cannot be refunded/changed',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                      ),
                    ),
                    const Divider(
                      color: Color(0xFF2D2211),
                      thickness: 1,
                      height: 16,
                    ),
                    Text(
                      'Atma Barber',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'NPWP: 012.345.678.9-000.000\nJl. Malioboro No. 99, Gedung A Lt. 2\nYogyakarta, Daerah Istimewa Yogyakarta - 55271',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
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
                      child: Text(
                        'Need help? Contact us',
                        style: TextStyle(
                          color: Color(0xFFE0AC53),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
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
          style: TextStyle(
            color: Color(0xFFEED1A0),
            fontSize: 11,
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          children: [
            Text(
              value,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (isCopyable)
              IconButton(
                icon: Icon(
                  Icons.copy,
                  size: 16,
                  color: Color(0xFFA57B33),
                ),
                onPressed: () {
                  // nanti salinnya disini tapi gak tahu caranya gimana :<
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
          color: Color(0xFFE0AC53),
        ),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: onPressed,
          child: Text(
            label,
            style: TextStyle(
              color: Color(0xFFE0AC53),
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}
