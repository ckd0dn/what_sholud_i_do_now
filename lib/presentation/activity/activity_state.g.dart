// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ActivityState _$$_ActivityStateFromJson(Map<String, dynamic> json) =>
    _$_ActivityState(
      activity: json['activity'] == null
          ? const Activity(
              activity: '',
              accessibility: 0,
              type: '',
              participants: 0,
              price: 0,
              link: '',
              key: '')
          : Activity.fromJson(json['activity'] as Map<String, dynamic>),
      isLoading: json['isLoading'] as bool? ?? false,
      isActivity: json['isActivity'] as bool? ?? false,
    );

Map<String, dynamic> _$$_ActivityStateToJson(_$_ActivityState instance) =>
    <String, dynamic>{
      'activity': instance.activity,
      'isLoading': instance.isLoading,
      'isActivity': instance.isActivity,
    };
