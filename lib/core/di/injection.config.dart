// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:hive_flutter/hive_flutter.dart' as _i986;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/budgets/data/datasources/budget_local_data_source.dart'
    as _i155;
import '../../features/budgets/data/repositories/budget_repository_impl.dart'
    as _i654;
import '../../features/budgets/domain/models/budget.dart' as _i998;
import '../../features/budgets/domain/models/goal.dart' as _i490;
import '../../features/budgets/domain/repositories/budget_repository.dart'
    as _i1021;
import '../../features/transactions/data/datasources/transaction_local_data_source.dart'
    as _i371;
import '../../features/transactions/data/repositories/transaction_repository_impl.dart'
    as _i443;
import '../../features/transactions/domain/models/category.dart' as _i657;
import '../../features/transactions/domain/models/transaction.dart' as _i1069;
import '../../features/transactions/domain/repositories/transaction_repository.dart'
    as _i421;
import '../../features/transactions/domain/usecases/add_transaction.dart'
    as _i5;
import '../../features/transactions/domain/usecases/delete_transaction.dart'
    as _i645;
import '../../features/transactions/domain/usecases/get_monthly_summary.dart'
    as _i301;
import '../../features/transactions/domain/usecases/get_transactions.dart'
    as _i439;
import '../../features/transactions/domain/usecases/update_transaction.dart'
    as _i373;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i371.TransactionLocalDataSource>(
        () => _i371.TransactionLocalDataSourceImpl(
              gh<_i986.Box<_i1069.Transaction>>(),
              gh<_i986.Box<_i657.Category>>(),
            ));
    gh.lazySingleton<_i155.BudgetLocalDataSource>(
        () => _i155.BudgetLocalDataSourceImpl(
              gh<_i986.Box<_i998.Budget>>(),
              gh<_i986.Box<_i490.Goal>>(),
            ));
    gh.lazySingleton<_i1021.BudgetRepository>(
        () => _i654.BudgetRepositoryImpl(gh<_i155.BudgetLocalDataSource>()));
    gh.lazySingleton<_i421.TransactionRepository>(() =>
        _i443.TransactionRepositoryImpl(
            gh<_i371.TransactionLocalDataSource>()));
    gh.factory<_i5.AddTransactionUseCase>(
        () => _i5.AddTransactionUseCase(gh<_i421.TransactionRepository>()));
    gh.factory<_i645.DeleteTransactionUseCase>(() =>
        _i645.DeleteTransactionUseCase(gh<_i421.TransactionRepository>()));
    gh.factory<_i301.GetMonthlySummaryUseCase>(() =>
        _i301.GetMonthlySummaryUseCase(gh<_i421.TransactionRepository>()));
    gh.factory<_i439.GetTransactionsUseCase>(
        () => _i439.GetTransactionsUseCase(gh<_i421.TransactionRepository>()));
    gh.factory<_i373.UpdateTransactionUseCase>(() =>
        _i373.UpdateTransactionUseCase(gh<_i421.TransactionRepository>()));
    return this;
  }
}
