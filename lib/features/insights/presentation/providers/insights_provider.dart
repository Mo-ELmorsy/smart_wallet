import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_wallet/core/di/injection.dart';
import 'package:smart_wallet/features/insights/domain/usecases/generate_monthly_insight_usecase.dart';
import 'package:smart_wallet/features/transactions/domain/models/transaction_type.dart';
import 'package:smart_wallet/features/transactions/domain/repositories/transaction_repository.dart';

part 'insights_provider.g.dart';

class InsightsState {
  final bool isLoading;
  final String? insightText;
  final String? error;
  final bool apiKeyMissing;

  InsightsState({
    this.isLoading = false,
    this.insightText,
    this.error,
    this.apiKeyMissing = false,
  });

  InsightsState copyWith({
    bool? isLoading,
    String? insightText,
    String? error,
    bool? apiKeyMissing,
  }) {
    return InsightsState(
      isLoading: isLoading ?? this.isLoading,
      insightText: insightText ?? this.insightText,
      error: error,
      apiKeyMissing: apiKeyMissing ?? this.apiKeyMissing,
    );
  }
}

@riverpod
class InsightsNotifier extends _$InsightsNotifier {
  @override
  InsightsState build() {
    return InsightsState();
  }

  Future<void> generateInsight() async {
    final prefs = getIt<SharedPreferences>();
    final apiKey = prefs.getString('gemini_api_key');
    if (apiKey == null || apiKey.isEmpty) {
      state = state.copyWith(apiKeyMissing: true, error: 'API Key missing');
      return;
    }

    state = state.copyWith(isLoading: true, error: null, apiKeyMissing: false);

    try {
      final txRepo = getIt<TransactionRepository>();
      final now = DateTime.now();
      final txRes = await txRepo.getMonthlyTransactions(now.year, now.month);

      String prompt = '';
      txRes.fold(
        (l) => throw Exception(l.message),
        (transactions) {
          if (transactions.isEmpty) {
            prompt = "The user has no transactions for this month. Provide a short, encouraging message about tracking their finances and setting a goal.";
          } else {
            double income = 0;
            double expenses = 0;
            final Map<String, double> categoryExpenses = {};

            for (var tx in transactions) {
              if (tx.type == TransactionType.income) {
                income += tx.amount;
              } else if (tx.type == TransactionType.expense) {
                expenses += tx.amount;
                final catName = tx.categoryName ?? 'Unknown';
                categoryExpenses[catName] = (categoryExpenses[catName] ?? 0) + tx.amount;
              }
            }

            final net = income - expenses;
            
            prompt = '''
You are an AI financial advisor named SmartWallet Assistant. 
Here is the user's financial summary for this month:
- Total Income: \$${income.toStringAsFixed(2)}
- Total Expenses: \$${expenses.toStringAsFixed(2)}
- Net Balance: \$${net.toStringAsFixed(2)}
- Spending by Category:
${categoryExpenses.entries.map((e) => '  * ${e.key}: \$${e.value.toStringAsFixed(2)}').join('\n')}

Based on this data, provide a very concise, practical 3-bullet point summary of insights and 1 recommendation for next month. 
Do not expose any sensitive info. Keep it encouraging but realistic.
''';
          }
        },
      );

      final usecase = getIt<GenerateMonthlyInsightUseCase>();
      final result = await usecase(prompt);

      result.fold(
        (l) {
          if (l.message.contains('API Key')) {
            state = state.copyWith(isLoading: false, apiKeyMissing: true, error: l.message);
          } else {
            state = state.copyWith(isLoading: false, error: l.message);
          }
        },
        (r) {
          state = state.copyWith(isLoading: false, insightText: r);
        },
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}
