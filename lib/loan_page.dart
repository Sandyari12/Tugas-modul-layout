import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/saldo_provider.dart';
import 'providers/transaction_provider.dart';

class LoanPage extends StatefulWidget {
  const LoanPage({super.key});

  @override
  State<LoanPage> createState() => _LoanPageState();
}

class _LoanPageState extends State<LoanPage> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _catatanController = TextEditingController();
  final List<int> _durasiList = [6, 12, 24, 36];
  int selectedDurasi = 12;

  void _submitLoan() {
    final amount = double.tryParse(_amountController.text) ?? 0;
    if (amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Jumlah pinjaman tidak valid')),
      );
      return;
    }
    
    // Update saldo
    Provider.of<SaldoProvider>(context, listen: false).tambahSaldo(amount);
    
    // Add transaction record
    Provider.of<TransactionProvider>(context, listen: false).addLoan(
      amount,
      'Pinjaman ${selectedDurasi} bulan${_catatanController.text.isNotEmpty ? ' - ${_catatanController.text}' : ''}',
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Pinjaman sebesar Rp $amount berhasil dicairkan!')),
    );
    _amountController.clear();
    _catatanController.clear();
  }

  void _showConfirmationDialog() {
    final amount = double.tryParse(_amountController.text) ?? 0;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Konfirmasi Pinjaman'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Jumlah Pinjaman: Rp \\${amount.toStringAsFixed(0)}'),
            Text('Durasi Cicilan: \\${selectedDurasi} bulan'),
            if (_catatanController.text.isNotEmpty)
              Text('Catatan: \\${_catatanController.text}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _submitLoan();
            },
            child: const Text('Ya, Ajukan'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pinjaman', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color(0xFF1A237E),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.credit_score, size: 60, color: Color(0xFF1A237E)),
              const SizedBox(height: 16),
              const Text(
                'Ajukan Pinjaman',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: _amountController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Jumlah Pinjaman',
                          prefixIcon: const Icon(Icons.attach_money),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<int>(
                        value: selectedDurasi,
                        decoration: InputDecoration(
                          labelText: 'Durasi Cicilan (bulan)',
                          prefixIcon: const Icon(Icons.calendar_month),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        items: _durasiList.map((bulan) {
                          return DropdownMenuItem(
                            value: bulan,
                            child: Text('$bulan Bulan'),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedDurasi = value!;
                          });
                        },
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _catatanController,
                        decoration: InputDecoration(
                          labelText: 'Catatan (opsional)',
                          prefixIcon: const Icon(Icons.edit_note),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        maxLines: 2,
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: _showConfirmationDialog,
                          icon: const Icon(Icons.send),
                          label: const Text('Ajukan Pinjaman', style: TextStyle(fontSize: 16)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1A237E),
                            foregroundColor: Colors.white,
                            disabledForegroundColor: Colors.white70,
                            disabledBackgroundColor: Color(0xFF1A237E).withOpacity(0.5),
                            padding: const EdgeInsets.symmetric(vertical: 16),
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
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
