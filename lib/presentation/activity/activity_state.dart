import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:what_sholud_i_do_now/domain/model/activity.dart';

part 'activity_state.freezed.dart';
part 'activity_state.g.dart';

@freezed
class ActivityState with _$ActivityState {
  const factory ActivityState({
    @Default(Activity(activity: '', accessibility: 0, type: '', participants: 0, price: 0, link: '', key: '')) Activity activity,
    @Default(false) bool isLoading,
    @Default(false) bool isActivity,

  }) = _ActivityState;

  factory ActivityState.fromJson(Map<String, Object?> json) => _$ActivityStateFromJson(json);
}