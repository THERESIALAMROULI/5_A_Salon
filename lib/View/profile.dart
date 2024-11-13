import 'package:flutter/material.dart';

class profileView extends StatelessWidget {
  const profileView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Profile Page',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
      ),
      home: const ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center( // Center widget agar seluruh kolom di tengah layar
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Header Profile Section
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 130,
                    width: 300, // Lebar header disesuaikan agar lebih pendek
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 228, 218, 128),
                      borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
                    ),
                  ),
                  Column(
                    children: [
                      CircleAvatar(
                        radius: 35,
                        backgroundImage: NetworkImage(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQRczQ38KpzzA8jbdjlk6zMB5pdBDG4i-af5g&s',
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Budi Antoro',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'budi01@gmail.com | +62 812 3456 7890',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Profile Options
              ProfileOption(icon: Icons.person, title: 'Edit Profile Information', width: 300), // Lebar disesuaikan
              ProfileOption(
                icon: Icons.notifications,
                title: 'Notifications',
                trailing: Text(
                  'ON',
                  style: TextStyle(color: Colors.blue, fontSize: 12),
                ),
                width: 300,
              ),
              ProfileOption(icon: Icons.history, title: 'Transaction History', width: 300),
              ProfileOption(icon: Icons.card_giftcard, title: 'My Voucher', width: 300),
              ProfileOption(icon: Icons.contact_support, title: 'Contact Us', width: 300),
              const SizedBox(height: 12),
              // Logout Button
              SizedBox(
                width: 300, // Lebar tombol Logout disesuaikan
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(8),
                    backgroundColor: const Color.fromARGB(255, 228, 218, 128),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Logout',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget? trailing;
  final double width;

  const ProfileOption({
    Key? key,
    required this.icon,
    required this.title,
    this.trailing,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width, // Menentukan lebar dari kotak
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 2),
            color: const Color.fromARGB(255, 228, 218, 128).withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 10),
        leading: Icon(icon, color: Colors.black, size: 18),
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
        ),
        trailing: trailing ?? Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 14),
      ),
    );
  }
}
