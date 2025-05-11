import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/transaction_provider.dart';
import 'providers/deposito_provider.dart';
import 'providers/user_provider.dart';
import 'providers/saldo_provider.dart';
import 'login_page.dart';
import 'home_page.dart';
import 'transfer_page.dart';
import 'deposito_page.dart';
import 'payment_page.dart';
import 'loan_page.dart';
import 'mutasi_page.dart';
import 'settings_page.dart';
import 'profile_page.dart';
import 'saldo_page.dart';
import 'qr_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => SaldoProvider()),
        ChangeNotifierProvider(create: (_) => TransactionProvider()),
        ChangeNotifierProvider(create: (_) => DepositoProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Koperasi Undiksha',
      theme: ThemeData(
        primaryColor: const Color(0xFF1A237E),
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Roboto',
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1A237E),
          foregroundColor: Colors.white,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
      routes: {
        '/home': (context) => const HomePage(),
        '/transfer': (context) => const TransferPage(),
        '/deposito': (context) => const DepositoPage(),
        '/payment': (context) => const PaymentPage(),
        '/loan': (context) => const LoanPage(),
        '/mutasi': (context) => const MutasiPage(),
        '/settings': (context) => const SettingsPage(),
        '/profile': (context) => const ProfilePage(),
        '/saldo': (context) => const SaldoPage(),
        '/qrcode': (context) => const QRPage(),
      },
    );
  }
}
