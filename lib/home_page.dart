import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'login_page.dart';
import 'providers/saldo_provider.dart';
import 'providers/user_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
    double saldo = Provider.of<SaldoProvider>(context).saldo;
    String formattedSaldo = 'Rp. ${saldo.toStringAsFixed(0).replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    )}';
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A237E),
        title: const Text(
          "Koperasi Undiksha",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app, color: Colors.white, size: 28),
            onPressed: () {
              _logout(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),
            // Kartu profil
            Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Color(0xFFE3EAFE),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      'assets/profile_pic.jpg',
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Nasabah',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        const Text(
                          'Kadek Sandyari Desy',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Total Saldo Anda',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        Text(
                          formattedSaldo,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Grid menu
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Color(0xFFE3EAFE),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
              ),
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 3,
                childAspectRatio: 1.1,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildMenuItem(Icons.account_balance_wallet, 'Cek Saldo', context, '/saldo'),
                  _buildMenuItem(Icons.upload, 'Transfer', context, '/transfer'),
                  _buildMenuItem(Icons.savings, 'Deposito', context, '/deposito'),
                  _buildMenuItem(Icons.payment, 'Pembayaran', context, '/payment'),
                  _buildMenuItem(Icons.credit_score, 'Pinjaman', context, '/loan'),
                  _buildMenuItem(Icons.bar_chart, 'Mutasi', context, '/mutasi'),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Card bantuan
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Color(0xFFE3EAFE),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
              ),
              child: Row(
                children: [
                  const Icon(Icons.phone, color: Color(0xFF1A237E), size: 32),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'Butuh Bantuan?\n0878-1234-1024',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.call, color: Colors.green, size: 32),
                    onPressed: () {
                      // Logic call nanti
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.settings, color: Colors.blue, size: 32),
                  onPressed: () {
                    Navigator.pushNamed(context, '/settings');
                  },
                ),
                const Text('Setting', style: TextStyle(fontSize: 12, color: Colors.blue, fontWeight: FontWeight.w600)),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.3),
                    blurRadius: 16,
                    spreadRadius: 2,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: FloatingActionButton(
                backgroundColor: const Color(0xFF1A237E),
                elevation: 8,
                child: const Icon(Icons.qr_code_scanner, color: Colors.white, size: 40),
                onPressed: () {
                  Navigator.pushNamed(context, '/qrcode');
                },
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.person, color: Colors.blue, size: 32),
                  onPressed: () {
                    Navigator.pushNamed(context, '/profile');
                  },
                ),
                const Text('Profile', style: TextStyle(fontSize: 12, color: Colors.blue, fontWeight: FontWeight.w600)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String label, BuildContext context, String routeName) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, routeName),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Colors.blue, size: 32),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
