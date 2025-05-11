import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/saldo_provider.dart';
import 'providers/transaction_provider.dart';

class TransferPage extends StatelessWidget {
  const TransferPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _rekeningController = TextEditingController();
    final TextEditingController _nominalController = TextEditingController();
    final TextEditingController _catatanController = TextEditingController();

    void _submitTransfer() {
      final amount = double.tryParse(_nominalController.text) ?? 0;
      if (_rekeningController.text.isEmpty || amount <= 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Nomor rekening dan nominal harus diisi dengan benar')),
        );
        return;
      }
      
      // Update saldo
      Provider.of<SaldoProvider>(context, listen: false).kurangSaldo(amount);
      
      // Add transaction record
      Provider.of<TransactionProvider>(context, listen: false).addTransfer(
        amount,
        'Transfer ke ${_rekeningController.text}${_catatanController.text.isNotEmpty ? ' - ${_catatanController.text}' : ''}',
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Transfer sebesar Rp $amount berhasil!')),
      );
      _rekeningController.clear();
      _nominalController.clear();
      _catatanController.clear();
    }

    void _showConfirmationDialog() {
      final amount = double.tryParse(_nominalController.text) ?? 0;
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Konfirmasi Transfer'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('No. Rekening Tujuan: \\${_rekeningController.text}'),
              Text('Nominal: Rp \\${amount.toStringAsFixed(0)}'),
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
                _submitTransfer();
              },
              child: const Text('Ya, Transfer'),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Transfer', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color(0xFF1A237E),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.upload_rounded, size: 60, color: Color(0xFF1A237E)),
              const SizedBox(height: 16),
              const Text(
                'Transfer Dana',
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
                        controller: _rekeningController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'No. Rekening Tujuan',
                          prefixIcon: const Icon(Icons.account_balance),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _nominalController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Nominal Transfer',
                          prefixIcon: const Icon(Icons.attach_money),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
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
                          label: const Text('Kirim Transfer', style: TextStyle(fontSize: 16)),
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
              const Text(
                'Pastikan nomor rekening tujuan sudah benar sebelum melakukan transfer.',
                style: TextStyle(color: Colors.grey, fontSize: 13),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}