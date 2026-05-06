import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:smart_wallet/features/budgets/domain/models/goal.dart';
import 'package:smart_wallet/features/budgets/presentation/providers/goals_provider.dart';

class GoalsScreen extends ConsumerWidget {
  const GoalsScreen({super.key});

  void _showAddGoalModal(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
        child: const _AddGoalForm(),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goalsAsync = ref.watch(goalsNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Goals'),
      ),
      body: goalsAsync.when(
        data: (goals) {
          if (goals.isEmpty) {
            return const Center(child: Text('No goals yet. Start saving!'));
          }
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(goalsNotifierProvider),
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: goals.length,
              itemBuilder: (context, index) {
                final goal = goals[index];
                return _buildGoalCard(context, ref, goal);
              },
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error: $e')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddGoalModal(context, ref),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildGoalCard(BuildContext context, WidgetRef ref, Goal goal) {
    final double progress = goal.targetAmount > 0 ? (goal.currentAmount / goal.targetAmount) : 0;
    
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
                  goal.name,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.grey),
                  onPressed: () {
                    ref.read(goalsNotifierProvider.notifier).deleteGoal(goal.id);
                  },
                ),
              ],
            ),
            Text(
              'Target Date: ${DateFormat.yMMMd().format(goal.targetDate)}',
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('\$${goal.currentAmount.toStringAsFixed(2)} saved'),
                Text('\$${goal.targetAmount.toStringAsFixed(2)} target'),
              ],
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: progress > 1.0 ? 1.0 : progress,
              backgroundColor: Colors.grey.shade200,
              color: Color(goal.colorCode),
              minHeight: 10,
            ),
            const SizedBox(height: 8),
            Text(
              '${(progress * 100).toStringAsFixed(1)}% Completed',
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class _AddGoalForm extends ConsumerStatefulWidget {
  const _AddGoalForm();

  @override
  ConsumerState<_AddGoalForm> createState() => _AddGoalFormState();
}

class _AddGoalFormState extends ConsumerState<_AddGoalForm> {
  final _nameController = TextEditingController();
  final _targetController = TextEditingController();
  final _currentController = TextEditingController();
  DateTime _selectedDate = DateTime.now().add(const Duration(days: 30));

  @override
  void dispose() {
    _nameController.dispose();
    _targetController.dispose();
    _currentController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_nameController.text.isEmpty || _targetController.text.isEmpty) return;
    
    final target = double.tryParse(_targetController.text) ?? 0.0;
    final current = double.tryParse(_currentController.text) ?? 0.0;
    
    if (target <= 0) return;

    final goal = Goal(
      id: const Uuid().v4(),
      name: _nameController.text,
      targetAmount: target,
      currentAmount: current,
      targetDate: _selectedDate,
      colorCode: Colors.blue.toARGB32(),
    );

    ref.read(goalsNotifierProvider.notifier).addGoal(goal);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text('Add Goal', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: 'Goal Name', border: OutlineInputBorder()),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _targetController,
                  decoration: const InputDecoration(labelText: 'Target Amount', border: OutlineInputBorder()),
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TextField(
                  controller: _currentController,
                  decoration: const InputDecoration(labelText: 'Current Saved', border: OutlineInputBorder()),
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ListTile(
            title: const Text('Target Date'),
            subtitle: Text(DateFormat.yMMMd().format(_selectedDate)),
            trailing: const Icon(Icons.calendar_today),
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.circular(4),
            ),
            onTap: () async {
              final date = await showDatePicker(
                context: context,
                initialDate: _selectedDate,
                firstDate: DateTime.now(),
                lastDate: DateTime(2100),
              );
              if (date != null) {
                setState(() => _selectedDate = date);
              }
            },
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _submit,
            child: const Text('Save Goal'),
          ),
        ],
      ),
    );
  }
}
