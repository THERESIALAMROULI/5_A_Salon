import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tubesfix/client/PelangganClient.dart';
import 'package:tubesfix/client/ReviewClient.dart';
import 'package:tubesfix/entity/Review.dart';

/// ReviewPage allows customers to rate and review their haircut/grooming experience.
/// Designed in the signature Atma Barber dark-and-gold aesthetic with interactive star ratings
/// and direct integration with the Laravel reviews API.
class ReviewPage extends StatefulWidget {
  final int? idPesanan;
  final int? idBarber;
  final String? barberName;
  final String? serviceName;
  final String? bookingCode;

  const ReviewPage({
    super.key,
    this.idPesanan,
    this.idBarber,
    this.barberName,
    this.serviceName,
    this.bookingCode,
  });

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  int _selectedRating = 5;
  final TextEditingController _reviewController = TextEditingController();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  final PelangganClient _pelangganClient = PelangganClient();

  bool _isSubmitting = false;
  int _idPelanggan = 0;
  String _customerName = '';

  final List<String> _quickCompliments = [
    "Potongan sangat rapi 👍",
    "Capster ramah & komunikatif ✂️",
    "Tepat waktu & profesional ⏱️",
    "Hasil sesuai ekspektasi ⭐",
    "Tempat bersih & nyaman 💈",
  ];

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  Future<void> _loadUserInfo() async {
    try {
      final token = await _storage.read(key: 'token');
      if (token == null) return;

      final profile = await _pelangganClient.fetchProfile(token);
      if (mounted) {
        setState(() {
          _idPelanggan = profile['id'] ?? 1;
          _customerName = profile['nama'] ?? profile['name'] ?? 'Pelanggan';
        });
      }
    } catch (_) {
      _idPelanggan = 1;
    }
  }

  String _getRatingLabel(int rating) {
    switch (rating) {
      case 1:
        return "Sangat Kurang Memuaskan";
      case 2:
        return "Kurang Memuaskan";
      case 3:
        return "Cukup Baik";
      case 4:
        return "Sangat Bagus & Rapi";
      case 5:
      default:
        return "Luar Biasa / Sempurna!";
    }
  }

  Future<void> _submitReview() async {
    if (_selectedRating <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: [
              Icon(Icons.warning_amber_rounded, color: Colors.white, size: 20),
              SizedBox(width: 8),
              Text("Silakan berikan bintang rating terlebih dahulu."),
            ],
          ),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      final token = await _storage.read(key: 'token');
      if (token == null) {
        throw Exception("User tidak terautentikasi.");
      }

      final review = Review(
        idPelanggan: _idPelanggan > 0 ? _idPelanggan : 1,
        idBarber: widget.idBarber,
        idPesanan: widget.idPesanan,
        namaPelanggan: _customerName.isNotEmpty ? _customerName : 'Pelanggan',
        namaBarber: widget.barberName ?? 'Atma Barber Capster',
        jenisLayanan: widget.serviceName ?? 'Haircut',
        rating: _selectedRating,
        komentar: _reviewController.text.trim().isNotEmpty
            ? _reviewController.text.trim()
            : _getRatingLabel(_selectedRating),
      );

      final success = await ReviewClient.addReview(token, review);

      if (mounted) {
        setState(() => _isSubmitting = false);

        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Row(
                children: [
                  Icon(Icons.check_circle_rounded, color: Colors.black, size: 20),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      "Ulasan berhasil dikirim! Terima kasih atas feedback Anda.",
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
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

          // Return true so parent view can reload
          Navigator.pop(context, true);
        } else {
          throw Exception("Gagal menyimpan ulasan.");
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isSubmitting = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Gagal mengirim ulasan: $e"),
            backgroundColor: Colors.redAccent,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final String barberName = widget.barberName ?? "Atma Barber Capster";
    final String serviceName = widget.serviceName ?? "Layanan Salon";
    final String bookingCode = widget.bookingCode ?? "-";

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
          'Beri Ulasan Layanan',
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
            // Order & Barber Info Card
            Card(
              color: Colors.grey[900],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(color: const Color(0xFFE0AC53).withOpacity(0.3), width: 1.2),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Container(
                      width: 54,
                      height: 54,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE0AC53).withOpacity(0.15),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: const Color(0xFFE0AC53).withOpacity(0.4)),
                      ),
                      child: const Icon(
                        Icons.content_cut_rounded,
                        color: Color(0xFFE0AC53),
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            barberName,
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'Inter',
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            serviceName,
                            style: const TextStyle(
                              color: Color(0xFFE0AC53),
                              fontFamily: 'Inter',
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          if (bookingCode != "-") ...[
                            const SizedBox(height: 2),
                            Text(
                              "Kode Booking: $bookingCode",
                              style: const TextStyle(
                                color: Colors.grey,
                                fontFamily: 'Inter',
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Rating Form Card
            Card(
              color: Colors.grey[900],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(color: const Color(0xFFE0AC53).withOpacity(0.2), width: 1),
              ),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Bagaimana pengalaman potong rambut Anda?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Star Rating Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        final starIndex = index + 1;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedRating = starIndex;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4.0),
                            child: Icon(
                              starIndex <= _selectedRating
                                  ? Icons.star_rounded
                                  : Icons.star_outline_rounded,
                              color: const Color(0xFFE0AC53),
                              size: 42,
                            ),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 10),

                    // Live Rating Feedback Text
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE0AC53).withOpacity(0.12),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: const Color(0xFFE0AC53).withOpacity(0.4)),
                      ),
                      child: Text(
                        _getRatingLabel(_selectedRating),
                        style: const TextStyle(
                          color: Color(0xFFE0AC53),
                          fontFamily: 'Inter',
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Divider(color: Color(0xFFE0AC53)),
                    const SizedBox(height: 12),

                    // Quick Compliment Chips
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Pilih Poin Penilaian Cepat:',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _quickCompliments.map((chipText) {
                        return ActionChip(
                          backgroundColor: Colors.black,
                          side: BorderSide(
                            color: const Color(0xFFE0AC53).withOpacity(0.4),
                          ),
                          label: Text(
                            chipText,
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'Inter',
                              fontSize: 11,
                            ),
                          ),
                          onPressed: () {
                            if (!_reviewController.text.contains(chipText)) {
                              if (_reviewController.text.isNotEmpty) {
                                _reviewController.text += "\n$chipText";
                              } else {
                                _reviewController.text = chipText;
                              }
                            }
                          },
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 16),

                    // Commentary Textarea
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Ulasan / Catatan Tambahan:',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _reviewController,
                      maxLines: 4,
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'Inter',
                        fontSize: 14,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.black,
                        hintText: 'Tuliskan kesan, kepuasan, atau masukan untuk capster ini...',
                        hintStyle: const TextStyle(color: Colors.grey, fontSize: 13),
                        contentPadding: const EdgeInsets.all(14),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: const Color(0xFFE0AC53).withOpacity(0.4)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Color(0xFFE0AC53), width: 1.8),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Submit Button
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE0AC53),
                        minimumSize: const Size.fromHeight(50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        elevation: 4,
                      ),
                      onPressed: _isSubmitting ? null : _submitReview,
                      child: _isSubmitting
                          ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                color: Colors.black,
                                strokeWidth: 2.5,
                              ),
                            )
                          : const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.send_rounded, color: Colors.black, size: 18),
                                SizedBox(width: 8),
                                Text(
                                  'Kirim Ulasan Sekarang',
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
                    const SizedBox(height: 8),

                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        'Nanti Saja',
                        style: TextStyle(
                          color: Colors.grey,
                          fontFamily: 'Inter',
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}