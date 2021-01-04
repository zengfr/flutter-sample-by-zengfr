// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'searchStatus.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchStatus _$SearchStatusFromJson(Map<String, dynamic> json) {
  return SearchStatus()
    ..provice = json['provice'] as String
    ..city = json['city'] as String
    ..loc = json['loc'] as String
    ..type = json['type'] as int
    ..channel = json['channel'] as String;
}

Map<String, dynamic> _$SearchStatusToJson(SearchStatus instance) =>
    <String, dynamic>{
      'provice': instance.provice,
      'city': instance.city,
      'loc': instance.loc,
      'type': instance.type,
      'channel': instance.channel,
    };
