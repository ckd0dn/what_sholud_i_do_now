// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'activity_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ActivityState _$ActivityStateFromJson(Map<String, dynamic> json) {
  return _ActivityState.fromJson(json);
}

/// @nodoc
mixin _$ActivityState {
  Activity get activity => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isActivity => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ActivityStateCopyWith<ActivityState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ActivityStateCopyWith<$Res> {
  factory $ActivityStateCopyWith(
          ActivityState value, $Res Function(ActivityState) then) =
      _$ActivityStateCopyWithImpl<$Res, ActivityState>;
  @useResult
  $Res call({Activity activity, bool isLoading, bool isActivity});

  $ActivityCopyWith<$Res> get activity;
}

/// @nodoc
class _$ActivityStateCopyWithImpl<$Res, $Val extends ActivityState>
    implements $ActivityStateCopyWith<$Res> {
  _$ActivityStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? activity = null,
    Object? isLoading = null,
    Object? isActivity = null,
  }) {
    return _then(_value.copyWith(
      activity: null == activity
          ? _value.activity
          : activity // ignore: cast_nullable_to_non_nullable
              as Activity,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isActivity: null == isActivity
          ? _value.isActivity
          : isActivity // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ActivityCopyWith<$Res> get activity {
    return $ActivityCopyWith<$Res>(_value.activity, (value) {
      return _then(_value.copyWith(activity: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_ActivityStateCopyWith<$Res>
    implements $ActivityStateCopyWith<$Res> {
  factory _$$_ActivityStateCopyWith(
          _$_ActivityState value, $Res Function(_$_ActivityState) then) =
      __$$_ActivityStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Activity activity, bool isLoading, bool isActivity});

  @override
  $ActivityCopyWith<$Res> get activity;
}

/// @nodoc
class __$$_ActivityStateCopyWithImpl<$Res>
    extends _$ActivityStateCopyWithImpl<$Res, _$_ActivityState>
    implements _$$_ActivityStateCopyWith<$Res> {
  __$$_ActivityStateCopyWithImpl(
      _$_ActivityState _value, $Res Function(_$_ActivityState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? activity = null,
    Object? isLoading = null,
    Object? isActivity = null,
  }) {
    return _then(_$_ActivityState(
      activity: null == activity
          ? _value.activity
          : activity // ignore: cast_nullable_to_non_nullable
              as Activity,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isActivity: null == isActivity
          ? _value.isActivity
          : isActivity // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ActivityState implements _ActivityState {
  const _$_ActivityState(
      {this.activity = const Activity(
          activity: '',
          accessibility: 0,
          type: '',
          participants: 0,
          price: 0,
          link: '',
          key: ''),
      this.isLoading = false,
      this.isActivity = false});

  factory _$_ActivityState.fromJson(Map<String, dynamic> json) =>
      _$$_ActivityStateFromJson(json);

  @override
  @JsonKey()
  final Activity activity;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isActivity;

  @override
  String toString() {
    return 'ActivityState(activity: $activity, isLoading: $isLoading, isActivity: $isActivity)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ActivityState &&
            (identical(other.activity, activity) ||
                other.activity == activity) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isActivity, isActivity) ||
                other.isActivity == isActivity));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, activity, isLoading, isActivity);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ActivityStateCopyWith<_$_ActivityState> get copyWith =>
      __$$_ActivityStateCopyWithImpl<_$_ActivityState>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ActivityStateToJson(
      this,
    );
  }
}

abstract class _ActivityState implements ActivityState {
  const factory _ActivityState(
      {final Activity activity,
      final bool isLoading,
      final bool isActivity}) = _$_ActivityState;

  factory _ActivityState.fromJson(Map<String, dynamic> json) =
      _$_ActivityState.fromJson;

  @override
  Activity get activity;
  @override
  bool get isLoading;
  @override
  bool get isActivity;
  @override
  @JsonKey(ignore: true)
  _$$_ActivityStateCopyWith<_$_ActivityState> get copyWith =>
      throw _privateConstructorUsedError;
}
