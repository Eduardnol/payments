import 'package:json_annotation/json_annotation.dart';

part 'Suscription.g.dart';

@JsonSerializable()
class Suscription {
  //TODO disenar un sistema no repetitivo para gestionar las ID de las suscripciones
  int id;
  var name;
  var description;
  DateTime? date;
  var price;
  int color;
  var logo;

  Suscription(
      {required this.id,
      this.name,
      this.description,
      this.date,
      this.price,
      required this.color,
      this.logo});

  factory Suscription.fromJson(Map<String, dynamic> data) =>
      _$SuscriptionFromJson(data);

  Map<String, dynamic> toJson() => _$SuscriptionToJson(this);
}
