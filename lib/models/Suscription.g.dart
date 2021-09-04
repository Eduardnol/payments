// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Suscription.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Suscription _$SuscriptionFromJson(Map<String, dynamic> json) {
  return Suscription(
    id: json['id'] as int,
    name: json['name'],
    description: json['description'],
    date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
    price: (json['price'] as num).toDouble(),
    color: json['color'] as int,
    logo: IconData(json['logo'] as int),
  );
}

Map<String, dynamic> _$SuscriptionToJson(Suscription instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'date': instance.date?.toIso8601String(),
      'price': instance.price,
      'color': instance.color,
      'logo': instance.logo!.codePoint.toInt(),
    };
