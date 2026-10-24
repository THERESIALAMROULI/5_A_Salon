import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tubesfix/client/TransaksiClient.dart';
import 'package:tubesfix/entity/Transaksi.dart';
import 'review_page.dart';

/// TransactionHistoryPage displays the user's past haircut & grooming orders.
/// Built with the Atma Barber dark-gold design system, featuring status badges,
/// detailed service breakdowns, and direct integration with the review system.
class TransactionHistoryPage extends StatefulWidget {
  const TransactionHistoryPage({super.key});

  @override
  State<TransactionHistoryPage> createState() => _TransactionHistoryPageState();
}

class _TransactionHistoryPageState extends State<TransactionHistoryPage> {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  late Future<List<Transaction>> _transactionsFuture;

  @override
  void initState() {
    super.initState();
    _transactionsFuture = _fetchTransactions();
  }

  Future<List<Transaction>> _fetchTransactions() async {
    final token = await _storage.read(key: 'token');
    if (token == null) {
      throw Exception("Pengguna belum terautentikasi.");
    }
    return await TransactionClient.fetchTransactions(token);
  }

  void _refreshTransactions() {
    setState(() {
      _transactionsFuture = _fetchTransactions();
    });
  }

  @override
  Widget build(BuildContext context) {
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
          'Riwayat Pemesanan',
          style: TextStyle(
            color: Color(0xFFE0AC53),
            fontFamily: 'Inter',
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: RefreshIndicator(
        color: const Color(0xFFE0AC53),
        backgroundColor: Colors.grey[900],
        onRefresh: () async {
          _refreshTransactions();
          await _transactionsFuture;
        },
        child: FutureBuilder<List<Transaction>>(
          future: _transactionsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Color(0xFFE0AC53),
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline, color: Colors.redAccent, size: 48),
                      const SizedBox(height: 12),
                      Text(
                        'Gagal memuat riwayat: ${snapshot.error}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.white, fontFamily: 'Inter'),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFE0AC53),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        onPressed: _refreshTransactions,
                        child: const Text('Coba Lagi', style: TextStyle(color: Colors.black)),
                      ),
                    ],
                  ),
                ),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          shape: BoxShape.circle,
                          border: Border.all(color: const Color(0xFFE0AC53).withOpacity(0.3)),
                        ),
                        child: const Icon(
                          Icons.receipt_long_rounded,
                          color: Color(0xFFE0AC53),
                          size: 48,
                        ),
                      ),
                      const SizedBox(height: 18),
                      const Text(
                        'Belum Ada Riwayat Pemesanan',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Inter',
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Pemesanan yang telah Anda selesaikan akan otomatis tercatat di sini.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey,
                          fontFamily: 'Inter',
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              final transactions = snapshot.data!;
              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  final transaction = transactions[index];
                  final services = transaction.service
                      .split(',')
                      .map((s) => s.trim())
                      .where((s) => s.isNotEmpty)
                      .toList();

                  return Card(
                    color: Colors.grey[900],
                    margin: const EdgeInsets.only(bottom: 14.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(
                        color: const Color(0xFFE0AC53).withOpacity(0.3),
                        width: 1.2,
                      ),
                    ),
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header: Booking Code + Date
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE0AC53).withOpacity(0.12),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: const Color(0xFFE0AC53).withOpacity(0.5),
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.confirmation_number_outlined,
                                      color: Color(0xFFE0AC53),
                                      size: 14,
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      transaction.kodeBooking != null && transaction.kodeBooking!.isNotEmpty
                                          ? transaction.kodeBooking!
                                          : '#BOOKING-${index + 1}',
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
                              Row(
                                children: [
                                  const Icon(Icons.calendar_today_rounded, color: Colors.grey, size: 13),
                                  const SizedBox(width: 5),
                                  Text(
                                    transaction.date,
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontFamily: 'Inter',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          const Divider(color: Color(0xFFE0AC53), height: 1),
                          const SizedBox(height: 12),

                          // Barber Capster Row
                          Row(
                            children: [
                              Container(
                                width: 38,
                                height: 38,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: const Color(0xFFE0AC53).withOpacity(0.3),
                                  ),
                                ),
                                child: const Icon(
                                  Icons.content_cut_rounded,
                                  color: Color(0xFFE0AC53),
                                  size: 20,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Capster / Barber:",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontFamily: 'Inter',
                                        fontSize: 11,
                                      ),
                                    ),
                                    Text(
                                      transaction.barberName ?? "Atma Barber Capster",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Inter',
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Price Display
                              Text(
                                transaction.price,
                                style: const TextStyle(
                                  color: Color(0xFFE0AC53),
                                  fontFamily: 'Inter',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),

                          // Services Tag List
                          const Text(
                            "Layanan:",
                            style: TextStyle(
                              color: Colors.grey,
                              fontFamily: 'Inter',
                              fontSize: 11,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Wrap(
                            spacing: 6,
                            runSpacing: 6,
                            children: services.map((s) {
                              return Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                    color: const Color(0xFFE0AC53).withOpacity(0.35),
                                  ),
                                ),
                                child: Text(
                                  s,
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontFamily: 'Inter',
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 14),
                          const Divider(color: Color(0xFFE0AC53), height: 1),
                          const SizedBox(height: 12),

                          // Bottom Row: Status Badge & Review Button
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Status Badge
                              const Row(
                                children: [
                                  Icon(Icons.check_circle_rounded, color: Colors.greenAccent, size: 16),
                                  SizedBox(width: 6),
                                  Text(
                                    "Selesai (Lunas)",
                                    style: TextStyle(
                                      color: Colors.greenAccent,
                                      fontFamily: 'Inter',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),

                              // Review Action Button / Badge
                              if (transaction.isReviewed)
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFE0AC53).withOpacity(0.12),
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: const Color(0xFFE0AC53).withOpacity(0.5),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.star_rounded, color: Color(0xFFE0AC53), size: 16),
                                      const SizedBox(width: 4),
                                      Text(
                                        "Ulasan Diberikan (${transaction.reviewRating ?? 5}★)",
                                        style: const TextStyle(
                                          color: Color(0xFFE0AC53),
                                          fontFamily: 'Inter',
                                          fontSize: 11,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              else
                                ElevatedButton(
                                  onPressed: () async {
                                    final result = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ReviewPage(
                                          idPesanan: transaction.id,
                                          idBarber: transaction.idBarber,
                                          barberName: transaction.barberName,
                                          serviceName: transaction.service,
                                          bookingCode: transaction.kodeBooking,
                                        ),
                                      ),
                                    );

                                    if (result == true) {
                                      _refreshTransactions();
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFE0AC53),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                                  ),
                                  child: const Row(
                                    children: [
                                      Icon(Icons.star_outline_rounded, color: Colors.black, size: 16),
                                      SizedBox(width: 6),
                                      Text(
                                        'Beri Review',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Inter',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
