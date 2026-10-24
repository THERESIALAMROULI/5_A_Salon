import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tubesfix/client/PelangganClient.dart';
import 'package:tubesfix/client/TransaksiClient.dart';
import 'edit_profile_information.dart';
import 'history_transaction_view.dart';
import 'review_page.dart';
import 'change_password.dart';
import 'package:tubesfix/View/login.dart';

/// profileView displays the customer's account overview, order statistics,
/// and menu navigation. Designed consistently with Atma Barber's signature
/// dark-and-gold visual identity.
class profileView extends StatefulWidget {
  const profileView({super.key});

  @override
  State<profileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<profileView> {
  String _name = "Memuat...";
  String _email = "user@example.com";
  String _phone = "08123456789";
  String _username = "user";
  int _transactionCount = 0;
  bool _notificationsOn = true;
  File? _profileImage;

  final ImagePicker _picker = ImagePicker();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  final PelangganClient _pelangganClient = PelangganClient();

  @override
  void initState() {
    super.initState();
    _loadProfileData();
    _loadTransactionStats();
  }

  /// Fetches authenticated customer profile data from backend.
  Future<void> _loadProfileData() async {
    try {
      final token = await _storage.read(key: 'token');
      if (token == null) return;

      final profileData = await _pelangganClient.fetchProfile(token);
      if (mounted) {
        setState(() {
          _name = profileData['nama'] ?? profileData['name'] ?? "Pelanggan";
          _email = profileData['email'] ?? "user@atmabarber.com";
          _phone = profileData['telepon'] ?? "08123456789";
          _username = profileData['username'] ?? "user";
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          _name = "Pelanggan Setia";
          _email = "user@atmabarber.com";
          _username = "member";
        });
      }
    }
  }

  /// Fetches transaction count for profile stats.
  Future<void> _loadTransactionStats() async {
    try {
      final token = await _storage.read(key: 'token');
      if (token == null) return;

      final transactions = await TransactionClient.fetchTransactions(token);
      if (mounted) {
        setState(() {
          _transactionCount = transactions.length;
        });
      }
    } catch (_) {
      // Graceful fallback
    }
  }

  /// Picks avatar from camera or gallery.
  Future<void> _pickImage(ImageSource source) async {
    if (source == ImageSource.camera) {
      await _requestCameraPermission();
    }
    final XFile? pickedImage = await _picker.pickImage(source: source);
    if (pickedImage != null && mounted) {
      setState(() => _profileImage = File(pickedImage.path));
    }
  }

  Future<void> _requestCameraPermission() async {
    final status = await Permission.camera.request();
    if (!status.isGranted && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Izin kamera diperlukan untuk mengambil foto profil"),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  void _showImagePickerSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            border: Border.all(color: const Color(0xFFE0AC53).withOpacity(0.3)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: const Color(0xFFE0AC53).withOpacity(0.5),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Pilih Foto Profil",
                style: TextStyle(
                  color: Color(0xFFE0AC53),
                  fontFamily: 'Inter',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: const Icon(Icons.camera_alt_rounded, color: Color(0xFFE0AC53)),
                title: const Text("Ambil dari Kamera", style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(ctx);
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library_rounded, color: Color(0xFFE0AC53)),
                title: const Text("Pilih dari Galeri", style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(ctx);
                  _pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _navigateToEditProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfileScreen(
          name: _name,
          email: _email,
          phone: _phone,
          onSave: (newName, newEmail, newPhone) {
            setState(() {
              _name = newName;
              _email = newEmail;
              _phone = newPhone;
            });
          },
        ),
      ),
    );
  }

  /// Displays custom UI logout confirmation dialog conforming to action validation standards.
  void _showLogoutConfirmation() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            border: Border.all(color: Colors.redAccent.withOpacity(0.4), width: 1.5),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 44,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[700],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 18),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.redAccent.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.logout_rounded, color: Colors.redAccent, size: 36),
              ),
              const SizedBox(height: 16),
              const Text(
                "Konfirmasi Keluar",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Inter',
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Apakah Anda yakin ingin keluar dari akun Atma Barber?",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontFamily: 'Inter', fontSize: 13),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size.fromHeight(48),
                        side: BorderSide(color: const Color(0xFFE0AC53).withOpacity(0.5)),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () => Navigator.pop(ctx),
                      child: const Text(
                        "Batal",
                        style: TextStyle(color: Color(0xFFE0AC53), fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        minimumSize: const Size.fromHeight(48),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () async {
                        Navigator.pop(ctx);
                        await _logout();
                      },
                      child: const Text(
                        "Ya, Keluar",
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _logout() async {
    try {
      await _pelangganClient.logout();
    } catch (_) {}
    await _storage.delete(key: 'token');

    if (mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginView()),
        (route) => false,
      );
    }
  }

  void _showAboutDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.grey[900],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: Color(0xFFE0AC53), width: 1.2),
        ),
        title: const Row(
          children: [
            Icon(Icons.content_cut_rounded, color: Color(0xFFE0AC53)),
            SizedBox(width: 8),
            Text(
              "Atma Barber Shop",
              style: TextStyle(color: Color(0xFFE0AC53), fontFamily: 'Inter', fontWeight: FontWeight.bold),
            ),
          ],
        ),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Aplikasi Layanan Barber & Grooming Modern.",
              style: TextStyle(color: Colors.white, fontFamily: 'Inter', fontSize: 13),
            ),
            SizedBox(height: 8),
            Text(
              "Versi 1.0.0 (Tubes Pemrograman Mobile)\nMenyediakan layanan booking potong rambut, styling, perawatan, serta penilaian capster terpercaya.",
              style: TextStyle(color: Colors.grey, fontFamily: 'Inter', fontSize: 12),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE0AC53),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Tutup", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Color(0xFFE0AC53),
            fontFamily: 'Inter',
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded, color: Color(0xFFE0AC53)),
            tooltip: "Muat Ulang Profil",
            onPressed: () {
              _loadProfileData();
              _loadTransactionStats();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Memperbarui data profil..."),
                  duration: Duration(seconds: 1),
                  backgroundColor: Color(0xFFE0AC53),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Profile Information Card
            Card(
              color: Colors.grey[900],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  color: const Color(0xFFE0AC53).withOpacity(0.35),
                  width: 1.2,
                ),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    // Avatar & Camera Picker Button
                    Center(
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(3.5),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: const Color(0xFFE0AC53), width: 2.2),
                            ),
                            child: CircleAvatar(
                              radius: 44,
                              backgroundColor: Colors.black,
                              backgroundImage: _profileImage != null ? FileImage(_profileImage!) : null,
                              child: _profileImage == null
                                  ? const Icon(Icons.person_rounded, size: 52, color: Color(0xFFE0AC53))
                                  : null,
                            ),
                          ),
                          GestureDetector(
                            onTap: _showImagePickerSheet,
                            child: Container(
                              padding: const EdgeInsets.all(7),
                              decoration: const BoxDecoration(
                                color: Color(0xFFE0AC53),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black54,
                                    blurRadius: 4,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.camera_alt_rounded,
                                size: 16,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),

                    // User Full Name
                    Text(
                      _name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'Inter',
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),

                    // Username Tag Badge
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE0AC53).withOpacity(0.12),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color(0xFFE0AC53).withOpacity(0.4),
                        ),
                      ),
                      child: Text(
                        "@$_username",
                        style: const TextStyle(
                          color: Color(0xFFE0AC53),
                          fontFamily: 'Inter',
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Divider(color: Color(0xFFE0AC53), height: 1),
                    const SizedBox(height: 14),

                    // Contact Info Rows
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.email_outlined, color: Color(0xFFE0AC53), size: 16),
                        const SizedBox(width: 6),
                        Flexible(
                          child: Text(
                            _email,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontFamily: 'Inter',
                              fontSize: 12,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 14),
                        const Icon(Icons.phone_outlined, color: Color(0xFFE0AC53), size: 16),
                        const SizedBox(width: 6),
                        Text(
                          _phone,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontFamily: 'Inter',
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 14),

            // Quick Stats Counter Bar
            Container(
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color(0xFFE0AC53).withOpacity(0.25),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatItem("Riwayat Booking", "$_transactionCount", Icons.calendar_month_rounded),
                  Container(width: 1, height: 32, color: const Color(0xFFE0AC53).withOpacity(0.3)),
                  _buildStatItem("Member Tier", "VIP Gold", Icons.workspace_premium_rounded),
                  Container(width: 1, height: 32, color: const Color(0xFFE0AC53).withOpacity(0.3)),
                  _buildStatItem("Status Akun", "Aktif", Icons.verified_user_rounded),
                ],
              ),
            ),
            const SizedBox(height: 22),

            // SECTION 1: Aktivitas & Pemesanan
            _buildSectionHeader("Aktivitas & Layanan"),
            const SizedBox(height: 8),

            _buildMenuCard(
              icon: Icons.history_rounded,
              title: "Riwayat Pemesanan",
              subtitle: "Lihat status booking, layanan, & riwayat salon",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TransactionHistoryPage()),
                ).then((_) => _loadTransactionStats());
              },
            ),
            const SizedBox(height: 8),

            _buildMenuCard(
              icon: Icons.star_rounded,
              title: "Ulasan & Review Layanan",
              subtitle: "Beri feedback & rating untuk capster favorit Anda",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ReviewPage()),
                );
              },
            ),
            const SizedBox(height: 20),

            // SECTION 2: Pengaturan Akun
            _buildSectionHeader("Pengaturan Akun"),
            const SizedBox(height: 8),

            _buildMenuCard(
              icon: Icons.person_outline_rounded,
              title: "Edit Informasi Profil",
              subtitle: "Ubah nama pemesan, email, dan nomor HP",
              onTap: _navigateToEditProfile,
            ),
            const SizedBox(height: 8),

            _buildMenuCard(
              icon: Icons.lock_outline_rounded,
              title: "Ganti Kata Sandi",
              subtitle: "Perbarui kata sandi akun untuk keamanan",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ChangePasswordScreen()),
                );
              },
            ),
            const SizedBox(height: 8),

            _buildMenuCard(
              icon: Icons.notifications_outlined,
              title: "Notifikasi Aplikasi",
              subtitle: "Pengingat jadwal booking dan promo eksklusif",
              trailing: Switch(
                value: _notificationsOn,
                activeColor: const Color(0xFFE0AC53),
                activeTrackColor: const Color(0xFFE0AC53).withOpacity(0.4),
                inactiveThumbColor: Colors.grey,
                inactiveTrackColor: Colors.black,
                onChanged: (val) {
                  setState(() => _notificationsOn = val);
                },
              ),
            ),
            const SizedBox(height: 20),

            // SECTION 3: Lainnya
            _buildSectionHeader("Lainnya"),
            const SizedBox(height: 8),

            _buildMenuCard(
              icon: Icons.content_cut_rounded,
              title: "Tentang Atma Barber",
              subtitle: "Informasi aplikasi dan layanan salon v1.0.0",
              onTap: _showAboutDialog,
            ),
            const SizedBox(height: 8),

            _buildMenuCard(
              icon: Icons.logout_rounded,
              title: "Keluar dari Akun",
              subtitle: "Akhiri sesi login saat ini",
              isDestructive: true,
              onTap: _showLogoutConfirmation,
            ),
            const SizedBox(height: 36),
          ],
        ),
      ),
    );
  }

  /// Helper to build stat columns.
  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: const Color(0xFFE0AC53), size: 15),
            const SizedBox(width: 4),
            Text(
              value,
              style: const TextStyle(
                color: Color(0xFFE0AC53),
                fontFamily: 'Inter',
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 3),
        Text(
          label,
          style: const TextStyle(
            color: Colors.grey,
            fontFamily: 'Inter',
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  /// Helper for section titles.
  Widget _buildSectionHeader(String title) {
    return Row(
      children: [
        Container(
          width: 3.5,
          height: 14,
          decoration: BoxDecoration(
            color: const Color(0xFFE0AC53),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            color: Color(0xFFE0AC53),
            fontFamily: 'Inter',
            fontSize: 14,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.3,
          ),
        ),
      ],
    );
  }

  /// Modern dark-and-gold menu card.
  Widget _buildMenuCard({
    required IconData icon,
    required String title,
    required String subtitle,
    Widget? trailing,
    VoidCallback? onTap,
    bool isDestructive = false,
  }) {
    final Color mainColor = isDestructive ? Colors.redAccent : const Color(0xFFE0AC53);

    return Card(
      color: Colors.grey[900],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(
          color: isDestructive ? Colors.redAccent.withOpacity(0.3) : const Color(0xFFE0AC53).withOpacity(0.2),
          width: 1,
        ),
      ),
      elevation: 2,
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(9),
                decoration: BoxDecoration(
                  color: isDestructive ? Colors.redAccent.withOpacity(0.12) : const Color(0xFFE0AC53).withOpacity(0.12),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: mainColor.withOpacity(0.35),
                  ),
                ),
                child: Icon(icon, color: mainColor, size: 20),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: isDestructive ? Colors.redAccent : Colors.white,
                        fontFamily: 'Inter',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontFamily: 'Inter',
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
              if (trailing != null)
                trailing
              else
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: isDestructive ? Colors.redAccent.withOpacity(0.6) : const Color(0xFFE0AC53),
                  size: 14,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
