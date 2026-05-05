// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Transaction _$TransactionFromJson(Map<String, dynamic> json) {
  return _Transaction.fromJson(json);
}

/// @nodoc
mixin _$Transaction {
  @HiveField(0)
  String get id => throw _privateConstructorUsedError;
  @HiveField(1)
  double get amount => throw _privateConstructorUsedError;
  @HiveField(2)
  TransactionType get type => throw _privateConstructorUsedError;
  @HiveField(3)
  String get categoryId => throw _privateConstructorUsedError;
  @HiveField(4)
  DateTime get date => throw _privateConstructorUsedError;
  @HiveField(5)
  String? get note => throw _privateConstructorUsedError;
  @HiveField(6)
  String? get receiptPath => throw _privateConstructorUsedError;
  @HiveField(7)
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @HiveField(8)
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  @HiveField(9)
  String? get categoryName => throw _privateConstructorUsedError;
  @HiveField(10)
  int? get categoryColorCode => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TransactionCopyWith<Transaction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionCopyWith<$Res> {
  factory $TransactionCopyWith(
          Transaction value, $Res Function(Transaction) then) =
      _$TransactionCopyWithImpl<$Res, Transaction>;
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) double amount,
      @HiveField(2) TransactionType type,
      @HiveField(3) String categoryId,
      @HiveField(4) DateTime date,
      @HiveField(5) String? note,
      @HiveField(6) String? receiptPath,
      @HiveField(7) DateTime? createdAt,
      @HiveField(8) DateTime? updatedAt,
      @HiveField(9) String? categoryName,
      @HiveField(10) int? categoryColorCode});
}

/// @nodoc
class _$TransactionCopyWithImpl<$Res, $Val extends Transaction>
    implements $TransactionCopyWith<$Res> {
  _$TransactionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? amount = null,
    Object? type = null,
    Object? categoryId = null,
    Object? date = null,
    Object? note = freezed,
    Object? receiptPath = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? categoryName = freezed,
    Object? categoryColorCode = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as TransactionType,
      categoryId: null == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
      receiptPath: freezed == receiptPath
          ? _value.receiptPath
          : receiptPath // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      categoryName: freezed == categoryName
          ? _value.categoryName
          : categoryName // ignore: cast_nullable_to_non_nullable
              as String?,
      categoryColorCode: freezed == categoryColorCode
          ? _value.categoryColorCode
          : categoryColorCode // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TransactionImplCopyWith<$Res>
    implements $TransactionCopyWith<$Res> {
  factory _$$TransactionImplCopyWith(
          _$TransactionImpl value, $Res Function(_$TransactionImpl) then) =
      __$$TransactionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) double amount,
      @HiveField(2) TransactionType type,
      @HiveField(3) String categoryId,
      @HiveField(4) DateTime date,
      @HiveField(5) String? note,
      @HiveField(6) String? receiptPath,
      @HiveField(7) DateTime? createdAt,
      @HiveField(8) DateTime? updatedAt,
      @HiveField(9) String? categoryName,
      @HiveField(10) int? categoryColorCode});
}

