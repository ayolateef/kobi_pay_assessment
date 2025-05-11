
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kobi_pay_assessment/constants/app_colors.dart';
import 'package:kobi_pay_assessment/constants/app_strings.dart';
import 'package:kobi_pay_assessment/constants/app_text_styles.dart';
import 'package:kobi_pay_assessment/widgets/fade_in_animation.dart';
import '../models/transactions.dart';

class TransactionCard extends StatelessWidget {
  final Transaction transaction;
  final VoidCallback onTap;

  const TransactionCard(
      {super.key, required this.transaction, required this.onTap});

  String _formatDate(String dateStr) {
    final now = DateTime.now();
    final date = DateTime.parse(dateStr);
    final formatter = DateFormat('HH:mm');

    if (date.day == now.day &&
        date.month == now.month &&
        date.year == now.year) {
      return 'Today, ${formatter.format(date)}';
    } else if (date.day == now.day - 1 &&
        date.month == now.month &&
        date.year == now.year) {
      return 'Yesterday, ${formatter.format(date)}';
    } else {
      return DateFormat('MMM d, HH:mm').format(date);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FadeInAnimation(
      child: Card(
        elevation: 0.1,
        color: AppColors.card,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
              children: [
                Image.asset(
                  transaction.merchantImage,
                  width: 60,
                  height: 60,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.error),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(AppText.netflixPremium,
                          style: AppTextStyles.transactionTitle),
                      const SizedBox(height: 6,),
                      Text(_formatDate(transaction.date),
                          style: AppTextStyles.transactionDate),
                    ],
                  ),
                ),
                const SizedBox(height: 10,),
                Text(
                  transaction.amount < 0
                      ? '-\$${transaction.amount.abs().toStringAsFixed(2)}'
                      : '\$${transaction.amount.toStringAsFixed(2)}',
                  style: AppTextStyles.transactionAmount,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
