import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/saldo_provider.dart';
import 'providers/transaction_provider.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final TextEditingController _nominalController = TextEditingController();
  final TextEditingController _nomorPelangganController = TextEditingController();
  final TextEditingController _catatanController = TextEditingController();
  String _selectedService = 'Listrik';
  final List<String> _services = ['Listrik', 'Air', 'Internet', 'TV Kabel'];

  void _submitPayment() {
    final amount = double.tryParse(_nominalController.text) ?? 0;
    if (_nomorPelangganController.text.isEmpty || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nomor pelanggan dan nominal harus diisi dengan benar')),
      );
      return;
    }
    
    // Update saldo
    Provider.of<SaldoProvider>(context, listen: false).kurangSaldo(amount);
    
    // Add transaction record
    Provider.of<TransactionProvider>(context, listen: false).addPayment(
      _selectedService,
      amount,
      'Pembayaran $_selectedService - No. Pelanggan: ${_nomorPelangganController.text}${_catatanController.text.isNotEmpty ? ' - ${_catatanController.text}' : ''}',
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Pembayaran $_selectedService sebesar Rp $amount berhasil!')),
    );
    _nomorPelangganController.clear();
    _nominalController.clear();
    _catatanController.clear();
  }

  void _showConfirmationDialog() {
    final amount = double.tryParse(_nominalController.text) ?? 0;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Konfirmasi Pembayaran'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Layanan: \\${_selectedService}'),
            Text('Nomor Pelanggan: \\${_nomorPelangganController.text}'),
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
              _submitPayment();
            },
            child: const Text('Ya, Bayar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pembayaran', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color(0xFF1A237E),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.payment, size: 60, color: Color(0xFF1A237E)),
              const SizedBox(height: 16),
              const Text(
                'Pembayaran Tagihan',
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
                      DropdownButtonFormField<String>(
                        value: _selectedService,
                        decoration: InputDecoration(
                          labelText: 'Pilih Layanan',
                          prefixIcon: const Icon(Icons.list),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        items: _services.map((service) {
                          return DropdownMenuItem(
                            value: service,
                            child: Text(service),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedService = value!;
                          });
                        },
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _nomorPelangganController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Nomor Pelanggan',
                          prefixIcon: const Icon(Icons.confirmation_number),
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
                          labelText: 'Nominal Pembayaran',
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
                          label: const Text('Bayar', style: TextStyle(fontSize: 16)),
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
