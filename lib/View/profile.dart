import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:permission_handler/permission_handler.dart';
import 'edit_profile_information.dart'; 

class profileView extends StatefulWidget {
  const profileView({Key? key}) : super(key: key);

  @override
  State<profileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<profileView> {
  String _name = "Budi Antoro";
  String _email = "budi01@gmail.com";
  String _phone = "+62 812 3456 7890";
  String _username = "budiantoro";
  bool _notificationsOn = true;
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    if (source == ImageSource.camera) await _requestCameraPermission();
    final XFile? pickedImage = await _picker.pickImage(source: source);
    if (pickedImage != null) {
      setState(() => _profileImage = File(pickedImage.path));
    }
  }

  Future<void> _requestCameraPermission() async {
    final status = await Permission.camera.request();
    if (!status.isGranted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Camera permission denied")),
      );
    }
  }

  void _showPhotoOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => _photoOptionSheet(),
    );
  }

  Widget _photoOptionSheet() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _photoOption(icon: Icons.camera_alt, label: "Camera", onTap: () => _pickImage(ImageSource.camera)),
          _photoOption(icon: Icons.photo, label: "Gallery", onTap: () => _pickImage(ImageSource.gallery)),
        ],
      ),
    );
  }

  Widget _photoOption({required IconData icon, required String label, required VoidCallback onTap}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(icon, size: 30, color: const Color(0xFFE0AC53)),
          onPressed: () {
            Navigator.pop(context);
            onTap();
          },
        ),
        Text(label),
      ],
    );
  }

  void _editProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfileScreen(
          name: _name,
          email: _email,
          phone: _phone,
          username: _username,
          onSave: (newName, newEmail, newPhone, newUsername) {
            setState(() {
              _name = newName;
              _email = newEmail;
              _phone = newPhone;
              _username = newUsername;
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,

              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [

                    Container(
                      height: 170,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE0AC53),
                        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
                      ),
                    ),
                    Column(
                      children: [
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                              radius: 40,
                              backgroundImage: _profileImage != null
                                  ? FileImage(_profileImage!) as ImageProvider
                                  : const NetworkImage('https://via.placeholder.com/150'),
                            ),
                            GestureDetector(
                              onTap: _showPhotoOptions,
                              child: const CircleAvatar(
                                radius: 14,
                                backgroundColor: Colors.white,
                                child: Icon(Icons.edit, size: 16, color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          _name,
                          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Text(
                          '$_email | $_phone',
                          style: const TextStyle(color: Colors.black87, fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _profileOption(Icons.person, "Edit Profile Information", onTap: _editProfile),
                _profileOption(
                  Icons.notifications,
                  "Notifications",
                  trailing: Text(
                    _notificationsOn ? "ON" : "OFF",
                    style: const TextStyle(color: Colors.blue),
                  ),
                  onTap: () => setState(() => _notificationsOn = !_notificationsOn),
                ),
                _profileOption(Icons.history, "Transaction History"),
                _profileOption(Icons.card_giftcard, "My Voucher"),
                _profileOption(Icons.contact_support, "Contact Us"),
                const SizedBox(height: 20),
                // Logout Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE0AC53),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () {
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: Text(
                      "Logout",
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _profileOption(IconData icon, String title, {Widget? trailing, VoidCallback? onTap}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 8, offset: const Offset(0, 3)),
        ],
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.black),
        title: Text(title, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        trailing: trailing,
        onTap: onTap,
      ),
    );
  }
}
