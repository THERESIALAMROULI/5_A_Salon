import 'package:flutter/material.dart';

class homeGuestView extends StatelessWidget {
  const homeGuestView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ATMA Barber Guest',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
      ),
      home: const GuestHomeScreen(),
    );
  }
}

class GuestHomeScreen extends StatelessWidget {
  const GuestHomeScreen({super.key});

  void navigateToLogin(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

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
            TextButton(
              onPressed: () => navigateToLogin(context),
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.amber.shade200,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    "Log in to access this coupon",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Add other components like service buttons and barber profiles as needed
          ],
        ),
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  void enterAsGuest(BuildContext context) {
    Navigator.pop(context); // Navigates back to GuestHomeScreen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "ATMA BARBER",
              style: TextStyle(color: Colors.amber, fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const TextField(
              decoration: InputDecoration(
                labelText: "Username",
                labelStyle: TextStyle(color: Colors.amber),
                filled: true,
                fillColor: Colors.black,
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Password",
                labelStyle: TextStyle(color: Colors.amber),
                filled: true,
                fillColor: Colors.black,
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => enterAsGuest(context),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
              child: const Text("Enter as Guest"),
            ),
          ],
        ),
      ),
    );
  }
}