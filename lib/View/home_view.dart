import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedService = "All"; // Default layanan yang dipilih
  final List<Map<String, dynamic>> barberList = [
    {"name": "Sir Sapling the III", "services": ["Haircut"], "rating": 4.5},
    {"name": "Sir Leaf the II", "services": ["Haircut", "Treatment"], "rating": 4.0},
    {"name": "Sir Root the IV", "services": ["Beard", "Mustache"], "rating": 4.2},
    {"name": "Sir Branch the IX", "services": ["Beard", "Mustache", "Coloring"], "rating": 3.8},
  ];

  @override
  Widget build(BuildContext context) {
    // Filter barber sesuai layanan yang dipilih
    List<Map<String, dynamic>> filteredBarberList = selectedService == "All"
        ? barberList
        : barberList.where((barber) => barber["services"].contains(selectedService)).toList();

    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "ATMA BARBER",
                  style: TextStyle(color: Colors.amber, fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Icon(
                  Icons.notifications,
                  color: Colors.amber,
                  size: 28,
                ),
              ],
            ),
            const SizedBox(height: 10),
            sectionHeader("Ready", "For New Style ?", Colors.amber, Colors.white),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: const Color(0xFFE0AC53),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Column(
                children: [
                  Text(
                    "Launching Discount",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Get a 30% discount for any service!",
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "30%    35%    37%    39%    50%",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 10,
              children: [
                serviceButton("All"),
                serviceButton("Haircut"),
                serviceButton("Treatment"),
                serviceButton("Mustache"),
                serviceButton("Beard"),
                serviceButton("Shaving"),
                serviceButton("Coloring"),
              ],
            ),
            const SizedBox(height: 30),
            sectionHeader("Currently", "Available", Colors.white, Colors.amber),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: filteredBarberList.length,
                itemBuilder: (context, index) {
                  final barber = filteredBarberList[index];
                  return barberProfile(barber["name"], barber["services"].join(", "), barber["rating"]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget sectionHeader(String boldText, String normalText, Color boldColor, Color lineColor) {
    return Row(
      children: [
        Text(
          "- $boldText",
          style: TextStyle(color: boldColor, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(
          " $normalText",
          style: const TextStyle(color: Colors.white, fontSize: 18),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Container(
            height: 2,
            color: lineColor,
          ),
        ),
      ],
    );
  }

  Widget serviceButton(String title) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedService = title;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
        decoration: BoxDecoration(
          color: selectedService == title ? Colors.amber : Colors.black,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.amber, width: 1),
        ),
        child: Text(
          title,
          style: TextStyle(color: selectedService == title ? Colors.black : Colors.amber),
        ),
      ),
    );
  }

  Widget barberProfile(String name, String services, double rating) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border.all(color: Colors.amber, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQRczQ38KpzzA8jbdjlk6zMB5pdBDG4i-af5g&s',), // Ganti dengan asset gambar barber Anda
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Text(
                  services,
                  style: const TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 5),
                Row(
                  children: List.generate(5, (index) {
                    return Icon(
                      index < rating ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                      size: 16,
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
