// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transactions_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$transactionsNotifierHash() =>
    r'e5e0db2c893e61b2dd6875672714a71dd7b3f3a8';

/// See also [TransactionsNotifier].
@ProviderFor(TransactionsNotifier)
final transactionsNotifierProvider = AutoDisposeAsyncNotifierProvider<
    TransactionsNotifier, List<Transaction>>.internal(
  TransactionsNotifier.new,
  name: r'transactionsNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$transactionsNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$TransactionsNotifier = AutoDisposeAsyncNotifier<List<Transaction>>;
String _$dashboardSummaryNotifierHash() =>
    r'64cea58ecf078caae56e13e20d26aaac366b7b36';

/// See also [DashboardSummaryNotifier].
@ProviderFor(DashboardSummaryNotifier)
final dashboardSummaryNotifierProvider = AutoDisposeAsyncNotifierProvider<
    DashboardSummaryNotifier, Map<String, double>>.internal(
  DashboardSummaryNotifier.new,
  name: r'dashboardSummaryNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$dashboardSummaryNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$DashboardSummaryNotifier
    = AutoDisposeAsyncNotifier<Map<String, double>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
