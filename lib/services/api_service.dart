import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../models/transactions.dart';


class ApiService {


  Future<List<Transaction>> fetchAllTransactions() async {
    try {
      final String response = await rootBundle.loadString('assets/transactions.json');
      final List<dynamic> data = jsonDecode(response);
      return data.map((json) => Transaction.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Error loading transactions: $e');
    }
  }

  Future<List<Transaction>> fetchTransactionsByMonth(int month) async {
    try {
      final transactions = await fetchAllTransactions();
      return transactions.where((t) {
        final date = DateTime.parse(t.date);
        return date.month == month && date.year == 2025;
      }).toList();
    } catch (e) {
      throw Exception('Error filtering transactions for month $month: $e');
    }
  }

  Future<void> refundTransaction(int id) async {

  }

  // Future<List<Transaction>> fetchCurrentMonthTransactions() async {
  //   try {
  //     final transactions = await fetchAllTransactions();
  //     final now = DateTime.now(); // May 10, 2025
  //     return transactions.where((t) {
  //       final date = DateTime.parse(t.date);
  //       return date.year == now.year && date.month == now.month;
  //     }).toList();
  //   } catch (e) {
  //     throw Exception('Error filtering current month transactions: $e');
  //   }
  // }
  //
  // Future<List<Transaction>> fetchPreviousMonthTransactions() async {
  //   try {
  //     final transactions = await fetchAllTransactions();
  //     final now = DateTime.now();
  //     final previousMonth = now.month == 1 ? 12 : now.month - 1;
  //     final previousYear = now.month == 1 ? now.year - 1 : now.year;
  //     return transactions.where((t) {
  //       final date = DateTime.parse(t.date);
  //       return date.year == previousYear && date.month == previousMonth;
  //     }).toList();
  //   } catch (e) {
  //     throw Exception('Error filtering previous month transactions: $e');
  //   }
  // }
  //
  // Future<void> refundTransaction(int id) async {
  //   // Simulate refund by updating state in Riverpod (JSON is read-only)
  //   // No actual file modification
  // }
}