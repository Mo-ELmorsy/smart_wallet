import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:smart_wallet/core/di/injection.dart';
import 'package:smart_wallet/core/router/app_router.dart';
import 'package:smart_wallet/core/theme/app_theme.dart';
import 'package:smart_wallet/features/transactions/domain/models/transaction.dart';
import 'package:smart_wallet/features/transactions/domain/models/transaction_type.dart';
import 'package:smart_wallet/features/transactions/domain/models/category.dart';
import 'package:smart_wallet/features/budgets/domain/models/budget.dart';
import 'package:smart_wallet/features/budgets/domain/models/goal.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Local Storage
  await Hive.initFlutter();
  
  // Register Hive Adapters manually or via a helper.
  Hive.registerAdapter(TransactionAdapter());
  Hive.registerAdapter(TransactionTypeAdapter());
  Hive.registerAdapter(CategoryAdapter());
  Hive.registerAdapter(BudgetAdapter());
  Hive.registerAdapter(GoalAdapter());
  
  // Initialize Dependency Injection
  await configureDependencies();

  runApp(
    const ProviderScope(
      child: SmartWalletApp(),
    ),
  );
}

class SmartWalletApp extends ConsumerWidget {
  const SmartWalletApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'SmartWallet',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: router,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''), // English
        Locale('ar', ''), // Arabic
      ],
    );
  }
}
