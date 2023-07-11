import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'activity.freezed.dart';
part 'activity.g.dart';

@freezed
class Activity with _$Activity {
  const factory Activity({
    required String activity,
    required double accessibility,
    required String type,
    required double participants,
    required double price,
    String? link,
    String? key,

  }) = _Activity;

  factory Activity.fromJson(Map<String, Object?> json) => _$ActivityFromJson(json);
}