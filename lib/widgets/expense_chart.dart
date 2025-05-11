import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kobi_pay_assessment/constants/app_colors.dart';
import 'package:kobi_pay_assessment/constants/app_text_styles.dart';
import 'package:kobi_pay_assessment/providers/transaction_provider.dart';

class ExpenseChart extends ConsumerWidget {
  final double total;

  const ExpenseChart({super.key, required this.total});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filteredTransactions = ref.watch(filteredTransactionsProvider);

    final totalAbs = filteredTransactions.when(
      data: (transactions) => transactions.fold(
          0.0, (sum, t) => sum + t.amount.abs()),
      loading: () => 0.0,
      error: (_, __) => 0.0,
    );

    final sections = filteredTransactions.when(
      data: (transactions) => transactions.isNotEmpty
          ? transactions.asMap().entries.map((entry) {
        final index = entry.key;
        final transaction = entry.value;
        final percentage = (transaction.amount.abs() / totalAbs) * 100;
        return PieChartSectionData(
          value: percentage,
          color: AppColors.pieChart[index % AppColors.pieChart.length],
          title: '',
          radius: 50,
        );
      }).toList()
          : [
        PieChartSectionData(
          value: 100,
          color: AppColors.pieChart[0],
          title: '',
          radius: 50,
        ),
      ],
      loading: () => [
        PieChartSectionData(
          value: 100,
          color: AppColors.pieChart[0],
          title: '',
          radius: 50,
        ),
      ],
      error: (_, __) => [
        PieChartSectionData(
          value: 100,
          color: AppColors.pieChart[0],
          title: '',
          radius: 50,
        ),
      ],
    );

    return SizedBox(
      height: 200,
      child: Stack(
        alignment: Alignment.center,
        children: [
          PieChart(
            PieChartData(
              sections: sections,
              centerSpaceRadius: 60,
              sectionsSpace: 2,
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: total.abs().toStringAsFixed(2),
                      style: AppTextStyles.pieChartAmount.copyWith(color: Colors.black),
                    ),

                    WidgetSpan(
                      child: Transform.translate(
                        offset: Offset(0, -2),
                        child: Text(
                          '\$',
                          style: TextStyle(
                            color: Colors.orange,
                            fontSize: AppTextStyles.pieChartAmount.fontSize! * 0.7,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Text(
                'Netflix Expenses',
                style: AppTextStyles.transactionTitle.copyWith(fontSize: 12),
              ),
            ],
          ),


        ],
      ),
    );
  }
}

