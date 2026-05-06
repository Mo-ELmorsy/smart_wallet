
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:smart_wallet/features/auth/presentation/screens/splash_screen.dart';
import 'package:smart_wallet/features/auth/presentation/screens/onboarding_screen.dart';
import 'package:smart_wallet/features/auth/presentation/screens/pin_setup_screen.dart';
import 'package:smart_wallet/features/auth/presentation/screens/pin_unlock_screen.dart';
import 'package:smart_wallet/features/auth/presentation/screens/settings_screen.dart';

import 'package:smart_wallet/core/router/main_shell.dart';
import 'package:smart_wallet/features/transactions/presentation/screens/dashboard_screen.dart';
import 'package:smart_wallet/features/transactions/presentation/screens/transactions_screen.dart';
import 'package:smart_wallet/features/transactions/presentation/screens/add_transaction_screen.dart';
import 'package:smart_wallet/features/transactions/presentation/screens/edit_transaction_screen.dart';
import 'package:smart_wallet/features/insights/presentation/screens/insights_screen.dart';

// Phase 5 placeholders until implemented
import 'package:smart_wallet/features/budgets/presentation/screens/budgets_screen.dart';
import 'package:smart_wallet/features/budgets/presentation/screens/goals_screen.dart';
import 'package:smart_wallet/features/budgets/presentation/screens/reports_screen.dart';

part 'app_router.g.dart';

@riverpod
GoRouter appRouter(AppRouterRef ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        name: 'onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/pin-setup',
        name: 'pin_setup',
        builder: (context, state) => const PinSetupScreen(),
      ),
      GoRoute(
        path: '/unlock',
        name: 'unlock',
        builder: (context, state) => const PinUnlockScreen(),
      ),
      ShellRoute(
        builder: (context, state, child) => MainShell(child: child),
        routes: [
          GoRoute(
            path: '/home',
            name: 'home',
            builder: (context, state) => const DashboardScreen(),
          ),
          GoRoute(
            path: '/transactions',
            name: 'transactions',
            builder: (context, state) => const TransactionsScreen(),
          ),
          GoRoute(
            path: '/budgets',
            name: 'budgets',
            builder: (context, state) => const BudgetsScreen(),
          ),
          GoRoute(
            path: '/goals',
            name: 'goals',
            builder: (context, state) => const GoalsScreen(),
          ),
          GoRoute(
            path: '/reports',
            name: 'reports',
            builder: (context, state) => const ReportsScreen(),
          ),
        ],
      ),
      GoRoute(
        path: '/transactions/add',
        name: 'add_transaction',
        builder: (context, state) => const AddTransactionScreen(),
      ),
      GoRoute(
        path: '/transactions/edit/:id',
        name: 'edit_transaction',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return EditTransactionScreen(transactionId: id);
        },
      ),
      GoRoute(
        path: '/insights',
        name: 'insights',
        builder: (context, state) => const InsightsScreen(),
      ),
      GoRoute(
        path: '/settings',
        name: 'settings',
        builder: (context, state) => const SettingsScreen(),
      ),
    ],
  );
}
