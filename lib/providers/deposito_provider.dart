import 'package:flutter/foundation.dart';

class Deposito {
  final double amount;
  final int durationMonths;
  final DateTime startDate;
  final String? note;

  Deposito({
    required this.amount,
    required this.durationMonths,
    required this.startDate,
    this.note,
  });
}

class DepositoProvider with ChangeNotifier {
  final List<Deposito> _depositos = [];

  List<Deposito> get depositos => [..._depositos];

  void addDeposito(double amount, int durationMonths, String? note) {
    _depositos.insert(0, Deposito(
      amount: amount,
      durationMonths: durationMonths,
      startDate: DateTime.now(),
      note: note,
    ));
    notifyListeners();
  }

  // Optional: remove deposito, get deposito by index, etc.
} 