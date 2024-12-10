import 'package:flutter/material.dart';
import 'dart:math';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:tubesfix/client/BarberClient.dart';
import 'package:tubesfix/client/LayananClient.dart';
import 'package:tubesfix/entity/Barber.dart';
import 'package:tubesfix/entity/Layanan.dart';
import 'package:tubesfix/View/selectService.dart';


class ImageSlider extends StatelessWidget {
  final List<String> imageUrls = [
    'assets/images/awwa.jpg',
    'assets/images/gohard.jpg',
    'assets/images/man-getting-haircut.jpg',
    'assets/images/maxresdefault.jpg'
  ];

  @override
  Widget build(BuildContext context) {
        return Container(
          width: double.infinity,
          height: 150, 
          child: CarouselSlider(
            options: CarouselOptions(
              height: 150, 
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 4),
              enlargeCenterPage: true,
              viewportFraction: 0.8,
              aspectRatio: 16 / 9,
            ),
      items: imageUrls.map((path) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: AssetImage(path),
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        );
      }).toList(),
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

              return Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SectionTitle(
                      firstText: 'Ready ',
                      secondText: 'For New Style ?',
                      firstTextColor: Color(0xFFE0AC53),
                      secondTextColor: Colors.white,
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: ImageSlider(),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: Wrap(
                        spacing: 8.0,
                        runSpacing: 4.0,
                        children: serviceTags.map((tag) {
                          return GestureDetector(
                            child: Container(
                              width: 87,
                              height: 39,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                border: Border.all(color: Color(0xFFE0AC53)),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                tag,
                                style: TextStyle(
                                  color: Color(0xFFE0AC53),
                                  fontFamily: 'Inter',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    
                    const SizedBox(height: 10),
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
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        width: double.infinity,
        height: 150,
        child: Card(
          color: Colors.black,
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
            side: const BorderSide(color: Color(0xFFE0AC53), width: 1.5),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(imageUrl),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'Inter',
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: List.generate(5, (index) {
                          return Icon(
                            index < rating.floor()
                                ? Icons.star
                                : Icons.star_half,
                            color: const Color(0xFFE0AC53),
                            size: 20,
                          );
                        }),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Tags: ',
                            style: TextStyle(
                              color: Colors.white70,
                              fontFamily: 'Inter',
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Wrap(
                              spacing: 4.0,
                              runSpacing: 4.0,
                              children: tags.map((tag) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 4, horizontal: 8),
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    border: Border.all(
                                        color: const Color(0xFFE0AC53)),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    tag,
                                    style: const TextStyle(
                                      color: Color(0xFFE0AC53),
                                      fontFamily: 'Inter',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}