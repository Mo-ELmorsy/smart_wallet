// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transactions_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$transactionsNotifierHash() =>
    r'9d99b3d02842a31c07b05be62e377a9ca79ad16a';

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
    r'740e67e046c07ebb10153b137ff62a25170e1168';

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
