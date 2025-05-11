import 'package:flutter/material.dart';
import 'package:kobi_pay_assessment/screens/transaction_summary_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KobiPay Assessment',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
      ),
      home: const TransactionSummaryScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}