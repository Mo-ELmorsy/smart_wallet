import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:smart_wallet/features/transactions/domain/models/transaction_type.dart';
import 'package:smart_wallet/features/transactions/presentation/providers/categories_provider.dart';
import 'package:smart_wallet/features/transactions/presentation/providers/transactions_provider.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Ensure categories are loaded
    ref.watch(categoriesNotifierProvider);
    
    final summaryAsync = ref.watch(dashboardSummaryNotifierProvider);
    final transactionsAsync = ref.watch(transactionsNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.push('/settings'),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: summaryAsync.when(
                data: (summary) => _buildSummaryCard(context, summary),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, st) => Center(child: Text('Error: $e')),
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                'Recent Transactions',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          transactionsAsync.when(
            data: (transactions) {
              if (transactions.isEmpty) {
                return const SliverToBoxAdapter(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(32.0),
                      child: Text('No transactions yet. Add one!'),
                    ),
                  ),
                );
              }
              final recent = transactions.take(5).toList();
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final tx = recent[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: tx.categoryColorCode != null 
                            ? Color(tx.categoryColorCode!) 
                            : Colors.blue,
                        child: Icon(
                          tx.type == TransactionType.income ? Icons.arrow_downward : Icons.arrow_upward,
                          color: Colors.white,
                        ),
                      ),
                      title: Text(tx.categoryName ?? 'Unknown'),
                      subtitle: Text(DateFormat.yMMMd().format(tx.date)),
                      trailing: Text(
                        '${tx.type == TransactionType.income ? '+' : '-'}\$${tx.amount.toStringAsFixed(2)}',
                        style: TextStyle(
                          color: tx.type == TransactionType.income ? Colors.green : Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      onTap: () {}, // Can add edit logic here
                    );
                  },
                  childCount: recent.length,
                ),
              );
            },
            loading: () => const SliverToBoxAdapter(child: Center(child: CircularProgressIndicator())),
            error: (e, st) => SliverToBoxAdapter(child: Center(child: Text('Error: $e'))),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextButton(
                onPressed: () => context.go('/transactions'),
                child: const Text('View All Transactions'),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/transactions/add'),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildSummaryCard(BuildContext context, Map<String, double> summary) {
    final formatCurrency = NumberFormat.simpleCurrency();
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Text('Total Balance', style: TextStyle(fontSize: 16, color: Colors.grey)),
            const SizedBox(height: 8),
            Text(
              formatCurrency.format(summary['balance']),
              style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildIncomeExpenseCol('Income', summary['income']!, Colors.green, Icons.arrow_downward),
                _buildIncomeExpenseCol('Expense', summary['expense']!, Colors.red, Icons.arrow_upward),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIncomeExpenseCol(String title, double amount, Color color, IconData icon) {
    final formatCurrency = NumberFormat.simpleCurrency();
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: color.withValues(alpha: 0.2),
          child: Icon(icon, color: color),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(color: Colors.grey)),
            Text(
              formatCurrency.format(amount),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ],
        ),
      ],
    );
  }
}
