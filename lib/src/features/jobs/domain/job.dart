import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'job.freezed.dart';
part 'job.g.dart';

typedef ID = String;

@freezed
class Job with _$Job {
  const factory Job({
    required ID id,
    required String name,
    required int ratePerHour,
  }) = _Job;

  factory Job.fromJson(Map<String, dynamic> json) => _$JobFromJson(json);
}
