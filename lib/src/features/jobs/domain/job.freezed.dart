// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'job.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Job _$JobFromJson(Map<String, dynamic> json) {
  return _Job.fromJson(json);
}

/// @nodoc
mixin _$Job {
  String get name => throw _privateConstructorUsedError;
  int get ratePerHour => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $JobCopyWith<Job> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JobCopyWith<$Res> {
  factory $JobCopyWith(Job value, $Res Function(Job) then) =
      _$JobCopyWithImpl<$Res, Job>;
  @useResult
  $Res call({String name, int ratePerHour});
}

/// @nodoc
class _$JobCopyWithImpl<$Res, $Val extends Job> implements $JobCopyWith<$Res> {
  _$JobCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? ratePerHour = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      ratePerHour: null == ratePerHour
          ? _value.ratePerHour
          : ratePerHour // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_JobCopyWith<$Res> implements $JobCopyWith<$Res> {
  factory _$$_JobCopyWith(_$_Job value, $Res Function(_$_Job) then) =
      __$$_JobCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, int ratePerHour});
}

/// @nodoc
class __$$_JobCopyWithImpl<$Res> extends _$JobCopyWithImpl<$Res, _$_Job>
    implements _$$_JobCopyWith<$Res> {
  __$$_JobCopyWithImpl(_$_Job _value, $Res Function(_$_Job) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? ratePerHour = null,
  }) {
    return _then(_$_Job(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      ratePerHour: null == ratePerHour
          ? _value.ratePerHour
          : ratePerHour // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Job with DiagnosticableTreeMixin implements _Job {
  const _$_Job({required this.name, required this.ratePerHour});

  factory _$_Job.fromJson(Map<String, dynamic> json) => _$$_JobFromJson(json);

  @override
  final String name;
  @override
  final int ratePerHour;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Job(name: $name, ratePerHour: $ratePerHour)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Job'))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('ratePerHour', ratePerHour));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Job &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.ratePerHour, ratePerHour) ||
                other.ratePerHour == ratePerHour));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, ratePerHour);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_JobCopyWith<_$_Job> get copyWith =>
      __$$_JobCopyWithImpl<_$_Job>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_JobToJson(
      this,
    );
  }
}

abstract class _Job implements Job {
  const factory _Job(
      {required final String name, required final int ratePerHour}) = _$_Job;

  factory _Job.fromJson(Map<String, dynamic> json) = _$_Job.fromJson;

  @override
  String get name;
  @override
  int get ratePerHour;
  @override
  @JsonKey(ignore: true)
  _$$_JobCopyWith<_$_Job> get copyWith => throw _privateConstructorUsedError;
}
