import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color(0xFF1A237E),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 54,
                backgroundColor: Color(0xFF1A237E),
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/profile_pic.jpg'),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Kadek Sandyari Desy',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              const Text(
                'Nasabah Aktif',
                style: TextStyle(fontSize: 15, color: Colors.grey),
              ),
              const SizedBox(height: 24),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.badge, color: Color(0xFF1A237E)),
                        title: const Text('NIM'),
                        subtitle: const Text('2315091017'),
                      ),
                      const Divider(),
                      ListTile(
                        leading: const Icon(Icons.email, color: Color(0xFF1A237E)),
                        title: const Text('Email'),
                        subtitle: const Text('sandyari@student.undiksha.ac.id'),
                      ),
                      const Divider(),
                      ListTile(
                        leading: const Icon(Icons.phone, color: Color(0xFF1A237E)),
                        title: const Text('No. HP'),
                        subtitle: const Text('0819-3211-6215'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.edit),
                  label: const Text('Edit Profil'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1A237E),
                    foregroundColor: Colors.white,
                    disabledForegroundColor: Colors.white70,
                    disabledBackgroundColor: Color(0xFF1A237E).withOpacity(0.5),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
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
