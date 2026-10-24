import 'package:flutter/material.dart';
import 'package:tubesfix/View/transaction.dart';
import 'package:tubesfix/client/ReviewClient.dart';
import 'package:tubesfix/entity/Layanan.dart';
import 'package:tubesfix/entity/Review.dart';

/// SelectServiceScreen displays the full Barber Profile and allows the customer
/// to choose services, pick a booking date, and view authentic customer reviews
/// for the selected capster.
class SelectServiceScreen extends StatefulWidget {
  final String barberName;
  final String barberImage;
  final List<String> barberTags;
  final List<String> barberReview;
  final String barberDescription;
  final int id_barber;
  final List<Layanan> layanan; 
  final Map? data;

  const SelectServiceScreen({
    super.key,
    required this.barberName,
    required this.barberImage,
    required this.barberTags,
    required this.barberReview,
    required this.barberDescription,
    required this.id_barber,
    required this.layanan, 
    this.data,
  });

  @override
  State<SelectServiceScreen> createState() => _SelectServiceScreenState();
}

class SectionTitle extends StatelessWidget {
  final String firstText;
  final String secondText;
  final Color firstTextColor;
  final Color secondTextColor;

  const SectionTitle({
    super.key,
    required this.firstText,
    required this.secondText,
    required this.firstTextColor,
    required this.secondTextColor,
  });
  
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '— ',
          style: TextStyle(
            color: firstTextColor,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: firstText,
                style: TextStyle(
                  color: firstTextColor,
                  fontFamily: 'Inter',
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              TextSpan(
                text: secondText,
                style: TextStyle(
                  color: secondTextColor,
                  fontFamily: 'Inter',
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        const Expanded(
          child: Divider(
            color: Color(0xFFE0AC53),
            thickness: 1,
            height: 1,
          ),
        ),
      ],
    );
  }
}

class _SelectServiceScreenState extends State<SelectServiceScreen> {
  final List<String> selectedServices = []; 
  final TextEditingController namaController = TextEditingController();
  String? errorTextName;
  String? errorTextDate;
  DateTime? selectedDate;

  List<Review> _realReviews = [];
  bool _isLoadingReviews = true;

  @override
  void initState() {
    super.initState();
    _fetchBarberReviews();
  }

  @override
  void dispose() {
    namaController.dispose();
    super.dispose();
  }

