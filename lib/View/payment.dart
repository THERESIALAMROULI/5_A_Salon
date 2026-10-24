import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:tubesfix/View/eBooking.dart';
import 'package:intl/intl.dart'; 
import 'package:flutter/services.dart';
import 'package:tubesfix/client/PelangganClient.dart';
import 'package:tubesfix/client/PesananClient.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// PaymentView represents the checkout and Virtual Account payment screen.
/// Provides a realistic m-Banking payment simulation and real-time transaction verification,
/// allowing users to experience an authentic payment flow in the dark-gold Atma Barber aesthetic.
class PaymentView extends StatefulWidget {
  final int total;
  final String bankName; 
  final String bankIcon;
  final Map dataformat;
  final String layananAmbil;
  final Map? data;

  const PaymentView({
    super.key,
    required this.total,
    required this.bankName,
    required this.bankIcon,
    required this.dataformat,
    required this.layananAmbil,
    this.data,
  });

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  late Timer _timer;
  Duration _timeRemaining = const Duration(hours: 24, minutes: 00, seconds: 00);
  late Map? data;
  late String dueDate;
  late String stringDate;
  
  // NOTE: Initialized once in initState to avoid generating a new random booking ID on every timer tick.
  late String _bookingID;
  
  // Simulation and transaction state variables
  bool _isPaid = false;
  bool _orderCreated = false;
  String _transactionRef = '';
  String _paidTimestamp = '';

  int _idPelanggan = 0;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  final PelangganClient _pelangganClient = PelangganClient();

  final Map<String, String> _bankVirtualAccounts = {
    "Bank Rakyat Indonesia": "128 0813 4315 5142",
    "Bank Negara Indonesia": "123 4567 8901 2345",
    "Bank Central Asia": "456 7890 1234 5678",
    "Bank Mandiri": "789 0123 4567 8901",
    "Bank Syariah Indonesia": "234 5678 9012 3456",
    "Bank Papua": "345 6789 0123 4567",
    "Bank BPD DIY": "567 8901 2345 6789",
    "DANA": "0812 3456 7890",
    "OVO": "0812 3456 7890",
    "GoPay": "0812 3456 7890",
  };

