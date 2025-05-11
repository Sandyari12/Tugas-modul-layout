import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  String? nim;
  String? nama;
  String? email;
  bool isLoggedIn = false;

  void login({required String nim, required String nama, required String email}) {
    this.nim = nim;
    this.nama = nama;
    this.email = email;
    isLoggedIn = true;
    notifyListeners();
  }

  void logout() {
    nim = null;
    nama = null;
    email = null;
    isLoggedIn = false;
    notifyListeners();
  }
} 