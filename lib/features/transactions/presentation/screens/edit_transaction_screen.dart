import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:smart_wallet/features/transactions/domain/models/category.dart';
import 'package:smart_wallet/features/transactions/domain/models/transaction.dart';
import 'package:smart_wallet/features/transactions/domain/models/transaction_type.dart';
import 'package:smart_wallet/features/transactions/presentation/providers/categories_provider.dart';
import 'package:smart_wallet/features/transactions/presentation/providers/transactions_provider.dart';

class EditTransactionScreen extends ConsumerStatefulWidget {
  final String transactionId;

  const EditTransactionScreen({super.key, required this.transactionId});

  @override
  ConsumerState<EditTransactionScreen> createState() => _EditTransactionScreenState();
}

class _EditTransactionScreenState extends ConsumerState<EditTransactionScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _amountController;
  late TextEditingController _noteController;
  
  TransactionType _selectedType = TransactionType.expense;
  Category? _selectedCategory;
  DateTime _selectedDate = DateTime.now();
  Transaction? _existingTransaction;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController();
    _noteController = TextEditingController();
  }

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  void _initializeData(List<Transaction> transactions, List<Category> categories) {
    if (_initialized) return;
    
    try {
      _existingTransaction = transactions.firstWhere((t) => t.id == widget.transactionId);
      _amountController.text = _existingTransaction!.amount.toString();
      _noteController.text = _existingTransaction!.note ?? '';
      _selectedType = _existingTransaction!.type;
      _selectedDate = _existingTransaction!.date;
      
      try {
        _selectedCategory = categories.firstWhere((c) => c.id == _existingTransaction!.categoryId);
      } catch (_) {
        _selectedCategory = null;
      }
      _initialized = true;
    } catch (e) {
      // Transaction not found
    }
  }

  Future<void> _updateTransaction() async {
    if (_formKey.currentState!.validate() && _selectedCategory != null && _existingTransaction != null) {
      final amount = double.tryParse(_amountController.text) ?? 0.0;
      
      final updatedTransaction = _existingTransaction!.copyWith(
        amount: amount,
        type: _selectedType,
        categoryId: _selectedCategory!.id,
        date: _selectedDate,
        note: _noteController.text,
        updatedAt: DateTime.now(),
        categoryName: _selectedCategory!.name,
        categoryColorCode: _selectedCategory!.colorCode,
      );

      try {
        await ref.read(transactionsNotifierProvider.notifier).updateTransaction(updatedTransaction);
        ref.invalidate(dashboardSummaryNotifierProvider);
        if (mounted) {
          context.pop();
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
        }
      }
    } else if (_selectedCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please select a category')));
    }
  }

  Future<void> _deleteTransaction() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Transaction'),
        content: const Text('Are you sure you want to delete this transaction?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Delete', style: TextStyle(color: Colors.red))),
        ],
      ),
    );

    if (confirm == true) {
      try {
        await ref.read(transactionsNotifierProvider.notifier).deleteTransaction(widget.transactionId);
        ref.invalidate(dashboardSummaryNotifierProvider);
        if (mounted) {
          context.pop();
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final categoriesAsync = ref.watch(categoriesNotifierProvider);
    final transactionsAsync = ref.watch(transactionsNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Transaction'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: _deleteTransaction,
          ),
        ],
      ),
      body: transactionsAsync.when(
        data: (transactions) {
          return categoriesAsync.when(
            data: (categories) {
              _initializeData(transactions, categories);
              
              if (_existingTransaction == null) {
                return const Center(child: Text('Transaction not found.'));
              }

              final filteredCategories = categories.where((c) => c.type == _selectedType).toList();
              if (_selectedCategory != null && _selectedCategory!.type != _selectedType) {
                _selectedCategory = null;
              }

              return Form(
                key: _formKey,
                child: ListView(
                  padding: const EdgeInsets.all(16.0),
                  children: [
                    SegmentedButton<TransactionType>(
                      segments: const [
                        ButtonSegment(value: TransactionType.expense, label: Text('Expense')),
                        ButtonSegment(value: TransactionType.income, label: Text('Income')),
                      ],
                      selected: {_selectedType},
                      onSelectionChanged: (Set<TransactionType> newSelection) {
                        setState(() {
                          _selectedType = newSelection.first;
                        });
                      },
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: _amountController,
                      decoration: const InputDecoration(labelText: 'Amount', prefixText: '\$ ', border: OutlineInputBorder()),
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Please enter an amount';
                        final amount = double.tryParse(value);
                        if (amount == null || amount <= 0) return 'Please enter a valid amount > 0';
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<Category>(
                      decoration: const InputDecoration(labelText: 'Category', border: OutlineInputBorder()),
                      initialValue: _selectedCategory,
                      items: filteredCategories.map((cat) => DropdownMenuItem(value: cat, child: Text(cat.name))).toList(),
                      onChanged: (val) => setState(() => _selectedCategory = val),
                      validator: (value) => value == null ? 'Please select a category' : null,
                    ),
                    const SizedBox(height: 16),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('Date'),
                      subtitle: Text(DateFormat.yMMMd().format(_selectedDate)),
                      trailing: const Icon(Icons.calendar_today),
                      onTap: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: _selectedDate,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        );
                        if (date != null) setState(() => _selectedDate = date);
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _noteController,
                      decoration: const InputDecoration(labelText: 'Note (Optional)', border: OutlineInputBorder()),
                      maxLines: 2,
                    ),
                    const SizedBox(height: 32),
                    ElevatedButton(
                      onPressed: _updateTransaction,
                      style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
                      child: const Text('Update Transaction', style: TextStyle(fontSize: 16)),
                    ),
                  ],
                ),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, st) => Center(child: Text('Error: $e')),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error: $e')),
      ),
    );
  }
}
