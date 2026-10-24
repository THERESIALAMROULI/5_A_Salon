import 'package:flutter/material.dart';
import 'dart:math';
import 'package:tubesfix/View/voucher.dart';
import 'package:tubesfix/client/BarberClient.dart';
import 'package:tubesfix/client/LayananClient.dart';
import 'package:tubesfix/entity/Barber.dart';
import 'package:tubesfix/entity/Layanan.dart';
import 'package:tubesfix/View/selectService.dart';

/// Luxury VIP Member Card displaying customer status and quick voucher access
class VipMemberCard extends StatelessWidget {
  final String userName;
  final String memberId;
  final VoidCallback? onVoucherTap;

  const VipMemberCard({
    super.key,
    required this.userName,
    required this.memberId,
    this.onVoucherTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF2B2315),
            Color(0xFF191611),
            Color(0xFF0F0E0B),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(
          color: const Color(0xFFE0AC53).withOpacity(0.55),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFE0AC53).withOpacity(0.12),
            blurRadius: 16,
            offset: const Offset(0, 5),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.6),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFFE0AC53).withOpacity(0.15),
                      border: Border.all(
                        color: const Color(0xFFE0AC53),
                        width: 1,
                      ),
                    ),
                    child: const Icon(
                      Icons.content_cut_rounded,
                      color: Color(0xFFE0AC53),
                      size: 15,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'ATMA BARBER LOUNGE',
                    style: TextStyle(
                      color: Color(0xFFE0AC53),
                      fontFamily: 'Inter',
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.8,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFE0AC53),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.star_rounded,
                      color: Colors.black,
                      size: 13,
                    ),
                    SizedBox(width: 3),
                    Text(
                      'VIP GOLD',
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Inter',
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '••••   ••••   ••••   $memberId',
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'Inter',
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 2,
                ),
              ),
              Icon(
                Icons.contactless_rounded,
                color: const Color(0xFFE0AC53).withOpacity(0.7),
                size: 22,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'CARDHOLDER',
                      style: TextStyle(
                        color: Colors.white54,
                        fontFamily: 'Inter',
                        fontSize: 9,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      userName.toUpperCase(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'Inter',
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: onVoucherTap,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFE0AC53), Color(0xFFC79237)],
                    ),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFE0AC53).withOpacity(0.35),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.confirmation_number_outlined,
                        color: Colors.black,
                        size: 13,
                      ),
                      SizedBox(width: 4),
                      Text(
                        'Klaim Voucher',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Inter',
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class homeView extends StatefulWidget {
  final Map? data;

  const homeView({super.key, this.data});

  @override
  _homeViewState createState() => _homeViewState();
}
    
class _homeViewState extends State<homeView> {
  Future<List<Barber>> _barbersFuture = BarberClient.fetchBarbers();
  Future<List<Layanan>> _layananFuture = LayananClient.fetchLayanan();

  @override
  Widget build(BuildContext context) {
    final List<String> serviceTags = [
      'Haircut',
      'Treatment',
      'Mustache',
      'Coloring',
      'Beard',
      'Shaving'
    ];

  final List<String> imageUrls = [
      'https://drive.usercontent.google.com/download?id=1eKqFqigcme6f1SKOLYWsUIjMf7bCGdAs',
      'https://drive.usercontent.google.com/download?id=18gSwk7y7t_4_z6aTj5S3b7b0URVmTGvq',
      'https://drive.usercontent.google.com/download?id=1C4rr6Q6pUSIUA09ub5sSLN7qjB_1Espe',
      'https://drive.usercontent.google.com/download?id=1mZwiDqZYL-098jws22YHT4uZSE3taPSH',
      'https://drive.usercontent.google.com/download?id=174r-_8CHvBRR5j1_ThCJGHqc8Au-awpb',
    ];

  final List<String> reviews = [
    'The barber was incredibly professional and gave me the best haircut I’ve had in years!',
    'Amazing service! The staff was friendly, and the haircut exceeded my expectations.',
    'The attention to detail was impressive, and the barber ensured I was comfortable throughout.',
    'I loved how they styled my hair; it’s exactly what I wanted. Highly recommend!',
    'Unfortunately, the barber seemed rushed, and the haircut didn’t turn out as I had hoped.',
  ];

  @override
  void initState() {
    super.initState(); 
    _barbersFuture = BarberClient.fetchBarbers();
    _layananFuture = LayananClient.fetchLayanan();
  }

  List<int> getFilteredIndices(List<Barber> barbers, List<Layanan> layanan) {
    return List.generate(barbers.length, (index) => index);
  }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Padding(
          padding: EdgeInsets.only(left: 16.0),
          child: Text(
            'ATMA BARBER',
            style: TextStyle(
              fontFamily: 'Mixages',
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Color(0xFFE0AC53),
            ),
          ),
        ),
        backgroundColor: Colors.black,
        centerTitle: false,
        titleSpacing: 0.5,
        actions: const [
          Icon(Icons.notifications, color: Color(0xFFE0AC53)),
          SizedBox(width: 16),
        ],
      ),
      body: FutureBuilder<List<Barber>>(
        future: _barbersFuture,
        builder: (context, barberSnapshot) {
          return FutureBuilder<List<Layanan>>(
            future: _layananFuture,
            builder: (context, layananSnapshot) {
              if (barberSnapshot.connectionState == ConnectionState.waiting ||
                  layananSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (barberSnapshot.hasError || layananSnapshot.hasError) {
                return Center(
                  child: Text(
                    'Error: ${barberSnapshot.error ?? layananSnapshot.error}',
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              } else if (!barberSnapshot.hasData || barberSnapshot.data!.isEmpty) {
                return const Center(
                  child: Text(
                    'No barbers available.',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }

              final barbers = barberSnapshot.data!;
              final layanan = layananSnapshot.data!;
              final filteredIndices = getFilteredIndices(barbers, layanan);

              final String userName = widget.data?['nama'] ??
                  widget.data?['name'] ??
                  widget.data?['username'] ??
                  'Valued Guest';
              final String memberId = widget.data?['id'] != null
                  ? widget.data!['id'].toString().padLeft(4, '0')
                  : '8821';

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Personalized Greeting
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Welcome back, 👋',
                              style: TextStyle(
                                color: Colors.white70,
                                fontFamily: 'Inter',
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              userName,
                              style: const TextStyle(
                                color: Color(0xFFE0AC53),
                                fontFamily: 'Inter',
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: const Color(0xFF161616),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: const Color(0xFFE0AC53).withOpacity(0.5),
                            ),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.stars_rounded,
                                  color: Color(0xFFE0AC53), size: 14),
                              SizedBox(width: 4),
                              Text(
                                'MEMBER',
                                style: TextStyle(
                                  color: Color(0xFFE0AC53),
                                  fontFamily: 'Inter',
                                  fontSize: 10,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 0.8,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    // VIP Member Card
                    VipMemberCard(
                      userName: userName,
                      memberId: memberId,
                      onVoucherTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const VoucherPage()),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    const SectionTitle(
                      firstText: 'Services ',
                      secondText: 'Available',
                      firstTextColor: Color(0xFFE0AC53),
                      secondTextColor: Colors.white,
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: Wrap(
                        spacing: 8.0,
                        runSpacing: 6.0,
                        children: serviceTags.map((tag) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 8),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: const Color(0xFF161616),
                              border: Border.all(
                                  color: const Color(0xFFE0AC53).withOpacity(0.7)),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              tag,
                              style: const TextStyle(
                                color: Color(0xFFE0AC53),
                                fontFamily: 'Inter',
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 14),
                    const SectionTitle(
                      firstText: 'Currently ',
                      secondText: 'Available',
                      firstTextColor: Color(0xFFE0AC53),
                      secondTextColor: Colors.white,
                    ),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.only(bottom: 16),
                      itemCount: filteredIndices.length,
                      itemBuilder: (context, index) {
                        final filteredIndex = filteredIndices[index];
                        final barber = barbers[filteredIndex];
                        final barberLayanan = layanan
                            .where((l) => l.id_barber == barber.id)
                            .map((l) => l.jenis_Layanan)
                            .toList();
                        final barberLayananHarga = layanan
                            .where((l) => l.id_barber == barber.id)
                            .toList();

                        return ListItemCard(
                          name: barber.nama_barber,
                          imageUrl: imageUrls[filteredIndex % imageUrls.length],
                          tags: barberLayanan,
                          rating: 4.5,
                          reviews: [reviews[filteredIndex % reviews.length]],
                          description: barber.deskripsi,
                          id_barber: barber.id,
                          layanan: barberLayananHarga,
                          data: widget.data,
                        );
                      },
                    ),
                  ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

List<String> getRandomTags() {
  final List<String> allTags = [
    'Haircut',
    'Treatment',
    'Mustache',
    'Coloring',
    'Beard',
    'Shaving'
  ];
  final random = Random();
  final selectedTags = <String>{};

  int tagCount = random.nextInt(1) + 1; 
  while (selectedTags.length < tagCount) {
    selectedTags.add(allTags[random.nextInt(allTags.length)]);
  }

  return selectedTags.toList();
}

class SectionTitle extends StatelessWidget {
  final String firstText;
  final String secondText;
  final Color firstTextColor;
  final Color secondTextColor;

  const SectionTitle({
    Key? key,
    required this.firstText,
    required this.secondText,
    required this.firstTextColor,
    required this.secondTextColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '— ',
          style: TextStyle(
            color: firstTextColor,
            fontFamily: 'Inter', fontSize: 24, fontWeight: FontWeight.w700
          ),
        ),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: firstText,
                style: TextStyle(
                  color: firstTextColor,
                  fontFamily: 'Inter', fontSize: 20, fontWeight: FontWeight.w700
                ),
              ),
              TextSpan(
                text: secondText,
                style: TextStyle(
                  color: secondTextColor,
                  fontFamily: 'Inter', fontSize: 20, fontWeight: FontWeight.w700
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        const Expanded(
          child: Divider(
            color: Colors.white,
            thickness: 1.5,
            height: 1,
          ),
        ),
      ],
    );
  }
}

class ListItemCard extends StatelessWidget {
  final String name;
  final String imageUrl;
  final List<String> tags;
  final double rating;
  final List<String> reviews;
  final String description; 
  final int id_barber;
  final List<Layanan> layanan;
  final Map? data;

  const ListItemCard({
    Key? key,
    required this.name,
    required this.imageUrl,
    required this.tags,
    required this.rating,
    required this.reviews,
    required this.description,
    required this.id_barber,
    required this.layanan,
    this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SelectServiceScreen(
              barberName: name,
              barberImage: imageUrl,
              barberTags: tags,
              barberReview: reviews,
              barberDescription: description,
              id_barber: id_barber, 
              layanan: layanan,
              data: data,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6.0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFF161616),
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(
            color: const Color(0xFFE0AC53).withOpacity(0.4),
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(2.5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFFE0AC53),
                    width: 1.5,
                  ),
                ),
                child: CircleAvatar(
                  radius: 34,
                  backgroundImage: NetworkImage(imageUrl),
                  backgroundColor: Colors.grey[850],
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'Inter',
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Row(
                          children: List.generate(5, (index) {
                            return Icon(
                              index < rating.floor()
                                  ? Icons.star_rounded
                                  : Icons.star_half_rounded,
                              color: const Color(0xFFE0AC53),
                              size: 17,
                            );
                          }),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          rating.toStringAsFixed(1),
                          style: const TextStyle(
                            color: Color(0xFFE0AC53),
                            fontFamily: 'Inter',
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 5.0,
                      runSpacing: 4.0,
                      children: tags.map((tag) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 3, horizontal: 8),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE0AC53).withOpacity(0.12),
                            border: Border.all(
                              color: const Color(0xFFE0AC53).withOpacity(0.6),
                              width: 0.8,
                            ),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            tag,
                            style: const TextStyle(
                              color: Color(0xFFE0AC53),
                              fontFamily: 'Inter',
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 6),
              const Icon(
                Icons.chevron_right_rounded,
                color: Color(0xFFE0AC53),
                size: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}