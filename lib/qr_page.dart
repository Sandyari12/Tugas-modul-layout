import 'package:flutter/material.dart';

class QRPage extends StatelessWidget {
  const QRPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('QR Code', style: TextStyle(color: Colors.white)),
          backgroundColor: const Color(0xFF1A237E),
          iconTheme: const IconThemeData(color: Colors.white),
          bottom: const TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            tabs: [
              Tab(icon: Icon(Icons.qr_code_scanner), text: 'Scan QR'),
              Tab(icon: Icon(Icons.qr_code), text: 'QR Saya'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            // Tab 1: Scan QR (dummy)
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.qr_code_scanner, size: 100, color: Colors.grey),
                  SizedBox(height: 24),
                  Text('Fitur scan QR belum tersedia', style: TextStyle(fontSize: 16, color: Colors.grey)),
                ],
              ),
            ),
            // Tab 2: QR Saya (dummy)
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.qr_code, size: 120, color: Color(0xFF1A237E)),
                  SizedBox(height: 24),
                  Text('Nama: Kadek Sandyari Desy', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text('NIM: 2315091017', style: TextStyle(fontSize: 15)),
                  SizedBox(height: 8),
                  Text('Email: sandyari@student.undiksha.ac.id', style: TextStyle(fontSize: 15)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
} 