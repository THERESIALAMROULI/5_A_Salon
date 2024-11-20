import 'dart:math';
import 'package:flutter/material.dart';

class ViewList extends StatelessWidget {
  const ViewList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
      ),
      home: const ViewListScreen(),
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
            fontSize: 24,
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
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: secondText,
                style: TextStyle(
                  color: secondTextColor,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
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

class ViewListScreen extends StatelessWidget {
  const ViewListScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final List<String> names = [
      'Jonatharion Putraeus',
      'Asimandria Sinagard',
      'Theresienne Lamroule',
      'Eliandoria Setarian',
      'Maria Castillara',
    ];

    final List<String> imageUrls = [
      'https://insertface.com/fb/2826/hairstyle-oval-face-man-2825929-kt0sv-fb.jpg',
      'https://insertface.com/fb/2809/oval-face-shape-hairstyle-2808777-a6n25-fb.jpg',
      'https://insertface.com/fb/2822/oval-face-hairstyle-male-2821798-5p40c-fb.jpg',
      'https://insertface.com/fb/2822/oval-face-curly-hairstyle-2821797-vehkh-fb.jpg',
      'https://insertface.com/fb/2801/curly-hairstyle-oval-face-2801258-ixuew-fb.jpg',
      'https://insertface.com/fb/2809/rectangle-face-shape-2809242-ywmq7-fb.jpg',
      'https://insertface.com/fb/2805/inverted-triangle-face-shape-2804666-dbaaz-fb.jpg',
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Padding(
          padding: EdgeInsets.only(left: 16.0), 
          child: Text(
            'ATMA BARBER',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
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

            Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: const [
                ServiceTag(label: 'Haircut'),
                ServiceTag(label: 'Treatment'),
                ServiceTag(label: 'Mustache'),
                ServiceTag(label: 'Coloring'),
                ServiceTag(label: 'Beard'),
                ServiceTag(label: 'Shaving'),
                
              ],
              
              // kapan kapan ganti tombol deh ( mager sekarang ) // teeheee feeling cute : > 
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
                itemCount: names.length, 
                itemBuilder: (context, i) {
                  return ListItemCard(
                    
                    name: names[i],
                    imageUrl: imageUrls[i], 
                    tags: getRandomTags(),
                    rating: 4.5,
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

class ServiceTag extends StatelessWidget {
  final String label;
  const ServiceTag({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80, 
      height: 32,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border.all(color: Colors.white54),
        borderRadius: BorderRadius.circular(8), 
      ),
      child: Text(
        label,
        style: const TextStyle(color: Colors.white54, fontSize: 12),
      ),
    );
  }
}

class ListItemCard extends StatelessWidget {
  final String name;
  final String imageUrl; 
  final List<String> tags;
  final double rating;

  const ListItemCard({
    Key? key,
    required this.name,
    required this.imageUrl, 
    required this.tags,
    required this.rating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      width: double.infinity,
      height: 160,
      child: Card(
        
        color: Colors.black,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
          side: BorderSide(color: Color(0xFFE0AC53), width: 1.5),
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
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: List.generate(5, (index) {
                        return Icon(
                          index < rating.floor() ? Icons.star : Icons.star_half,
                          color: Color(0xFFE0AC53),
                          size: 20,
                        );
                      }),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Tags:',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Wrap(
                            spacing: 4.0,
                            runSpacing: 4.0,
                            children: tags.map((tag) {
                              return Container(
                                width: 80, 
                                padding: const EdgeInsets.symmetric(vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  border: Border.all(color: Color(0xFFE0AC53)),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  tag,
                                  style: const TextStyle(
                                    color: Color(0xFFE0AC53),
                                    fontSize: 12,
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