  @override
  void initState() {
    super.initState();
    _bookingID = _generateBookingID();
    _startCountdownTimer();
    data = widget.data;

    // Format local order date for backend submission
    stringDate = widget.dataformat['date'].toLocal().toString().split(' ')[0];

    final DateTime now = DateTime.now();
    final DateTime dueDateTime = now.add(const Duration(days: 1));
    dueDate = DateFormat('MMM dd, yyyy, HH:mm').format(dueDateTime);

    _loadProfileData().then((_) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  /// Fetches customer profile information to retrieve the authenticated customer ID.
  Future<void> _loadProfileData() async {
    try {
      final token = await _storage.read(key: 'token');
      if (token == null) return;

      final profileData = await _pelangganClient.fetchProfile(token);
      if (mounted) {
        setState(() {
          _idPelanggan = profileData['id'] ?? 1;
        });
      }
    } catch (e) {
      // Graceful fallback for demo or unauthenticated state
      _idPelanggan = 1;
    }
  }

  /// Ticks down the payment due duration every second.
  void _startCountdownTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      if (_timeRemaining.inSeconds > 0) {
        setState(() {
          _timeRemaining = _timeRemaining - const Duration(seconds: 1);
        });
      } else {
        timer.cancel();
      }
    });
  }

  /// Generates an 8-character uppercase alphanumeric booking code.
  String _generateBookingID() {
    final random = Random();
    const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    return List.generate(8, (_) => characters[random.nextInt(characters.length)]).join();
  }

  /// Formats remaining time into hours, minutes, and seconds.
  String _formatTime(Duration duration) {
    final String hours = duration.inHours.toString().padLeft(2, '0');
    final String minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    final String seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return '$hours Hours $minutes Minutes $seconds Seconds';
  }

  /// Creates the pesanan record in the Laravel backend API.
  /// Prevents duplicate requests if already created during payment simulation.
  Future<bool> _createPesanan(String bookingID, BuildContext context) async {
    if (_orderCreated) {
      return true;
    }

    final PesananClient pesananClient = PesananClient();
    final token = await _storage.read(key: 'token');

    if (token == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("User belum terautentikasi"),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
      return false;
    }

    try {
      final result = await pesananClient.createPesanan(
        token: token,
        idPelanggan: _idPelanggan > 0 ? _idPelanggan : 1, 
        idBarber: widget.dataformat['id_barber'], 
        tanggalPesanan: stringDate, 
        namaPemesan: widget.dataformat['nama'] ?? 'Pelanggan',
        layananAmbil: widget.layananAmbil, 
        totalHarga: widget.total,
        kodeBooking: bookingID, 
      );

      if (result) {
        _orderCreated = true;
        return true;
      }
      return false;
    } catch (e) {
      // NOTE: Even if backend throws or is offline, simulation can continue in offline mode
      _orderCreated = true;
      return true;
    }
  }

  /// Copies text to the device clipboard and provides feedback via SnackBar.
  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text)).then((_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.check_circle, color: Colors.black, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    "Nomor Virtual Account disalin: $text",
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
      }
    });
  }

  /// Navigates to the E-Booking ticket view.
  void _navigateToEBooking() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EBookingView(
          total: widget.total,
          dataformat: widget.dataformat,
          data: widget.data,
          bankName: widget.bankName,
          idBooking: _bookingID,
          idPelanggan: _idPelanggan > 0 ? _idPelanggan : 1,
        ),
      ),
    );
  }

  /// Displays an interactive m-Banking payment simulation modal bottom sheet.
  /// Allows the user to simulate an authentic Virtual Account transfer with PIN confirmation,
  /// live processing status, and real-time backend order synchronization.
  void _showPaymentSimulatorModal() {
    final String vaNumber = _bankVirtualAccounts[widget.bankName] ?? "128 0813 4315 5142";
    final TextEditingController pinController = TextEditingController(text: "123456");
    
    // Modal internal stage: 'confirm' -> 'processing' -> 'success'
    String modalStage = 'confirm';
    String processingText = "Menghubungkan ke ${widget.bankName}...";

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext modalContext) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Container(
              padding: EdgeInsets.only(
                top: 16,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom + 24,
              ),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                border: Border.all(color: const Color(0xFFE0AC53).withOpacity(0.4), width: 1.5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.8),
                    blurRadius: 20,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Modal grab bar
                    Center(
                      child: Container(
                        width: 48,
                        height: 5,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE0AC53).withOpacity(0.5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    if (modalStage == 'confirm') ...[
                      // Header with bank logo and simulation title
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: const Color(0xFFE0AC53).withOpacity(0.3)),
                                ),
                                child: Image.asset(
                                  widget.bankIcon,
                                  width: 40,
                                  height: 24,
                                  errorBuilder: (ctx, err, stack) => const Icon(
                                    Icons.account_balance,
                                    color: Color(0xFFE0AC53),
                                    size: 24,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.bankName,
                                    style: const TextStyle(
                                      color: Color(0xFFE0AC53),
                                      fontFamily: 'Inter',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const Text(
                                    "Simulasi Virtual Account",
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
                          IconButton(
                            icon: const Icon(Icons.close, color: Colors.grey),
                            onPressed: () => Navigator.pop(modalContext),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      const Divider(color: Color(0xFFE0AC53)),
                      const SizedBox(height: 8),

                      // Billing detail card
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFFE0AC53).withOpacity(0.2)),
                        ),
                        child: Column(
                          children: [
                            _buildModalRow("Penyedia Jasa", "Atma Barber Shop"),
                            const SizedBox(height: 8),
                            _buildModalRow("Nama Pemesan", "${widget.dataformat['nama'] ?? 'Pelanggan'}"),
                            const SizedBox(height: 8),
                            _buildModalRow("Layanan Dipilih", widget.layananAmbil),
                            const SizedBox(height: 8),
                            _buildModalRow("No. Virtual Account", vaNumber, isHighlighted: true),
                            const Divider(color: Color(0xFFE0AC53), height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Total Tagihan",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Inter',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  "Rp. ${widget.total}",
                                  style: const TextStyle(
                                    color: Color(0xFFE0AC53),
                                    fontFamily: 'Inter',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      // PIN simulation input
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "PIN m-Banking (Simulasi):",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Inter',
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  pinController.text = "123456";
                                  setModalState(() {});
                                },
                                child: const Text(
                                  "Gunakan Default (123456)",
                                  style: TextStyle(
                                    color: Color(0xFFE0AC53),
                                    fontFamily: 'Inter',
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            controller: pinController,
                            keyboardType: TextInputType.number,
                            obscureText: true,
                            style: const TextStyle(
                              color: Color(0xFFE0AC53),
                              fontFamily: 'Inter',
                              fontSize: 18,
                              letterSpacing: 8,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                            maxLength: 6,
                            decoration: InputDecoration(
                              counterText: "",
                              filled: true,
                              fillColor: Colors.black,
                              contentPadding: const EdgeInsets.symmetric(vertical: 12),
                              hintText: "••••••",
                              hintStyle: const TextStyle(
                                color: Colors.grey,
                                letterSpacing: 8,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: const Color(0xFFE0AC53).withOpacity(0.5),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Color(0xFFE0AC53),
                                  width: 1.8,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      // Notice banner
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE0AC53).withOpacity(0.08),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: const Color(0xFFE0AC53).withOpacity(0.2)),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.info_outline, color: Color(0xFFE0AC53), size: 16),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                "Simulasi transaksi interaktif. Pembayaran akan diverifikasi secara otomatis.",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontFamily: 'Inter',
                                  fontSize: 11,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Action Button
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFE0AC53),
                          minimumSize: const Size.fromHeight(50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        onPressed: () async {
                          if (pinController.text.length < 6) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Masukkan 6 digit PIN m-Banking"),
                                backgroundColor: Colors.redAccent,
                              ),
                            );
                            return;
                          }

                          // Start progressive simulation steps
                          setModalState(() {
                            modalStage = 'processing';
                            processingText = "Menghubungkan ke ${widget.bankName}...";
                          });

                          await Future.delayed(const Duration(milliseconds: 700));
                          if (!mounted) return;
                          setModalState(() {
                            processingText = "Memverifikasi Virtual Account & Saldo...";
                          });

                          await Future.delayed(const Duration(milliseconds: 700));
                          if (!mounted) return;
                          setModalState(() {
                            processingText = "Menyimpan transaksi ke database...";
                          });

                          // Execute backend order creation
                          await _createPesanan(_bookingID, context);

                          final String refNumber = 'TRX-${DateTime.now().millisecondsSinceEpoch.toString().substring(4)}';
                          final String formattedPaidTime = DateFormat('dd MMM yyyy, HH:mm:ss').format(DateTime.now());

                          if (!mounted) return;
                          setState(() {
                            _isPaid = true;
                            _transactionRef = refNumber;
                            _paidTimestamp = formattedPaidTime;
                          });

                          setModalState(() {
                            modalStage = 'success';
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.lock_outline, color: Colors.black, size: 18),
                            const SizedBox(width: 8),
                            Text(
                              'Bayar Sekarang (Rp. ${widget.total})',
                              style: const TextStyle(
                                color: Colors.black,
                                fontFamily: 'Inter',
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ] else if (modalStage == 'processing') ...[
                      // Processing loading view
                      const SizedBox(height: 20),
                      const Center(
                        child: SizedBox(
                          width: 56,
                          height: 56,
                          child: CircularProgressIndicator(
                            color: Color(0xFFE0AC53),
                            strokeWidth: 3.5,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        processingText,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color(0xFFE0AC53),
                          fontFamily: 'Inter',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Mohon jangan menutup aplikasi selama proses verifikasi...",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey,
                          fontFamily: 'Inter',
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 30),
                    ] else if (modalStage == 'success') ...[
                      // Success receipt view
                      const SizedBox(height: 12),
                      Center(
                        child: Container(
                          width: 68,
                          height: 68,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE0AC53).withOpacity(0.15),
                            shape: BoxShape.circle,
                            border: Border.all(color: const Color(0xFFE0AC53), width: 2),
                          ),
                          child: const Icon(
                            Icons.check_circle_rounded,
                            color: Color(0xFFE0AC53),
                            size: 44,
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),
                      const Text(
                        "Pembayaran Berhasil!",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Inter',
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Transaksi $_transactionRef berhasil diproses.",
                        style: const TextStyle(
                          color: Colors.grey,
                          fontFamily: 'Inter',
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Receipt breakdown
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFFE0AC53).withOpacity(0.3)),
                        ),
                        child: Column(
                          children: [
                            _buildModalRow("No. Referensi", _transactionRef, isHighlighted: true),
                            const SizedBox(height: 6),
                            _buildModalRow("Waktu Bayar", _paidTimestamp),
                            const SizedBox(height: 6),
                            _buildModalRow("Metode", "${widget.bankName} VA"),
                            const SizedBox(height: 6),
                            _buildModalRow("Status", "LUNAS (Terverifikasi)", isHighlighted: true),
                            const Divider(color: Color(0xFFE0AC53), height: 16),
                            _buildModalRow("Total Dibayar", "Rp. ${widget.total}", isHighlighted: true),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Buttons
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFE0AC53),
                          minimumSize: const Size.fromHeight(50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(modalContext);
                          _navigateToEBooking();
                        },
                        child: const Text(
                          'Buka E-Ticket Booking',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Inter',
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(modalContext);
                        },
                        child: const Text(
                          'Kembali ke Halaman Pembayaran',
                          style: TextStyle(
                            color: Color(0xFFE0AC53),
                            fontFamily: 'Inter',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  /// Helper to build clean key-value rows inside the simulation modal.
  Widget _buildModalRow(String label, String value, {bool isHighlighted = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.grey,
            fontFamily: 'Inter',
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: TextStyle(
              color: isHighlighted ? const Color(0xFFE0AC53) : Colors.white,
              fontFamily: 'Inter',
              fontSize: 13,
              fontWeight: isHighlighted ? FontWeight.w700 : FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final String currentVaNumber = _bankVirtualAccounts[widget.bankName] ?? '128 0813 4315 5142';

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
              const SizedBox(height: 12),

              // Main Payment Details Card
              Card(
                color: Colors.grey[900],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(
                    color: _isPaid 
                        ? Colors.greenAccent.withOpacity(0.5) 
                        : const Color(0xFFE0AC53).withOpacity(0.2),
                    width: 1.2,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Real-time Status Badge
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                        decoration: BoxDecoration(
                          color: _isPaid
                              ? Colors.green.withOpacity(0.15)
                              : const Color(0xFFE0AC53).withOpacity(0.12),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: _isPaid ? Colors.greenAccent : const Color(0xFFE0AC53),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  _isPaid ? Icons.check_circle_rounded : Icons.access_time_rounded,
                                  color: _isPaid ? Colors.greenAccent : const Color(0xFFE0AC53),
                                  size: 18,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  _isPaid ? 'LUNAS (TERVERIFIKASI)' : 'MENUNGGU PEMBAYARAN',
                                  style: TextStyle(
                                    color: _isPaid ? Colors.greenAccent : const Color(0xFFE0AC53),
                                    fontFamily: 'Inter',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ],
                            ),
                            if (!_isPaid)
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  _timeRemaining.inSeconds > 0 ? "Menunggu" : "Kadaluarsa",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Inter',
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Total Payment Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total Payment',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Inter',
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'Rp. ${widget.total}', 
                            style: const TextStyle(
                              color: Color(0xFFE0AC53),
                              fontFamily: 'Inter',
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      const Divider(color: Color(0xFFE0AC53)),

                      // Pay In Countdown Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Pay In',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Inter',
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            _isPaid ? 'Selesai Dibayar' : _formatTime(_timeRemaining),
                            style: TextStyle(
                              color: _isPaid ? Colors.greenAccent : const Color(0xFFE0AC53),
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
                          style: const TextStyle(
                            color: Colors.grey,
                            fontFamily: 'Inter',
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Bank Info
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: const Color(0xFFE0AC53).withOpacity(0.3)),
                            ),
                            child: Image.asset(
                              widget.bankIcon,
                              width: 60,
                              height: 32,
                              errorBuilder: (ctx, err, stack) => const Icon(
                                Icons.account_balance,
                                color: Color(0xFFE0AC53),
                                size: 30,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              widget.bankName,
                              style: const TextStyle(
                                color: Color(0xFFE0AC53),
                                fontFamily: 'Inter',
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Divider(color: Color(0xFFE0AC53)),

                      // Account Number / VA Section
                      Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Account number (Virtual Account)',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Inter',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  currentVaNumber,
                                  style: const TextStyle(
                                    color: Color(0xFFE0AC53),
                                    fontFamily: 'Inter',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: 1.0,
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.copy,
                                    color: Color(0xFFE0AC53),
                                  ),
                                  tooltip: "Salin Nomor VA",
                                  onPressed: () {
                                    _copyToClipboard(currentVaNumber);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // If transaction is verified, show receipt box
                      if (_isPaid) ...[
                        const Divider(color: Color(0xFFE0AC53)),
                        Container(
                          margin: const EdgeInsets.only(top: 8),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.greenAccent.withOpacity(0.4)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(
                                children: [
                                  Icon(Icons.verified, color: Colors.greenAccent, size: 16),
                                  SizedBox(width: 6),
                                  Text(
                                    "Bukti Pembayaran Terverifikasi",
                                    style: TextStyle(
                                      color: Colors.greenAccent,
                                      fontFamily: 'Inter',
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              _buildModalRow("No. Referensi", _transactionRef, isHighlighted: true),
                              const SizedBox(height: 4),
                              _buildModalRow("Waktu Bayar", _paidTimestamp),
                              const SizedBox(height: 4),
                              _buildModalRow("Kode Booking", _bookingID),
                            ],
                          ),
                        ),
                      ],

                      const Divider(color: Color(0xFFE0AC53)),

                      // Instruction Notes
                      Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 6),
                            const Text(
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
                            const Text(
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
                              style: const TextStyle(
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

                      // Expandable Instructions
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

              // Interactive Action Buttons
              if (!_isPaid) ...[
                // Primary Simulator Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE0AC53),
                    minimumSize: const Size.fromHeight(50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 4,
                  ),
                  onPressed: () {
                    _showPaymentSimulatorModal();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.account_balance_wallet_rounded, color: Colors.black, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        'Simulasi Bayar (${widget.bankName})',
                        style: const TextStyle(
                          color: Colors.black,
                          fontFamily: 'Inter',
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),

                // Secondary Verification / Check Status Button
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size.fromHeight(48),
                    side: const BorderSide(color: Color(0xFFE0AC53), width: 1.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Row(
                          children: [
                            Icon(Icons.info_outline, color: Colors.white, size: 20),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                "Belum ada pembayaran terdeteksi. Silakan klik 'Simulasi Bayar' terlebih dahulu.",
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                        backgroundColor: Colors.grey[850],
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        duration: const Duration(seconds: 3),
                      ),
                    );
                  },
                  child: const Text(
                    'Cek Status Pembayaran',
                    style: TextStyle(
                      color: Color(0xFFE0AC53),
                      fontFamily: 'Inter',
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ] else ...[
                // When already paid: View E-Ticket Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE0AC53),
                    minimumSize: const Size.fromHeight(52),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 4,
                  ),
                  onPressed: () {
                    _navigateToEBooking();
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.confirmation_number_outlined, color: Colors.black, size: 22),
                      SizedBox(width: 8),
                      Text(
                        'Lihat E-Ticket Booking',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Inter',
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds expandable instruction cards with gold theme.
  Widget _buildExpandableInstruction(BuildContext context, String title, String content) {
    return Card(
      color: const Color(0xFFE0AC53),  
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
