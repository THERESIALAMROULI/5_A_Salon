import 'dart:math';
import 'package:flutter/material.dart';
import 'package:tubesfix/View/selectService.dart';

class ViewListScreen extends StatefulWidget {
  final Map? data;
  
  const ViewListScreen({super.key, this.data});

  @override
  _ViewListScreenState createState() => _ViewListScreenState();
}

class _ViewListScreenState extends State<ViewListScreen> {
  final List<String> names = [
    'Jonatharion Putraeus',
    'Asimandria Sinagard',
    'Theresienne Lamroule',
    'Eliandoria Setarian',
    'Maria Castillara',
  ];

  final List<String> reviews = [
    'The barber was incredibly professional and gave me the best haircut I’ve had in years!',
    'Amazing service! The staff was friendly, and the haircut exceeded my expectations.',
    'The attention to detail was impressive, and the barber ensured I was comfortable throughout.',
    'I loved how they styled my hair; it’s exactly what I wanted. Highly recommend!',
    'Unfortunately, the barber seemed rushed, and the haircut didn’t turn out as I had hoped.',
    'The atmosphere was pleasant, but the haircut was just average for the price.',
    'The barber took the time to understand what I wanted and delivered perfectly!',
    'It was okay, but I felt the barber wasn’t very engaged during the session.',
    'I wasn’t happy with the way my hair was trimmed—it was uneven in some places.',
    'The service was quick, and the barber was polite, but the results were underwhelming.',
    'They were very professional, explained the process, and gave helpful styling tips.',
    'The cleanliness and setup of the place were great, but the haircut was disappointing.',
    'I loved the precision and care the barber showed. Definitely coming back!',
    'The haircut was fine, but the barber didn’t seem interested in giving suggestions.',
    'Best experience ever! The barber made me feel at ease and delivered a flawless cut.'
  ];

  final List<String> descriptions = [
    'Experienced barber specializing in modern and classic haircuts. Ensures attention to detail and customer satisfaction.',
    'Known for creative styles and a friendly approach, offering personalized haircut and grooming services.',
    'Highly skilled in handling a variety of hair types and styles, from simple trims to intricate designs.',
    'Combines professionalism and creativity to deliver hairstyles that match your personality and preferences.',
    'Focuses on creating a relaxing experience while achieving the perfect look for every client.',
    'Expert in beard grooming and styling, providing sharp, clean cuts tailored to individual needs.',
    'Passionate about helping clients achieve their desired look through precision and artistic techniques.',
    'Offers professional haircut and treatment services in a welcoming and comfortable environment.',
    'Dedicated to providing top-notch customer service and ensuring every client leaves with a smile.',
    'Excels in blending traditional barber techniques with modern trends for unique, stylish results.',
    'Known for expert advice and guidance on hair care and styling, ensuring long-lasting results.',
    'Creates a friendly and professional atmosphere, perfect for anyone looking for a quality haircut.',
    'Experienced in grooming, beard trims, and advanced hairstyling for special occasions.',
    'Highly trained in contemporary techniques, specializing in haircuts that complement face shapes.',
    'Committed to providing a premium grooming experience with a focus on quality and style.',
    'Not gonna lie, the barber is so attractive, I might book another session just to see them again.',
    'Honestly, the haircut was great, but I couldn’t stop thinking about how cute the barber was. Call me? 😉'
  ];

  final List<String> imageUrls = [
    'https://drive.usercontent.google.com/download?id=1eKqFqigcme6f1SKOLYWsUIjMf7bCGdAs',
    'https://drive.usercontent.google.com/download?id=18gSwk7y7t_4_z6aTj5S3b7b0URVmTGvq',
    'https://drive.usercontent.google.com/download?id=1C4rr6Q6pUSIUA09ub5sSLN7qjB_1Espe',
    'https://drive.usercontent.google.com/download?id=1mZwiDqZYL-098jws22YHT4uZSE3taPSH',
    'https://drive.usercontent.google.com/download?id=174r-_8CHvBRR5j1_ThCJGHqc8Au-awpb',
  ];

  late final List<List<String>> barberTags = List.generate(
    names.length,
    (_) => getRandomTags(), 
  );

  final List<String> serviceTags = [
    'Haircut',
    'Treatment',
    'Mustache',
    'Coloring',
    'Beard',
    'Shaving'
  ];

  final Set<String> selectedTags = {}; 

  List<int> getFilteredIndices() {
    if (selectedTags.isEmpty) {
      return List.generate(names.length, (index) => index);
    }

    return List.generate(names.length, (index) => index).where((i) {
      return selectedTags.every((tag) => barberTags[i].contains(tag));
    }).toList();
  }

  List<String> getRandomReviews(int minReviews, int maxReviews) {
    final random = Random();
    final reviewCount = random.nextInt(maxReviews - minReviews + 1) + minReviews;
    final selectedReviews = <String>{};

    while (selectedReviews.length < reviewCount) {
      selectedReviews.add(reviews[random.nextInt(reviews.length)]);
    }

    return selectedReviews.toList();
  }

  @override
  Widget build(BuildContext context) {
    final filteredIndices = getFilteredIndices();

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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            const SectionTitle(
              firstText: 'Our Service ',
              secondText: 'List',
              firstTextColor: Color(0xFFE0AC53),
              secondTextColor: Colors.white,
            ),
            const SizedBox(height: 16),
            Center(
              child: Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children: serviceTags.map((tag) {
                  final isSelected = selectedTags.contains(tag);
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          selectedTags.remove(tag); 
                        } else {
                          selectedTags.add(tag);
                        }
                      });
                    },
                    child: Container(
                      width: 95,
                      height: 42,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        border: Border.all(
                          color: isSelected ? Color(0xFFE0AC53) : Colors.white54,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        tag,
                        style: TextStyle(
                          color: isSelected ? Color(0xFFE0AC53) : Colors.white54,
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
            const SizedBox(height: 16),
            const SectionTitle(
              firstText: 'Currently ',
              secondText: 'Available',
              firstTextColor: Color(0xFFE0AC53),
              secondTextColor: Colors.white,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(bottom: 16),
                itemCount: filteredIndices.length,
                itemBuilder: (context, index) {
                  final i = filteredIndices[index];
                  return ListItemCard(
                    name: names[i],
                    imageUrl: imageUrls[i],
                    tags: barberTags[i],
                    rating: 4.5,
                    reviews: getRandomReviews(1, 4),
                    description: descriptions[i], 
                    data: widget.data,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
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
                  fontFamily: 'Inter', fontSize: 24, fontWeight: FontWeight.w700
                ),
              ),
              TextSpan(
                text: secondText,
                style: TextStyle(
                  color: secondTextColor,
                  fontFamily: 'Inter', fontSize: 24, fontWeight: FontWeight.w700
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
  final Map? data;

  const ListItemCard({
    Key? key,
    required this.name,
    required this.imageUrl,
    required this.tags,
    required this.rating,
    required this.reviews,
    required this.description,
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

// i know im so fking good // :>
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

  int tagCount = random.nextInt(3) + 1; 
  while (selectedTags.length < tagCount) {
    selectedTags.add(allTags[random.nextInt(allTags.length)]);
  }

  return selectedTags.toList();
}
