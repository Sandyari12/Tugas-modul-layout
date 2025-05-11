import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/saldo_provider.dart';
import 'providers/deposito_provider.dart';

class DepositoPage extends StatefulWidget {
  const DepositoPage({super.key});

  @override
  State<DepositoPage> createState() => _DepositoPageState();
}

class _DepositoPageState extends State<DepositoPage> {
  final TextEditingController _nominalController = TextEditingController();
  final TextEditingController _catatanController = TextEditingController();
  final List<int> _jangkaWaktu = [3, 6, 12];
  int selectedJangkaWaktu = 6;

  void _submitDeposito() {
    final amount = double.tryParse(_nominalController.text) ?? 0;
    if (amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nominal deposito tidak valid')),
      );
      return;
    }
    // Update saldo
    Provider.of<SaldoProvider>(context, listen: false).kurangSaldo(amount);
    // Add to DepositoProvider
    Provider.of<DepositoProvider>(context, listen: false).addDeposito(
      amount,
      selectedJangkaWaktu,
      _catatanController.text,
    );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Deposito sebesar Rp $amount berhasil!')),
    );
    _nominalController.clear();
    _catatanController.clear();
  }

  void _showConfirmationDialog() {
    final amount = double.tryParse(_nominalController.text) ?? 0;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Konfirmasi Deposito'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nominal: Rp \\${amount.toStringAsFixed(0)}'),
            Text('Jangka Waktu: \\${selectedJangkaWaktu} bulan'),
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
              _submitDeposito();
            },
            child: const Text('Ya, Deposito'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final depositoList = Provider.of<DepositoProvider>(context).depositos;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A237E),
        title: const Text(
          'Deposito',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.savings, size: 60, color: Color(0xFF1A237E)),
              const SizedBox(height: 16),
              const Text(
                'Buka Deposito Baru',
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
                        controller: _nominalController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Nominal Deposito',
                          prefixIcon: const Icon(Icons.attach_money),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<int>(
                        value: selectedJangkaWaktu,
                        decoration: InputDecoration(
                          labelText: 'Jangka Waktu (bulan)',
                          prefixIcon: const Icon(Icons.calendar_month),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        items: _jangkaWaktu.map((bulan) {
                          return DropdownMenuItem(
                            value: bulan,
                            child: Text('$bulan Bulan'),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedJangkaWaktu = value!;
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
                          icon: const Icon(Icons.lock),
                          label: const Text('Buka Deposito', style: TextStyle(fontSize: 16)),
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
              // DAFTAR DEPOSITO
              const Text(
                'Daftar Deposito Anda',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              depositoList.isEmpty
                  ? const Text('Belum ada deposito.', style: TextStyle(color: Colors.grey))
                  : ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: depositoList.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        final deposito = depositoList[index];
                        return Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            leading: const Icon(Icons.savings, color: Color(0xFF1A237E)),
                            title: Text('Rp ${deposito.amount.toStringAsFixed(0)}'),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Jangka waktu: ${deposito.durationMonths} bulan'),
                                Text('Tanggal: ${deposito.startDate.toString().split(' ')[0]}'),
                                if (deposito.note != null && deposito.note!.isNotEmpty)
                                  Text('Catatan: ${deposito.note!}', style: const TextStyle(fontSize: 12)),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