  /// Fetches real customer reviews for this specific barber from the Laravel API.
  Future<void> _fetchBarberReviews() async {
    try {
      final reviews = await ReviewClient.fetchReviewsByBarber(widget.id_barber);
      if (mounted) {
        setState(() {
          _realReviews = reviews;
          _isLoadingReviews = false;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() => _isLoadingReviews = false);
      }
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFFE0AC53),
              onPrimary: Colors.black,
              surface: Color(0xFF1E1E1E),
              onSurface: Colors.white,
            ),
            dialogBackgroundColor: const Color(0xFF1E1E1E),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        errorTextDate = null;
      });
    }
  }

  double _getAverageRating() {
    if (_realReviews.isNotEmpty) {
      final total = _realReviews.map((r) => r.rating).fold<int>(0, (a, b) => a + b);
      return total / _realReviews.length;
    }
    return 4.9;
  }

  @override
  Widget build(BuildContext context) {
    final availableServices = widget.layanan
        .where((service) => widget.barberTags.contains(service.jenis_Layanan))
        .toList();

    final selectedTotal = selectedServices
        .map((serviceName) =>
            availableServices.firstWhere((s) => s.jenis_Layanan == serviceName).tarif)
        .fold(0.0, (value, element) => value + element);

    final avgRating = _getAverageRating();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFE0AC53)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Barber Profile & Service',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Color(0xFFE0AC53),
          ),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // VIP Barber Profile Card
              Card(
                color: Colors.grey[900],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                  side: BorderSide(
                    color: const Color(0xFFE0AC53).withOpacity(0.35),
                    width: 1.2,
                  ),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Barber Avatar with Gold Ring
                          Container(
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: const Color(0xFFE0AC53), width: 2),
                            ),
                            child: CircleAvatar(
                              radius: 40,
                              backgroundColor: Colors.black,
                              backgroundImage: NetworkImage(widget.barberImage),
                              onBackgroundImageError: (_, __) {},
                              child: widget.barberImage.isEmpty
                                  ? const Icon(Icons.person, color: Color(0xFFE0AC53), size: 40)
                                  : null,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.barberName,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Inter',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                // Star Rating Badge
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFE0AC53).withOpacity(0.15),
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          color: const Color(0xFFE0AC53).withOpacity(0.5),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(Icons.star_rounded, color: Color(0xFFE0AC53), size: 16),
                                          const SizedBox(width: 4),
                                          Text(
                                            avgRating.toStringAsFixed(1),
                                            style: const TextStyle(
                                              color: Color(0xFFE0AC53),
                                              fontFamily: 'Inter',
                                              fontSize: 12,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      '(${_realReviews.isNotEmpty ? _realReviews.length : widget.barberReview.length} Ulasan)',
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontFamily: 'Inter',
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                // Speciality Tags
                                Wrap(
                                  spacing: 5.0,
                                  runSpacing: 5.0,
                                  children: widget.barberTags.map((tag) {
                                    return Container(
                                      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        border: Border.all(
                                          color: const Color(0xFFE0AC53).withOpacity(0.4),
                                        ),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Text(
                                        tag,
                                        style: const TextStyle(
                                          color: Color(0xFFE0AC53),
                                          fontFamily: 'Inter',
                                          fontSize: 11,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Divider(color: Color(0xFFE0AC53), height: 1),
                      const SizedBox(height: 14),

                      // Barber Bio / Description
                      const Text(
                        'Tentang Capster',
                        style: TextStyle(
                          color: Color(0xFFE0AC53),
                          fontFamily: 'Inter',
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        widget.barberDescription,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontFamily: 'Inter',
                          fontSize: 13,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 18),

                      // Reviews Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Ulasan & Penilaian Pelanggan',
                            style: TextStyle(
                              color: Color(0xFFE0AC53),
                              fontFamily: 'Inter',
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            '${_realReviews.isNotEmpty ? _realReviews.length : widget.barberReview.length} Review',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontFamily: 'Inter',
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),

                      // Customer Reviews List (Real from Database or Fallback)
                      if (_isLoadingReviews)
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          child: Center(
                            child: SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                color: Color(0xFFE0AC53),
                                strokeWidth: 2,
                              ),
                            ),
                          ),
                        )
                      else if (_realReviews.isNotEmpty)
                        Container(
                          constraints: const BoxConstraints(maxHeight: 220),
                          child: ListView.separated(
                            shrinkWrap: true,
                            itemCount: _realReviews.length,
                            separatorBuilder: (_, __) => const SizedBox(height: 8),
                            itemBuilder: (context, index) {
                              final review = _realReviews[index];
                              final reviewerName = review.namaPelanggan ?? 'Pelanggan Atma Barber';
                              return Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: const Color(0xFFE0AC53).withOpacity(0.2),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            CircleAvatar(
                                              radius: 12,
                                              backgroundColor: const Color(0xFFE0AC53),
                                              child: Text(
                                                reviewerName.isNotEmpty ? reviewerName[0].toUpperCase() : 'P',
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 11,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              reviewerName,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'Inter',
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: List.generate(5, (starIdx) {
                                            return Icon(
                                              starIdx < review.rating
                                                  ? Icons.star_rounded
                                                  : Icons.star_border_rounded,
                                              color: const Color(0xFFE0AC53),
                                              size: 14,
                                            );
                                          }),
                                        ),
                                      ],
                                    ),
                                    if (review.jenisLayanan != null && review.jenisLayanan!.isNotEmpty) ...[
                                      const SizedBox(height: 4),
                                      Text(
                                        "Layanan: ${review.jenisLayanan}",
                                        style: TextStyle(
                                          color: const Color(0xFFE0AC53).withOpacity(0.8),
                                          fontFamily: 'Inter',
                                          fontSize: 11,
                                        ),
                                      ),
                                    ],
                                    const SizedBox(height: 6),
                                    Text(
                                      review.komentar,
                                      style: const TextStyle(
                                        color: Colors.white70,
                                        fontFamily: 'Inter',
                                        fontSize: 12,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        )
                      else
                        Container(
                          constraints: const BoxConstraints(maxHeight: 180),
                          child: ListView.separated(
                            shrinkWrap: true,
                            itemCount: widget.barberReview.length,
                            separatorBuilder: (_, __) => const SizedBox(height: 8),
                            itemBuilder: (context, index) {
                              return Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: const Color(0xFFE0AC53).withOpacity(0.2),
                                  ),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Icon(Icons.format_quote_rounded, size: 16, color: Color(0xFFE0AC53)),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        widget.barberReview[index],
                                        style: const TextStyle(
                                          color: Colors.white70,
                                          fontFamily: 'Inter',
                                          fontSize: 12,
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Section: Select Services
              const SectionTitle(
                firstText: 'Pilih ',
                secondText: 'Layanan',
                firstTextColor: Color(0xFFE0AC53),
                secondTextColor: Colors.white,
              ),
              const SizedBox(height: 12),

              // Service Selection Chips / Cards
              Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: availableServices.map((service) {
                  final isSelected = selectedServices.contains(service.jenis_Layanan);
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          selectedServices.remove(service.jenis_Layanan);
                        } else {
                          selectedServices.add(service.jenis_Layanan);
                        }
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFFE0AC53)
                            : Colors.grey[900],
                        border: Border.all(
                          color: const Color(0xFFE0AC53),
                          width: 1.2,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            isSelected ? Icons.check_circle : Icons.add_circle_outline,
                            size: 16,
                            color: isSelected ? Colors.black : const Color(0xFFE0AC53),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            service.jenis_Layanan,
                            style: TextStyle(
                              color: isSelected ? Colors.black : Colors.white,
                              fontFamily: 'Inter',
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Rp ${service.tarif.toInt()}',
                            style: TextStyle(
                              color: isSelected ? Colors.black87 : const Color(0xFFE0AC53),
                              fontFamily: 'Inter',
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),

              // Section: Customer Name & Date
              const SectionTitle(
                firstText: 'Informasi ',
                secondText: 'Pemesanan',
                firstTextColor: Color(0xFFE0AC53),
                secondTextColor: Colors.white,
              ),
              const SizedBox(height: 12),

              // Name Input
              TextField(
                controller: namaController,
                decoration: InputDecoration(
                  hintText: 'Nama Lengkap Pemesan...',
                  hintStyle: const TextStyle(color: Colors.grey, fontSize: 13),
                  prefixIcon: const Icon(Icons.person_outline, color: Color(0xFFE0AC53)),
                  filled: true,
                  fillColor: Colors.grey[900],
                  contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFFE0AC53), width: 1.8),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: const Color(0xFFE0AC53).withOpacity(0.4)),
                  ),
                  errorText: errorTextName, 
                ),
                style: const TextStyle(color: Colors.white, fontFamily: 'Inter'),
              ),
              const SizedBox(height: 12),

              // Date Picker Button
              OutlinedButton(
                onPressed: () => _selectDate(context),
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.grey[900],
                  side: BorderSide(
                    color: selectedDate != null
                        ? const Color(0xFFE0AC53)
                        : const Color(0xFFE0AC53).withOpacity(0.4),
                    width: 1.2,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  minimumSize: const Size.fromHeight(50), 
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.calendar_month_rounded, color: Color(0xFFE0AC53), size: 18),
                    const SizedBox(width: 8),
                    Text(
                      selectedDate == null
                          ? 'Pilih Tanggal Booking'
                          : 'Tanggal: ${selectedDate!.toLocal().toString().split(' ')[0]}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'Inter',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              if (errorTextDate != null)
                Padding(
                  padding: const EdgeInsets.only(top: 6.0, left: 4.0),
                  child: Text(
                    errorTextDate!,
                    style: const TextStyle(
                      color: Colors.redAccent,
                      fontSize: 12,
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
              const SizedBox(height: 18),

              // Price Summary Card
              if (selectedServices.isNotEmpty)
                Card(
                  color: Colors.grey[900],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                    side: BorderSide(color: const Color(0xFFE0AC53).withOpacity(0.3)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        ...selectedServices.map((serviceName) {
                          final service = availableServices.firstWhere(
                              (s) => s.jenis_Layanan == serviceName);
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  service.jenis_Layanan,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Inter',
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  'Rp ${service.tarif.toInt()}',
                                  style: const TextStyle(
                                    color: Color(0xFFE0AC53),
                                    fontFamily: 'Inter',
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                        const Divider(color: Color(0xFFE0AC53), height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total Tagihan',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Inter',
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              'Rp ${selectedTotal.toInt()}',
                              style: const TextStyle(
                                color: Color(0xFFE0AC53),
                                fontFamily: 'Inter',
                                fontSize: 17,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              const SizedBox(height: 20),

              // Bottom Actions
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFFE0AC53)),
                        minimumSize: const Size.fromHeight(50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: const Text(
                        'Kembali',
                        style: TextStyle(
                          color: Color(0xFFE0AC53),
                          fontFamily: 'Inter',
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: () {
                        if (selectedServices.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Pilih minimal 1 layanan potong rambut / perawatan.'),
                              backgroundColor: Colors.redAccent,
                            ),
                          );
                          return;
                        }

                        if (namaController.text.trim().isEmpty) {
                          setState(() {
                            errorTextName = 'Nama pemesan tidak boleh kosong';
                          });
                          return;
                        }

                        if (selectedDate == null) {
                          setState(() {
                            errorTextDate = 'Silakan pilih tanggal booking';
                          });
                          return;
                        }

                        setState(() {
                          errorTextName = null;
                          errorTextDate = null;
                        });

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => transactionView(
                              dataformat: {
                                'nama': namaController.text.trim(),
                                'date': selectedDate, 
                                'services': selectedServices,
                                'id_barber': widget.id_barber,
                                'servicesPdf': selectedServices.map((service) {
                                  return {
                                    'name': service,
                                    'quantity': 1,
                                  };
                                }).toList(),
                                'prices': selectedServices.map((service) {
                                  final tarif = widget.layanan
                                      .firstWhere((layanan) => layanan.jenis_Layanan == service)
                                      .tarif
                                      .toInt();
                                  return {
                                    'name': service,
                                    'price': tarif,
                                  };
                                }).toList(),
                                'total': selectedTotal.toInt(),
                              },
                              data: widget.data,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE0AC53),
                        minimumSize: const Size.fromHeight(50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        elevation: 4,
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.payment_rounded, color: Colors.black, size: 18),
                          SizedBox(width: 8),
                          Text(
                            'Lanjutkan Pembayaran',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Inter',
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 28),
            ],
          ),
        ),
      ),
    );
  }
}
