import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
      ),
      home: const ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  // Method untuk menampilkan dialog pilihan kamera atau galeri
  Future<void> _showPickerDialog(BuildContext context) async {
    final ImagePicker _picker = ImagePicker();

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Buka Kamera'),
                onTap: () async {
                  Navigator.of(context).pop();
                  final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
                  if (photo != null) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => DisplayPictureScreen(imagePath: photo.path),
                      ),
                    );
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Pilih dari Galeri'),
                onTap: () async {
                  Navigator.of(context).pop();
                  final XFile? photo = await _picker.pickImage(source: ImageSource.gallery);
                  if (photo != null) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => DisplayPictureScreen(imagePath: photo.path),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
<<<<<<< Updated upstream
        children: [
          Container(
            color: const Color(0xFFD2A04F),
            padding: const EdgeInsets.only(top: 40, bottom: 20),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQRczQ38KpzzA8jbdjlk6zMB5pdBDG4i-af5g&s'),
                    ),
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.edit,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  'Budi Antoro',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  'budi01@gmail.com | +62 812 3456 7890',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ProfileMenuContainer(
                    children: [
                      ProfileMenuItem(
                        icon: Icons.person,
                        text: 'Edit Profile Information',
                        onTap: () {},
                      ),
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
                        backgroundColor: const Color(0xFFD2A04F),
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {},
                      child: const Text(
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
=======
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Bagian atas dengan background warna emas dan avatar
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFFD2A04F), // Warna emas
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQRczQ38KpzzA8jbdjlk6zMB5pdBDG4i-af5g&s',
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () => _showPickerDialog(context),
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.edit,
                            color: Colors.black,
                            size: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  'Budi Antoro',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  'budi01@gmail.com | +62 812 3456 7890',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          // Konten menu pengaturan profil
          ProfileMenuContainer(
            children: [
              ProfileMenuItem(
                icon: Icons.person,
                text: 'Edit Profile Information',
                onTap: () {},
              ),
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
          // Tombol Logout
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD2A04F),
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {},
              child: const Text(
                'Logout',
                style: TextStyle(color: Colors.black, fontSize: 14),
              ),
            ),
          ),
        ],
      ),
      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: const Color.fromARGB(255, 228, 218, 128),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
        currentIndex: 2, // Profile tab
>>>>>>> Stashed changes
      ),
    );
  }
}

<<<<<<< Updated upstream
=======
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Display the Picture')),
      body: Image.file(File(imagePath)),
    );
  }
}

>>>>>>> Stashed changes
class ProfileMenuContainer extends StatelessWidget {
  final List<Widget> children;

  const ProfileMenuContainer({Key? key, required this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
<<<<<<< Updated upstream
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(10),
=======
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      padding: const EdgeInsets.all(8),
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
      leading: Icon(icon, color: Colors.black),
      title: Text(
        text,
        style: const TextStyle(color: Colors.black),
=======
      dense: true,
      leading: Icon(icon, color: Colors.black, size: 20),
      title: Text(
        text,
        style: const TextStyle(color: Colors.black, fontSize: 14),
>>>>>>> Stashed changes
      ),
      trailing: trailing,
      onTap: onTap,
    );
  }
}
