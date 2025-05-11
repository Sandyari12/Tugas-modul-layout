import 'package:flutter/material.dart';

class SaldoProvider with ChangeNotifier {
  double _saldo = 1200000;

  double get saldo => _saldo;

  void setSaldo(double value) {
    _saldo = value;
    notifyListeners();
  }

  void tambahSaldo(double value) {
    _saldo += value;
    notifyListeners();
  }

  void kurangSaldo(double value) {
    _saldo -= value;
    notifyListeners();
  }
} 