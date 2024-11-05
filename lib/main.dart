import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile Page',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        scaffoldBackgroundColor: Colors.black,
      ),
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text("Profile", style: TextStyle(color: Colors.white)),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          // Background Container for the avatar area
          Container(
            width: double.infinity,
            color: Color(0xFFD2A04F), // Sesuaikan dengan warna latar belakang yang diinginkan
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.blue[100],
                      child: CircleAvatar(
                        radius: 45,
                        backgroundImage: AssetImage('assets/image1.jpeg'), // Path gambar avatar
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.edit,
                          color: Colors.black,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  'Budi Antoro',
                  style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          // Sisanya adalah kode yang sama dengan layout utama
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ProfileMenuContainer(
                    children: [
                      ProfileMenuItem(
                        icon: Icons.edit,
                        text: 'Edit Profile Information',
                        onTap: () {},
                      ),
                      Divider(height: 1, color: Colors.grey),
                      ProfileMenuItem(
                        icon: Icons.notifications,
                        text: 'Notifications',
                        trailing: Text(
                          'ON',
                          style: TextStyle(color: Colors.blue),
                        ),
                        onTap: () {},
                      ),
                    ],
                  ),
                  ProfileMenuContainer(
                    children: [
                      ProfileMenuItem(
                        icon: Icons.history,
                        text: 'Transaction History',
                        onTap: () {},
                      ),
                      Divider(height: 1, color: Colors.grey),
                      ProfileMenuItem(
                        icon: Icons.card_giftcard,
                        text: 'My Voucher',
                        onTap: () {},
                      ),
                    ],
                  ),
                  ProfileMenuContainer(
                    children: [
                      ProfileMenuItem(
                        icon: Icons.contact_mail,
                        text: 'Contact Us',
                        onTap: () {},
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFD2A04F),
                        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {},
                      child: Text(
                        'Logout',
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileMenuContainer extends StatelessWidget {
  final List<Widget> children;

  const ProfileMenuContainer({Key? key, required this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: children,
      ),
    );
  }
}

class ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final Widget? trailing;
  final VoidCallback onTap;

  const ProfileMenuItem({
    Key? key,
    required this.icon,
    required this.text,
    this.trailing,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.black),
      title: Text(
        text,
        style: TextStyle(color: Colors.black),
      ),
      trailing: trailing,
      onTap: onTap,
    );
  }
}
