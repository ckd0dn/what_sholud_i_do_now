// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Activity _$$_ActivityFromJson(Map<String, dynamic> json) => _$_Activity(
      activity: json['activity'] as String,
      accessibility: (json['accessibility'] as num).toDouble(),
      type: json['type'] as String,
      participants: (json['participants'] as num).toDouble(),
      price: (json['price'] as num).toDouble(),
      link: json['link'] as String?,
      key: json['key'] as String?,
    );

Map<String, dynamic> _$$_ActivityToJson(_$_Activity instance) =>
    <String, dynamic>{
      'activity': instance.activity,
      'accessibility': instance.accessibility,
      'type': instance.type,
      'participants': instance.participants,
      'price': instance.price,
      'link': instance.link,
      'key': instance.key,
    };
