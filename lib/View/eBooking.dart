import 'dart:math';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tubesfix/View/pdfViewer.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:tubesfix/View/home.dart';

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
class EBookingView extends StatefulWidget {
  final int total;
  final Map dataformat;
  final Map? data;
  final String bankName;
  final String idBooking;
  final int idPelanggan;

  const EBookingView({
    Key? key,
    required this.total,
    required this.dataformat,
    this.data,
    required this.bankName,
    required this.idBooking,
    required this.idPelanggan,
  }) : super(key: key);

  @override
  _EBookingViewState createState() => _EBookingViewState();
}

class _EBookingViewState extends State<EBookingView> {
  
  String _generateOrderNumber() {
    final random = Random();
    return List.generate(18, (_) => random.nextInt(10).toString()).join();
  }

  String _formatDate(DateTime date) { 
    return DateFormat('dd MMMM yyyy', 'en_US').format(date); 
  }

  String _getCurrentDate() {
    DateTime now = DateTime.now(); 
    return DateFormat('dd MMM yyyy', 'en_US').format(now); 
  }

  void _copyToClipboard(String text, BuildContext context) {
    Clipboard.setData(ClipboardData(text: text));
  }

  Future<void> _openMaps() async {
    const String barbershopLatitude = '-7.779366'; 
    const String barbershopLongitude = '110.416324'; 
    final String googleUrl = "google.navigation:q=$barbershopLatitude,$barbershopLongitude"; 
    
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not launch $googleUrl';
    }
  }

   @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final String orderNumber = _generateOrderNumber(); 

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFE0AC53)),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => HomeView(data: widget.data),  
              ),
            );
          },
        ),
        title: const Text(
          'E-Booking',
          style: TextStyle(
            color: Color(0xFFE0AC53),
            fontFamily: 'Inter',
            fontSize: 22,
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
              const SizedBox(height: 12),
              Card(
                color: const Color(0xFFE0AC53),
                margin: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildDetailRow(
                            label: 'ORDER NUMBER',
                            value: orderNumber,
                            isCopyable: true,
                            onCopy: () => _copyToClipboard(orderNumber, context),
                          ),
                          const Divider(
                            color: Color(0xFFB98F48),
                            thickness: 1,
                            height: 16,
                          ),
                          _buildDetailRow(
                            label: 'PAYMENT METHODS',
                            value: 'Bank Transfer',
                          ),
                          const SizedBox(height: 10),
                          _buildDetailRow(
                            label: 'TOTAL COST',
                            value: 'Rp. ${widget.total.toStringAsFixed(0)}',
                          ),
                          const SizedBox(height: 10),
                          _buildDetailRow(
                            label: 'APPOINTMENT DATE',
                            value: _formatDate(widget.dataformat['date']),
                          ),
                          const SizedBox(height: 18),
                          Center(
                            child: Column(
                              children: [
                                const Text(
                                  'ID BOOKING',
                                  style: TextStyle(
                                    color: Color(0xFF2A200E),
                                    fontFamily: 'Inter',
                                    fontSize: 13,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: const Color(0xFFB98F48),
                                      width: 1.5,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.25),
                                        blurRadius: 6,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    widget.idBooking, 
                                    style: const TextStyle(
                                      color: Color(0xFFE0AC53),
                                      fontFamily: 'Inter',
                                      fontSize: 18,
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: 1.5,
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
                        color: const Color(0xFF181818),
                        margin: EdgeInsets.zero,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(16),
                            bottomRight: Radius.circular(16),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: QrImageView(
                                  data: widget.idBooking,
                                  size: 130,
                                  backgroundColor: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                '*Scan QR code at Barbershop front desk',
                                style: TextStyle(
                                  color: Colors.white54,
                                  fontFamily: 'Inter',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
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
              const SizedBox(height: 18),
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: ElevatedButton.icon(
                      onPressed: _openMaps, 
                      icon: const Icon(Icons.directions, size: 16),
                      label: const Text('Directions'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE0AC53), 
                        foregroundColor: Colors.black, 
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12), 
                        textStyle: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    flex: 3,
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.share_rounded, size: 16),
                      label: const Text('Share'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFFE0AC53),
                        side: const BorderSide(color: Color(0xFFE0AC53)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        textStyle: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    flex: 3,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PdfViewerPage(
                              bookingID: widget.idBooking,
                              name: widget.dataformat["nama"], 
                              email: widget.data?['email'] ?? "guest@example.com",
                              phoneNumber: widget.data?['phone'] ?? "08123456789", 
                              total: widget.total,
                              date: _formatDate(widget.dataformat['date']), 
                              publicationDate: _getCurrentDate(), 
                              services: widget.dataformat['servicesPdf'],
                              data: widget.data,
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.print_rounded, size: 16),
                      label: const Text('PDF'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFFE0AC53),
                        side: const BorderSide(color: Color(0xFFE0AC53)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        textStyle: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFF181818),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.info_outline, color: Colors.amber, size: 16),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Confirmed bookings cannot be refunded or cancelled',
                            style: TextStyle(
                              color: Colors.amber,
                              fontFamily: 'Inter',
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Divider(
                      color: Colors.white12,
                      thickness: 1,
                      height: 20,
                    ),
                    const Text(
                      'Atma Barber & Lounge',
                      style: TextStyle(
                        color: Color(0xFFE0AC53),
                        fontFamily: 'Inter',
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Jl. Malioboro No. 99, Gedung A Lt. 2\nYogyakarta, D.I. Yogyakarta - 55271',
                      style: TextStyle(
                        color: Colors.white60,
                        fontFamily: 'Inter',
                        fontSize: 11,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow({
    required String label,
    required String value,
    bool isCopyable = false,
    VoidCallback? onCopy,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF35260C),
            fontFamily: 'Inter',
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
        Row(
          children: [
            Text(
              value,
              style: const TextStyle(
                color: Colors.black,
                fontFamily: 'Inter',
                fontSize: 13,
                fontWeight: FontWeight.w800,
              ),
            ),
            if (isCopyable)
              IconButton(
                icon: const Icon(
                  Icons.copy,
                  size: 16,
                  color: Color(0xFF2A200E),
                ),
                padding: const EdgeInsets.only(left: 6),
                constraints: const BoxConstraints(),
                onPressed: () {
                  if (onCopy != null) {
                    onCopy();  
                  }
                },
              ),
          ],
        ),
      ],
    );
  }
}
