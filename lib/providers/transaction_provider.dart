import 'package:flutter/foundation.dart';

class Transaction {
  final String type;
  final double amount;
  final DateTime date;
  final bool isIncoming;
  final String? note;

  Transaction({
    required this.type,
    required this.amount,
    required this.date,
    required this.isIncoming,
    this.note,
  });
}

class TransactionProvider with ChangeNotifier {
  final List<Transaction> _transactions = [];

  List<Transaction> get transactions => [..._transactions];

  void addTransaction(Transaction transaction) {
    _transactions.insert(0, transaction); // Add new transaction at the beginning
    notifyListeners();
  }

  void addTransfer(double amount, String note) {
    addTransaction(
      Transaction(
        type: 'Transfer',
        amount: amount,
        date: DateTime.now(),
        isIncoming: false,
        note: note,
      ),
    );
  }

  void addPayment(String service, double amount, String note) {
    addTransaction(
      Transaction(
        type: 'Pembayaran $service',
        amount: amount,
        date: DateTime.now(),
        isIncoming: false,
        note: note,
      ),
    );
  }

  void addDeposito(double amount, String note) {
    addTransaction(
      Transaction(
        type: 'Deposito',
        amount: amount,
        date: DateTime.now(),
        isIncoming: false,
        note: note,
      ),
    );
  }

  void addLoan(double amount, String note) {
    addTransaction(
      Transaction(
        type: 'Pinjaman',
        amount: amount,
        date: DateTime.now(),
        isIncoming: true,
        note: note,
      ),
    );
  }
} 