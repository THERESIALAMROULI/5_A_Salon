import 'package:flutter/material.dart';

class homeView extends StatelessWidget {
  const homeView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
      ),
      home: const homeScreen(),
    );
  }
}

class homeScreen extends StatelessWidget {
  const homeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
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
                color: Colors.amber.shade200,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: const [
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
              child: ListView(
                children: [
                  barberProfile("Sir Sapling the III", "Haircut", 4.5),
                  barberProfile("Sir Leaf the II", "Haircut, Treatment", 4.0),
                  barberProfile("Sir Root the IV", "Beard, Mustache", 4.2),
                  barberProfile("Sir Branch the IX", "Beard, Mustache, Coloring", 3.8),
                ],
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
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.amber, width: 1),
      ),
      child: Text(
        title,
        style: const TextStyle(color: Colors.amber),
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
          CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage('assets/barber.jpg'), // Ganti dengan asset gambar barber Anda
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