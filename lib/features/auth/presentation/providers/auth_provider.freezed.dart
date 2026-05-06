// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AuthState {
  bool get isLoading => throw _privateConstructorUsedError;
  bool get hasCompletedOnboarding => throw _privateConstructorUsedError;
  bool get isPinEnabled => throw _privateConstructorUsedError;
  bool get isBiometricEnabled => throw _privateConstructorUsedError;
  bool get canUseBiometrics => throw _privateConstructorUsedError;
  bool get isAuthenticated => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AuthStateCopyWith<AuthState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthStateCopyWith<$Res> {
  factory $AuthStateCopyWith(AuthState value, $Res Function(AuthState) then) =
      _$AuthStateCopyWithImpl<$Res, AuthState>;
  @useResult
  $Res call(
      {bool isLoading,
      bool hasCompletedOnboarding,
      bool isPinEnabled,
      bool isBiometricEnabled,
      bool canUseBiometrics,
      bool isAuthenticated,
      String? errorMessage});
}

/// @nodoc
class _$AuthStateCopyWithImpl<$Res, $Val extends AuthState>
    implements $AuthStateCopyWith<$Res> {
  _$AuthStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? hasCompletedOnboarding = null,
    Object? isPinEnabled = null,
    Object? isBiometricEnabled = null,
    Object? canUseBiometrics = null,
    Object? isAuthenticated = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      hasCompletedOnboarding: null == hasCompletedOnboarding
          ? _value.hasCompletedOnboarding
          : hasCompletedOnboarding // ignore: cast_nullable_to_non_nullable
              as bool,
      isPinEnabled: null == isPinEnabled
          ? _value.isPinEnabled
          : isPinEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      isBiometricEnabled: null == isBiometricEnabled
          ? _value.isBiometricEnabled
          : isBiometricEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      canUseBiometrics: null == canUseBiometrics
          ? _value.canUseBiometrics
          : canUseBiometrics // ignore: cast_nullable_to_non_nullable
              as bool,
      isAuthenticated: null == isAuthenticated
          ? _value.isAuthenticated
          : isAuthenticated // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AuthStateImplCopyWith<$Res>
    implements $AuthStateCopyWith<$Res> {
  factory _$$AuthStateImplCopyWith(
          _$AuthStateImpl value, $Res Function(_$AuthStateImpl) then) =
      __$$AuthStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      bool hasCompletedOnboarding,
      bool isPinEnabled,
      bool isBiometricEnabled,
      bool canUseBiometrics,
      bool isAuthenticated,
      String? errorMessage});
}

/// @nodoc
class __$$AuthStateImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$AuthStateImpl>
    implements _$$AuthStateImplCopyWith<$Res> {
  __$$AuthStateImplCopyWithImpl(
      _$AuthStateImpl _value, $Res Function(_$AuthStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? hasCompletedOnboarding = null,
    Object? isPinEnabled = null,
    Object? isBiometricEnabled = null,
    Object? canUseBiometrics = null,
    Object? isAuthenticated = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_$AuthStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      hasCompletedOnboarding: null == hasCompletedOnboarding
          ? _value.hasCompletedOnboarding
          : hasCompletedOnboarding // ignore: cast_nullable_to_non_nullable
              as bool,
      isPinEnabled: null == isPinEnabled
          ? _value.isPinEnabled
          : isPinEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      isBiometricEnabled: null == isBiometricEnabled
          ? _value.isBiometricEnabled
          : isBiometricEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      canUseBiometrics: null == canUseBiometrics
          ? _value.canUseBiometrics
          : canUseBiometrics // ignore: cast_nullable_to_non_nullable
              as bool,
      isAuthenticated: null == isAuthenticated
          ? _value.isAuthenticated
          : isAuthenticated // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$AuthStateImpl implements _AuthState {
  const _$AuthStateImpl(
      {this.isLoading = true,
      this.hasCompletedOnboarding = false,
      this.isPinEnabled = false,
      this.isBiometricEnabled = false,
      this.canUseBiometrics = false,
      this.isAuthenticated = false,
      this.errorMessage});

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool hasCompletedOnboarding;
  @override
  @JsonKey()
  final bool isPinEnabled;
  @override
  @JsonKey()
  final bool isBiometricEnabled;
  @override
  @JsonKey()
  final bool canUseBiometrics;
  @override
  @JsonKey()
  final bool isAuthenticated;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'AuthState(isLoading: $isLoading, hasCompletedOnboarding: $hasCompletedOnboarding, isPinEnabled: $isPinEnabled, isBiometricEnabled: $isBiometricEnabled, canUseBiometrics: $canUseBiometrics, isAuthenticated: $isAuthenticated, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.hasCompletedOnboarding, hasCompletedOnboarding) ||
                other.hasCompletedOnboarding == hasCompletedOnboarding) &&
            (identical(other.isPinEnabled, isPinEnabled) ||
                other.isPinEnabled == isPinEnabled) &&
            (identical(other.isBiometricEnabled, isBiometricEnabled) ||
                other.isBiometricEnabled == isBiometricEnabled) &&
            (identical(other.canUseBiometrics, canUseBiometrics) ||
                other.canUseBiometrics == canUseBiometrics) &&
            (identical(other.isAuthenticated, isAuthenticated) ||
                other.isAuthenticated == isAuthenticated) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isLoading,
      hasCompletedOnboarding,
      isPinEnabled,
      isBiometricEnabled,
      canUseBiometrics,
      isAuthenticated,
      errorMessage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthStateImplCopyWith<_$AuthStateImpl> get copyWith =>
      __$$AuthStateImplCopyWithImpl<_$AuthStateImpl>(this, _$identity);
}

abstract class _AuthState implements AuthState {
  const factory _AuthState(
      {final bool isLoading,
      final bool hasCompletedOnboarding,
      final bool isPinEnabled,
      final bool isBiometricEnabled,
      final bool canUseBiometrics,
      final bool isAuthenticated,
      final String? errorMessage}) = _$AuthStateImpl;

  @override
  bool get isLoading;
  @override
  bool get hasCompletedOnboarding;
  @override
  bool get isPinEnabled;
  @override
  bool get isBiometricEnabled;
  @override
  bool get canUseBiometrics;
  @override
  bool get isAuthenticated;
  @override
  String? get errorMessage;
  @override
  @JsonKey(ignore: true)
  _$$AuthStateImplCopyWith<_$AuthStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