/// @nodoc
class __$$TransactionImplCopyWithImpl<$Res>
    extends _$TransactionCopyWithImpl<$Res, _$TransactionImpl>
    implements _$$TransactionImplCopyWith<$Res> {
  __$$TransactionImplCopyWithImpl(
      _$TransactionImpl _value, $Res Function(_$TransactionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? amount = null,
    Object? type = null,
    Object? categoryId = null,
    Object? date = null,
    Object? note = freezed,
    Object? receiptPath = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? categoryName = freezed,
    Object? categoryColorCode = freezed,
  }) {
    return _then(_$TransactionImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as TransactionType,
      categoryId: null == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
      receiptPath: freezed == receiptPath
          ? _value.receiptPath
          : receiptPath // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      categoryName: freezed == categoryName
          ? _value.categoryName
          : categoryName // ignore: cast_nullable_to_non_nullable
              as String?,
      categoryColorCode: freezed == categoryColorCode
          ? _value.categoryColorCode
          : categoryColorCode // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@HiveType(typeId: 0, adapterName: 'TransactionAdapter')
class _$TransactionImpl implements _Transaction {
  const _$TransactionImpl(
      {@HiveField(0) required this.id,
      @HiveField(1) required this.amount,
      @HiveField(2) required this.type,
      @HiveField(3) required this.categoryId,
      @HiveField(4) required this.date,
      @HiveField(5) this.note,
      @HiveField(6) this.receiptPath,
      @HiveField(7) this.createdAt,
      @HiveField(8) this.updatedAt,
      @HiveField(9) this.categoryName,
      @HiveField(10) this.categoryColorCode});

  factory _$TransactionImpl.fromJson(Map<String, dynamic> json) =>
      _$$TransactionImplFromJson(json);

  @override
  @HiveField(0)
  final String id;
  @override
  @HiveField(1)
  final double amount;
  @override
  @HiveField(2)
  final TransactionType type;
  @override
  @HiveField(3)
  final String categoryId;
  @override
  @HiveField(4)
  final DateTime date;
  @override
  @HiveField(5)
  final String? note;
  @override
  @HiveField(6)
  final String? receiptPath;
  @override
  @HiveField(7)
  final DateTime? createdAt;
  @override
  @HiveField(8)
  final DateTime? updatedAt;
  @override
  @HiveField(9)
  final String? categoryName;
  @override
  @HiveField(10)
  final int? categoryColorCode;

  @override
  String toString() {
    return 'Transaction(id: $id, amount: $amount, type: $type, categoryId: $categoryId, date: $date, note: $note, receiptPath: $receiptPath, createdAt: $createdAt, updatedAt: $updatedAt, categoryName: $categoryName, categoryColorCode: $categoryColorCode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransactionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.note, note) || other.note == note) &&
            (identical(other.receiptPath, receiptPath) ||
                other.receiptPath == receiptPath) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.categoryName, categoryName) ||
                other.categoryName == categoryName) &&
            (identical(other.categoryColorCode, categoryColorCode) ||
                other.categoryColorCode == categoryColorCode));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      amount,
      type,
      categoryId,
      date,
      note,
      receiptPath,
      createdAt,
      updatedAt,
      categoryName,
      categoryColorCode);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TransactionImplCopyWith<_$TransactionImpl> get copyWith =>
      __$$TransactionImplCopyWithImpl<_$TransactionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TransactionImplToJson(
      this,
    );
  }
}

abstract class _Transaction implements Transaction {
  const factory _Transaction(
      {@HiveField(0) required final String id,
      @HiveField(1) required final double amount,
      @HiveField(2) required final TransactionType type,
      @HiveField(3) required final String categoryId,
      @HiveField(4) required final DateTime date,
      @HiveField(5) final String? note,
      @HiveField(6) final String? receiptPath,
      @HiveField(7) final DateTime? createdAt,
      @HiveField(8) final DateTime? updatedAt,
      @HiveField(9) final String? categoryName,
      @HiveField(10) final int? categoryColorCode}) = _$TransactionImpl;

  factory _Transaction.fromJson(Map<String, dynamic> json) =
      _$TransactionImpl.fromJson;

  @override
  @HiveField(0)
  String get id;
  @override
  @HiveField(1)
  double get amount;
  @override
  @HiveField(2)
  TransactionType get type;
  @override
  @HiveField(3)
  String get categoryId;
  @override
  @HiveField(4)
  DateTime get date;
  @override
  @HiveField(5)
  String? get note;
  @override
  @HiveField(6)
  String? get receiptPath;
  @override
  @HiveField(7)
  DateTime? get createdAt;
  @override
  @HiveField(8)
  DateTime? get updatedAt;
  @override
  @HiveField(9)
  String? get categoryName;
  @override
  @HiveField(10)
  int? get categoryColorCode;
  @override
  @JsonKey(ignore: true)
  _$$TransactionImplCopyWith<_$TransactionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
