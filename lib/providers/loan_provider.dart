import 'package:flutter/foundation.dart';

class Loan {
  final double amount;
  final int durationMonths;
  final DateTime startDate;
  final String? note;

  Loan({
    required this.amount,
    required this.durationMonths,
    required this.startDate,
    this.note,
  });
}

class LoanProvider with ChangeNotifier {
  final List<Loan> _loans = [];

  List<Loan> get loans => [..._loans];

  void addLoan(double amount, int durationMonths, [String? note]) {
    _loans.add(Loan(
      amount: amount,
      durationMonths: durationMonths,
      startDate: DateTime.now(),
      note: note,
    ));
    notifyListeners();
  }

  double getTotalLoan() {
    return _loans.fold(0, (sum, loan) => sum + loan.amount);
  }

  double getMonthlyPayment() {
    if (_loans.isEmpty) return 0;
    return getTotalLoan() / _loans.first.durationMonths;
  }
} 