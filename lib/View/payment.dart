import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:tubesfix/View/eBooking.dart';
import 'package:intl/intl.dart'; 
import 'package:flutter/services.dart';
import 'package:tubesfix/client/PelangganClient.dart';
import 'package:tubesfix/client/PesananClient.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PaymentView extends StatefulWidget {
  final int total;
  final String bankName; 
  final String bankIcon;
  final Map dataformat;
  final Map? data;

  const PaymentView({
    Key? key,
    required this.total,
    required this.bankName,
    required this.bankIcon,
    required this.dataformat,
    this.data
  }) : super(key: key);

  @override
  _PaymentViewState createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  late Timer _timer;
  Duration _timeRemaining = Duration(hours: 24, minutes: 00, seconds: 00);
  late Map? data;
  late String dueDate;
  late String Stringdate = widget.dataformat['date'].toLocal().toString().split(' ')[0];

  int _idPelanggan = 0;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  final PelangganClient _pelangganClient = PelangganClient();

  Future<void> _createPesanan(String bookingID, BuildContext context) async {
    final PesananClient pesananClient = PesananClient();
    final storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token');

    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("User not authenticated")),
      );
      return;
    }

    try {
      final result = await pesananClient.createPesanan(
        token: token,
        idPelanggan: _idPelanggan, 
        idBarber: widget.dataformat['id_barber'], 
        tanggalPesanan: Stringdate, 
        namaPemesan: widget.dataformat['nama'], 
        kodeBooking: bookingID, 
      );

      if (result) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Pesanan berhasil dibuat")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Gagal membuat pesanan: $e")),
      );
    }
  }

  @override
  void initState() {
  super.initState();
  _startCountdownTimer();
  data = widget.data;
  DateTime now = DateTime.now();
  DateTime dueDateTime = now.add(Duration(days: 1));
  dueDate = DateFormat('MMM dd, yyyy, HH:mm').format(dueDateTime);

  _loadProfileData().then((_) {
    setState(() {}); 
  });
}

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Future<void> _loadProfileData() async {
    try {
      final token = await _storage.read(key: 'token');
      if (token == null) throw Exception("No token found");

      final profileData = await _pelangganClient.fetchProfile(token);
      setState(() {
        _idPelanggan = profileData['id'] ?? "1";
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to load pelanggan ID: $e")),
      );
    }
  }

  void _startCountdownTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_timeRemaining.inSeconds > 0) {
        setState(() {
          _timeRemaining = _timeRemaining - Duration(seconds: 1);
        });
      } else {
        timer.cancel();
      }
    });
  }

  String _generateBookingID() {
    final random = Random();
    const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    return List.generate(8, (_) => characters[random.nextInt(characters.length)])
        .join();
  }

  String _formatTime(Duration duration) {
    String hours = duration.inHours.toString().padLeft(2, '0');
    String minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    String seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return '$hours Hours $minutes Minutes $seconds Seconds';
  }

  Map<String, String> bankVirtualAccounts = {
    "Bank Rakyat Indonesia": "128 0813 4315 5142",
    "Bank Negara Indonesia": "123 4567 8901 2345",
    "Bank Central Asia": "456 7890 1234 5678",
    "Bank Mandiri": "789 0123 4567 8901",
    "Bank Syariah Indonesia": "234 5678 9012 3456",
    "Bank Papua": "345 6789 0123 4567",
    "Bank BPD DIY": "567 8901 2345 6789",
  };

  void copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text)).then((_) {
    });
  }

  @override
  Widget build(BuildContext context) {
    final String bookingID = _generateBookingID(); 
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
            'Payment',
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total Payment',
                              style: TextStyle(color: Colors.white, fontFamily: 'Inter',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,),
                            ),
                            Text(
                              'Rp. ${widget.total}', 
                              style: TextStyle(
                                color: Color(0xFFE0AC53),
                                fontFamily: 'Inter',
                                fontSize: 16,
                                fontWeight: FontWeight.w600,

                              ),
                            ),
                          ],
                        ),
                        const Divider(color: Color(0xFFE0AC53)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Pay In',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Inter',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              _formatTime(_timeRemaining),
                              style: TextStyle(
                                color: Color(0xFFE0AC53),
                                fontFamily: 'Inter',
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'Due $dueDate',
                            style: TextStyle(
                              color: Colors.grey,
                              fontFamily: 'Inter',
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Row(
                          children: [
                            Image.asset(
                              widget.bankIcon,
                              width: 70,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              widget.bankName,
                              style: TextStyle(
                                color: Color(0xFFE0AC53),
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const Divider(color: Color(0xFFE0AC53)),
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Account number',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Inter',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    bankVirtualAccounts[widget.bankName] ?? 'VA Not Found',
                                    style: TextStyle(
                                      color: Color(0xFFE0AC53),
                                      fontFamily: 'Inter',
                                      fontSize: 18,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.copy,
                                      color: Color(0xFFE0AC53),
                                    ),
                                    onPressed: () {
                                      copyToClipboard(bankVirtualAccounts[widget.bankName] ?? 'VA Not Found');
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Divider(color: Color(0xFFE0AC53)),
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 8),
                              Text(
                                'The verification process takes less than 10 minutes after successful payment.',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontFamily: 'Inter',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Pay the order to the Virtual Account above before making another order with the same account number to ensure consistency.',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Inter',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '*Only accepts ${widget.bankName}',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontFamily: 'Inter',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildExpandableInstruction(
                          context,
                          'mBanking Instructions',
                          'Follow these steps to complete your payment via mBanking: \n1. Open your mobile banking app.\n2. Go to the payment section.\n3. Enter the Virtual Account number.\n4. Confirm payment details and make payment.',
                        ),
                        const SizedBox(height: 8),
                        _buildExpandableInstruction(
                          context,
                          'ATM Transfer Instructions',
                          'Follow these steps for ATM Transfer: \n1. Visit any ATM.\n2. Select “Transfer” option.\n3. Choose the "Virtual Account" option.\n4. Enter the account number and payment amount.\n5. Confirm and finish the transaction.',
                        ),
                        const SizedBox(height: 8),
                        _buildExpandableInstruction(
                          context,
                          'EDC Transfer Instructions',
                          'Follow these steps for EDC Transfer: \n1. Visit the nearest EDC terminal.\n2. Select the option for Virtual Account payment.\n3. Enter the account number shown above and confirm.\n4. Complete the payment.',
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE0AC53),
                    minimumSize: const Size.fromHeight(50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () {
                    _createPesanan(bookingID, context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EBookingView(total: widget.total, dataformat: widget.dataformat, data: widget.data, bankName: widget.bankName, idBooking: bookingID, idPelanggan: _idPelanggan), 
                      ),
                    );
                  },
                  child: const Text(
                    'Confirmation',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Inter',
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildExpandableInstruction(BuildContext context, String title, String content) {
    return Card(
      color: Color(0xFFE0AC53),  
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: ExpansionTile(
        tilePadding: EdgeInsets.zero,  
        title: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.black,
              fontFamily: 'Inter',
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  content,
                  style: const TextStyle(
                    color: Colors.black,
                    fontFamily: 'Inter',
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
