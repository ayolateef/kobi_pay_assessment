import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/transactions.dart';
import '../services/api_service.dart';


final apiServiceProvider = Provider((ref) => ApiService());

final allTransactionsProvider =
FutureProvider<List<Transaction>>((ref) async {
  final apiService = ref.watch(apiServiceProvider);
  return apiService.fetchAllTransactions();
});

final selectedMonthProvider = StateProvider<int>((ref) {
  return DateTime.now().month;
});

final filteredTransactionsProvider =
FutureProvider<List<Transaction>>((ref) async {
  final selectedMonth = ref.watch(selectedMonthProvider);
  final apiService = ref.watch(apiServiceProvider);
  return apiService.fetchTransactionsByMonth(selectedMonth);
});

final totalAmountProvider = FutureProvider<double>((ref) async {
  final filteredTransactions = await ref.watch(filteredTransactionsProvider.future);
  double total = 0.0;
  for (var t in filteredTransactions) {
    total += t.amount;
  }
  return total;
});

final transactionStatusProvider =
StateProvider.family<String, int>((ref, transactionId) => 'Completed');

final availableMonthsProvider = FutureProvider<List<int>>((ref) async {
  final transactions = await ref.watch(allTransactionsProvider.future);
  final months = transactions
      .map((t) => DateTime.parse(t.date).month)
      .toSet()
      .toList()
    ..sort();
  return months;
});