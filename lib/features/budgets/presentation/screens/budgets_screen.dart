import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:smart_wallet/features/budgets/domain/models/budget.dart';
import 'package:smart_wallet/features/budgets/presentation/providers/budgets_provider.dart';
import 'package:smart_wallet/features/transactions/domain/models/category.dart';
import 'package:smart_wallet/features/transactions/domain/models/transaction_type.dart';
import 'package:smart_wallet/features/transactions/presentation/providers/categories_provider.dart';

class BudgetsScreen extends ConsumerWidget {
  const BudgetsScreen({super.key});

  void _showAddBudgetModal(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(ctx).viewInsets.bottom,
        ),
        child: const _AddBudgetForm(),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final budgetsAsync = ref.watch(budgetsNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Budgets'),
      ),
      body: budgetsAsync.when(
        data: (budgets) {
          if (budgets.isEmpty) {
            return const Center(child: Text('No budgets this month.'));
          }
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(budgetsNotifierProvider),
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: budgets.length,
              itemBuilder: (context, index) {
                final item = budgets[index];
                return _buildBudgetCard(context, ref, item);
              },
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error: $e')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddBudgetModal(context, ref),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildBudgetCard(BuildContext context, WidgetRef ref, BudgetWithProgress item) {
    final Color progressColor = item.isOverBudget 
        ? Colors.red 
        : (item.isWarning ? Colors.orange : Colors.green);
        
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Category ID: ${item.budget.categoryId}', // ideally we look up the name
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.grey),
                  onPressed: () {
                    ref.read(budgetsNotifierProvider.notifier).deleteBudget(item.budget.id);
                  },
                )
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('\$${item.spent.toStringAsFixed(2)} spent'),
                Text('\$${item.budget.amount.toStringAsFixed(2)} total'),
              ],
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: (item.progress > 1.0) ? 1.0 : item.progress,
              backgroundColor: Colors.grey.shade200,
              color: progressColor,
              minHeight: 8,
            ),
            if (item.isOverBudget)
              const Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Text('Over budget!', style: TextStyle(color: Colors.red, fontSize: 12)),
              )
            else if (item.isWarning)
              const Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Text('Nearing budget limit', style: TextStyle(color: Colors.orange, fontSize: 12)),
              ),
          ],
        ),
      ),
    );
  }
}

class _AddBudgetForm extends ConsumerStatefulWidget {
  const _AddBudgetForm();

  @override
  ConsumerState<_AddBudgetForm> createState() => _AddBudgetFormState();
}

class _AddBudgetFormState extends ConsumerState<_AddBudgetForm> {
  final _amountController = TextEditingController();
  Category? _selectedCategory;

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_amountController.text.isEmpty || _selectedCategory == null) return;
    
    final amount = double.tryParse(_amountController.text);
    if (amount == null || amount <= 0) return;

    final now = DateTime.now();
    final budget = Budget(
      id: const Uuid().v4(),
      categoryId: _selectedCategory!.id,
      amount: amount,
      month: now.month,
      year: now.year,
    );

    ref.read(budgetsNotifierProvider.notifier).addBudget(budget);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final categoriesAsync = ref.watch(categoriesNotifierProvider);

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text('Add Budget', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          categoriesAsync.when(
            data: (categories) {
              final expCategories = categories.where((c) => c.type == TransactionType.expense).toList();
              return DropdownButtonFormField<Category>(
                decoration: const InputDecoration(labelText: 'Category', border: OutlineInputBorder()),
                initialValue: _selectedCategory,
                items: expCategories.map((c) => DropdownMenuItem(value: c, child: Text(c.name))).toList(),
                onChanged: (val) => setState(() => _selectedCategory = val),
              );
            },
            loading: () => const CircularProgressIndicator(),
            error: (e, st) => Text('Error: $e'),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _amountController,
            decoration: const InputDecoration(labelText: 'Amount Limit', border: OutlineInputBorder()),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _submit,
            child: const Text('Save Budget'),
          ),
        ],
      ),
    );
  }
}
