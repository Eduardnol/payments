// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Session _$SessionFromJson(Map<String, dynamic> json) {
  return Session(
    (json['suscriptionList'] as List<dynamic>?)
        ?.map((e) => Suscription.fromJson(e as Map<String, dynamic>))
        .toList(),
  )..editingIndex = json['editingIndex'] as int?;
}

Map<String, dynamic> _$SessionToJson(Session instance) => <String, dynamic>{
      'suscriptionList':
          instance.suscriptionList?.map((e) => e.toJson()).toList(),
      'editingIndex': instance.editingIndex,
    };
