import 'package:flutter/material.dart';
import 'home_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Koperasi Undiksha',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF1A237E),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/logo_undiksha.png', width: 120, height: 120),
              const SizedBox(height: 30),

              // FORM LOGIN + LINK DAFTAR DAN LUPA PASSWORD
              Container(
                padding: const EdgeInsets.all(16),
                width: 300, // Mengatur lebar keseluruhan form login
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Kotak Username diperkecil
                    SizedBox(
                      width: 250, // Lebar lebih kecil
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Username',
                          contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Kotak Password diperkecil
                    SizedBox(
                      width: 250, // Lebar lebih kecil
                      child: TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Tombol Login
                    SizedBox(
                    width: 200, // Lebar lebih kecil
                    child: ElevatedButton(
                    onPressed: () {
                    Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                    );
                    },
                    style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1A237E), // Warna tombol
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      elevation: 6, // Tinggi bayangan
                      shadowColor: Colors.grey, // Warna bayangan abu-abu
                    ),
                    child: const Text('Login', style: TextStyle(color: Colors.white)),
                    ),
                    ),


                    // Link Daftar Mbanking & Lupa Password
                    SizedBox(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: TextButton(
                              onPressed: () {},
                              child: const Text(
                                'Daftar Mbanking',
                                style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ),
                          Expanded(
                            child: TextButton(
                              onPressed: () {},
                              child: const Text(
                                'Lupa Password?',
                                style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40), // Tambah jarak dengan copyright

              // FOOTER COPYRIGHT
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                color: Colors.grey.shade300,
                child: const Text(
                  'Copyright @2022 by Undiksha',
                  style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
