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

class ViewListScreen extends StatelessWidget {
  const ViewListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('ATMA BARBER', style: TextStyle(color: Colors.amber)),
        backgroundColor: Colors.black,
        centerTitle: false,
        titleSpacing: 0.5,
        actions: const [
          Icon(Icons.notifications, color: Colors.amber),
          SizedBox(width: 16),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 4.0),
              child: Text(
                'Our Service List',
                style: TextStyle(
                  color: Colors.amber,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
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
              
              // kapan kapan ganti tombol deh ( mager sekarang )
            ),
            const Divider(color: Colors.amber, thickness: 1.0, height: 32.0),
            const Text(
              'Currently Available',
              style: TextStyle(
                color: Colors.amber,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(bottom: 16),
                itemCount: 5, 
                itemBuilder: (context, i) {
                  return ListItemCard(
                    name: 'Sir Sapling the III',
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
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border.all(color: Colors.white54),
        borderRadius: BorderRadius.circular(20),
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
  final List<String> tags;
  final double rating;

  const ListItemCard({
    Key? key,
    required this.name,
    required this.tags,
    required this.rating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
        color: Colors.black,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
          side: BorderSide(color: Colors.amber.shade700, width: 1.5),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              const CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQRczQ38KpzzA8jbdjlk6zMB5pdBDG4i-af5g&s',
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                          color: Colors.amber.shade700,
                          size: 20,
                        );
                      }),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Text(
                          'Tags:',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Wrap(
                          spacing: 4.0,
                          children: tags.map((tag) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black,
                                border: Border.all(color: Colors.amber.shade700),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                tag,
                                style: const TextStyle(
                                  color: Colors.amber,
                                  fontSize: 12,
                                ),
                              ),
                            );
                          }).toList(),
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

// i know im so fking good
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
