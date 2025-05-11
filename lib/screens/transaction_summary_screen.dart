import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:kobi_pay_assessment/constants/app_colors.dart';
import 'package:kobi_pay_assessment/constants/app_strings.dart';
import 'package:kobi_pay_assessment/constants/app_text_styles.dart';
import 'package:kobi_pay_assessment/widgets/expense_chart.dart';
import '../providers/transaction_provider.dart';
import '../widgets/transaction_card.dart';
import 'transaction_detail_screen.dart';

class TransactionSummaryScreen extends ConsumerWidget {
  const TransactionSummaryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactionsAsync = ref.watch(filteredTransactionsProvider);
    final selectedMonth = ref.watch(selectedMonthProvider);
    final totalAsync = ref.watch(totalAmountProvider);

    final allMonths = List.generate(12, (index) => index + 1);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 26.0, vertical: 22),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Back button
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(16),
                        bottom: Radius.circular(16),
                      ),
                      child: Container(
                        width: 35,
                        height: 48,
                         color: AppColors.white,
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          icon: const Icon(Icons.keyboard_arrow_left, color: AppColors.text),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),


                    // Title
                    Text(AppText.history, style: AppTextStyles.appBarTitle),

                    // Actions (3-dot menu)
                    IconButton(
                      icon: const Icon(Icons.more_vert, color: AppColors.text),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => Container(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  leading: const Icon(Icons.refresh, color: AppColors.text),
                                  title: Text('Refresh', style: AppTextStyles.month),
                                  onTap: () {
                                    Navigator.pop(context);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Refreshed')),
                                    );
                                  },
                                ),
                                ListTile(
                                  leading: const Icon(Icons.filter_list, color: AppColors.text),
                                  title: Text('Filter', style: AppTextStyles.month),
                                  onTap: () {
                                    Navigator.pop(context);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Filter applied')),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              Image.asset(
                'assets/images/netflix_logo.jpeg',
                width: 60,
                height: 60,
              ),
              const SizedBox(height: 12),

              Text(AppText.netflix, style: AppTextStyles.netflixTitle),
              const SizedBox(height: 4),

              Text(AppText.productionCompany,
                  style: AppTextStyles.productionCompany),
              const SizedBox(height: 26),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 26.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(AppText.totalPayment,
                            style: AppTextStyles.totalPayment),
                        const SizedBox(height: 4),
                        totalAsync.when(
                          data: (total) => RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: total.abs().toStringAsFixed(2),
                                  style: AppTextStyles.totalAmount,
                                ),
                                WidgetSpan(
                                  child: Transform.translate(
                                    offset: const Offset(2, -2),
                                    child: Text(
                                      '\$',
                                      style: TextStyle(
                                        color: Colors.orange,
                                        fontSize: AppTextStyles.totalAmount.fontSize! * 0.7,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          loading: () => const SpinKitFadingCircle(
                              color: AppColors.text, size: 20),
                          error: (e, _) => Text('Error: $e',
                              style: AppTextStyles.totalAmount.copyWith(
                                  color: Colors.red)),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: PopupMenuButton<int>(
                        offset: const Offset(0, 40),
                        itemBuilder: (context) => allMonths.map((month) {
                          final monthName =
                          DateFormat('MMMM').format(DateTime(2025, month));
                          return PopupMenuItem(
                            value: month,
                            child: Text(monthName, style: AppTextStyles.month),
                          );
                        }).toList(),
                        onSelected: (value) {
                          ref.read(selectedMonthProvider.notifier).state = value;
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              DateFormat('MMMM')
                                  .format(DateTime(2025, selectedMonth)),
                              style: AppTextStyles.month,
                            ),
                            const SizedBox(width: 4),
                            const Icon(Icons.keyboard_arrow_down,
                                color: AppColors.text, size: 20),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: totalAsync.when(
                  data: (total) => ExpenseChart(total: total),
                  loading: () => const SpinKitFadingCircle(
                      color: AppColors.text, size: 50),
                  error: (e, _) => Text('Error: $e',
                      style: AppTextStyles.pieChartAmount.copyWith(
                          color: Colors.red)),
                ),
              ),
              const SizedBox(height: 16),

              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 26.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppText.transactions,
                        style: AppTextStyles.transactionsHeader),
                    const SizedBox(height: 12),
                    transactionsAsync.when(
                      data: (transactions) => transactions.isEmpty
                          ? Center(
                          child: Text('No transactions available',
                              style: AppTextStyles.month))
                          : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: transactions.length,
                        itemBuilder: (context, index) {
                          final transaction = transactions[index];
                          return TransactionCard(
                            transaction: transaction,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => TransactionDetailScreen(
                                      transaction: transaction),
                                ),
                              );
                            },
                          );
                        },
                      ),
                      loading: () => const SpinKitFadingCircle(
                          color: AppColors.text, size: 50),
                      error: (e, _) => Text('Error: $e',
                          style: AppTextStyles.transactionsHeader.copyWith(
                              color: Colors.red)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

