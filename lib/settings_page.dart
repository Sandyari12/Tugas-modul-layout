import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  Future<void> _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn');
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color(0xFF1A237E),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.lock, color: Color(0xFF1A237E)),
                  title: const Text('Ganti Password'),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Fitur belum tersedia')),
                    );
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.notifications, color: Color(0xFF1A237E)),
                  title: const Text('Notifikasi'),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Fitur belum tersedia')),
                    );
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.info, color: Color(0xFF1A237E)),
                  title: const Text('Tentang Aplikasi'),
                  onTap: () {
                    showAboutDialog(
                      context: context,
                      applicationName: 'Koperasi Undiksha',
                      applicationVersion: '1.0.0',
                      applicationLegalese: '© 2025 Undiksha',
                    );
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.logout, color: Color(0xFF1A237E)),
                  title: const Text('Logout'),
                  onTap: () {
                    _logout(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
