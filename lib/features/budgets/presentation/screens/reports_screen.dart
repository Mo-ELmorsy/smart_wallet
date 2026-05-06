import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:smart_wallet/features/transactions/domain/models/transaction_type.dart';
import 'package:smart_wallet/features/transactions/presentation/providers/transactions_provider.dart';

import 'package:smart_wallet/features/budgets/domain/services/pdf_export_service.dart';

class ReportsScreen extends ConsumerWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactionsAsync = ref.watch(transactionsNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reports'),
        actions: [
          transactionsAsync.maybeWhen(
            data: (transactions) => IconButton(
              icon: const Icon(Icons.picture_as_pdf),
              tooltip: 'Export PDF',
              onPressed: () {
                final now = DateTime.now();
                double totalIncome = 0;
                double totalExpense = 0;
                final Map<String, double> categoryExpenses = {};
                final currentMonthTx = transactions.where((tx) => tx.date.month == now.month && tx.date.year == now.year).toList();

                for (var tx in currentMonthTx) {
                  if (tx.type == TransactionType.income) {
                    totalIncome += tx.amount;
                  } else if (tx.type == TransactionType.expense) {
                    totalExpense += tx.amount;
                    final catName = tx.categoryName ?? 'Unknown';
                    categoryExpenses[catName] = (categoryExpenses[catName] ?? 0) + tx.amount;
                  }
                }

                PdfExportService.exportMonthlyReport(
                  month: now,
                  totalIncome: totalIncome,
                  totalExpense: totalExpense,
                  categoryExpenses: categoryExpenses,
                  transactions: currentMonthTx,
                );
              },
            ),
            orElse: () => const SizedBox.shrink(),
          ),
        ],
      ),
      body: transactionsAsync.when(
        data: (transactions) {
          if (transactions.isEmpty) {
            return const Center(child: Text('No data for reports.'));
          }

          // Calculate current month data
          final now = DateTime.now();
          double totalIncome = 0;
          double totalExpense = 0;
          final Map<String, double> categoryExpenses = {};
          final Map<String, int> categoryColors = {};

          for (var tx in transactions) {
            if (tx.date.month == now.month && tx.date.year == now.year) {
              if (tx.type == TransactionType.income) {
                totalIncome += tx.amount;
              } else if (tx.type == TransactionType.expense) {
                totalExpense += tx.amount;
                final catName = tx.categoryName ?? 'Unknown';
                categoryExpenses[catName] = (categoryExpenses[catName] ?? 0) + tx.amount;
                if (tx.categoryColorCode != null) {
                  categoryColors[catName] = tx.categoryColorCode!;
                }
              }
            }
          }

          final topCategory = categoryExpenses.isNotEmpty 
              ? categoryExpenses.entries.reduce((a, b) => a.value > b.value ? a : b).key 
              : 'None';

          List<PieChartSectionData> pieSections = [];
          categoryExpenses.forEach((name, amount) {
            final percentage = totalExpense > 0 ? (amount / totalExpense) * 100 : 0;
            pieSections.add(
              PieChartSectionData(
                color: categoryColors[name] != null ? Color(categoryColors[name]!) : Colors.blue,
                value: amount,
                title: '${percentage.toStringAsFixed(1)}%',
                radius: 60,
                titleStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            );
          });

          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(transactionsNotifierProvider),
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                const Text(
                  'This Month\'s Overview',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Total Income:'),
                            Text('\$${totalIncome.toStringAsFixed(2)}', style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Total Expenses:'),
                            Text('\$${totalExpense.toStringAsFixed(2)}', style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Net Balance:'),
                            Text('\$${(totalIncome - totalExpense).toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Top Spending Category:'),
                        Text(topCategory, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                if (pieSections.isNotEmpty) ...[
                  const Text('Expenses by Category', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 24),
                  SizedBox(
                    height: 200,
                    child: PieChart(
                      PieChartData(
                        sections: pieSections,
                        centerSpaceRadius: 40,
                        sectionsSpace: 2,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  ...categoryExpenses.entries.map((e) {
                    final colorCode = categoryColors[e.key];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: colorCode != null ? Color(colorCode) : Colors.blue,
                        radius: 8,
                      ),
                      title: Text(e.key),
                      trailing: Text('\$${e.value.toStringAsFixed(2)}'),
                    );
                  }),
                ]
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error: $e')),
      ),
    );
  }
}
