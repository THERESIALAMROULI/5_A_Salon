import 'dart:math';
import 'package:flutter/material.dart';
import 'package:tubesfix/View/selectService.dart';


class ViewListScreen extends StatefulWidget {
  final Map data;
  
  const ViewListScreen({super.key, required this.data});

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

  final List<String> imageUrls = [
    'https://insertface.com/fb/2826/hairstyle-oval-face-man-2825929-kt0sv-fb.jpg',
    'https://insertface.com/fb/2809/oval-face-shape-hairstyle-2808777-a6n25-fb.jpg',
    'https://insertface.com/fb/2822/oval-face-hairstyle-male-2821798-5p40c-fb.jpg',
    'https://insertface.com/fb/2822/oval-face-curly-hairstyle-2821797-vehkh-fb.jpg',
    'https://insertface.com/fb/2801/curly-hairstyle-oval-face-2801258-ixuew-fb.jpg',
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

  @override
  Widget build(BuildContext context) {
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
                    width: 80,
                    height: 32,
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
                        fontSize: 12,
                      ),
                    ),
                  ),
                );
              }).toList(),
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
                    tags: barberTags[i],
                    rating: 4.5,
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

class ListItemCard extends StatelessWidget {
  final String name;
  final String imageUrl;
  final List<String> tags;
  final double rating;
  final Map data;

  const ListItemCard({
    Key? key,
    required this.name,
    required this.imageUrl,
    required this.tags,
    required this.rating,
    required this.data
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
              data: data,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        width: double.infinity,
        height: 160,
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
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
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
