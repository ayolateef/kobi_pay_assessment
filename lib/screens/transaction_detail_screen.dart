import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kobi_pay_assessment/constants/app_colors.dart';
import 'package:kobi_pay_assessment/constants/app_text_styles.dart';
import 'package:kobi_pay_assessment/providers/transaction_provider.dart';
import '../models/transactions.dart';


class TransactionDetailScreen extends ConsumerWidget {
  final Transaction transaction;

  const TransactionDetailScreen({super.key, required this.transaction});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = ref.watch(transactionStatusProvider(transaction.id));
    final isRefunded = status == 'Refunded';

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.keyboard_arrow_left, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Transaction Details', style: AppTextStyles.appBarTitle),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                Image.asset(
                  transaction.merchantImage,
                  width: 100,
                  height: 100,
                  errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.error),
                ),
                const SizedBox(height: 16),
                Text(transaction.merchantName, style: AppTextStyles.netflixTitle),
                const SizedBox(height: 8),
                Text(
                    'Amount: ${transaction.amount < 0 ? '-' : ''}\$${transaction.amount.abs().toStringAsFixed(2)}',
                    style: AppTextStyles.totalPayment),
                const SizedBox(height: 8),
                Text('Payment Method: ${transaction.paymentMethod}',
                    style: AppTextStyles.totalPayment),
                const SizedBox(height: 8),
                Text('Status: $status',
                    style: TextStyle(
                        fontSize: 16,
                        color: isRefunded ? Colors.red : Colors.green)),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: isRefunded
                      ? null
                      : () {
                    ref
                        .read(transactionStatusProvider(transaction.id)
                        .notifier)
                        .state = 'Refunded';
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Transaction Refunded')),
                    );
                  },
                  child: const Text('Refund'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
