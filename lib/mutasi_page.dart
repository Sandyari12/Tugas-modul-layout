import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/transaction_provider.dart';

class MutasiPage extends StatefulWidget {
  const MutasiPage({super.key});

  @override
  State<MutasiPage> createState() => _MutasiPageState();
}

class _MutasiPageState extends State<MutasiPage> {
  String _selectedFilter = 'Semua';
  final List<String> _filters = ['Semua', 'Masuk', 'Keluar'];

  List<Transaction> _filterTransactions(List<Transaction> transactions) {
    switch (_selectedFilter) {
      case 'Masuk':
        return transactions.where((t) => t.isIncoming).toList();
      case 'Keluar':
        return transactions.where((t) => !t.isIncoming).toList();
      default:
        return transactions;
    }
  }

  @override
  Widget build(BuildContext context) {
    final transactions = Provider.of<TransactionProvider>(context).transactions;
    final filteredTransactions = _filterTransactions(transactions);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mutasi', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color(0xFF1A237E),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.bar_chart, size: 60, color: Color(0xFF1A237E)),
              const SizedBox(height: 16),
              const Text(
                'Riwayat Mutasi Rekening',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _filters.map((filter) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: ChoiceChip(
                        label: Text(filter),
                        selected: _selectedFilter == filter,
                        onSelected: (selected) {
                          if (selected) {
                            setState(() {
                              _selectedFilter = filter;
                            });
                          }
                        },
                        backgroundColor: Colors.grey.shade200,
                        selectedColor: const Color(0xFF1A237E),
                        labelStyle: TextStyle(
                          color: _selectedFilter == filter
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 24),
              if (filteredTransactions.isEmpty)
                const Center(
                  child: Text(
                    'Belum ada transaksi',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                )
              else
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: filteredTransactions.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final transaction = filteredTransactions[index];
                    return Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: transaction.isIncoming
                              ? Colors.green.shade100
                              : Colors.red.shade100,
                          child: Icon(
                            transaction.isIncoming
                                ? Icons.arrow_downward
                                : Icons.arrow_upward,
                            color: transaction.isIncoming
                                ? Colors.green
                                : Colors.red,
                          ),
                        ),
                        title: Text(
                          transaction.type,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(transaction.date.toString().split('.')[0]),
                            if (transaction.note != null && transaction.note!.isNotEmpty)
                              Text(
                                transaction.note!,
                                style: const TextStyle(fontSize: 12),
                              ),
                          ],
                        ),
                        trailing: Text(
                          (transaction.isIncoming ? '+ ' : '- ') +
                              'Rp ${transaction.amount.toStringAsFixed(0)}',
                          style: TextStyle(
                            color: transaction.isIncoming
                                ? Colors.green
                                : Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              const SizedBox(height: 24),
              Card(
                color: Colors.blue.shade50,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tips Mutasi',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '• Mutasi menampilkan riwayat transaksi terakhir Anda.',
                        style: TextStyle(fontSize: 13),
                      ),
                      Text(
                        '• Hubungi admin jika ada transaksi yang tidak dikenali.',
                        style: TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
