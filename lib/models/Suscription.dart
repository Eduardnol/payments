import 'package:json_annotation/json_annotation.dart';

part 'Suscription.g.dart';

@JsonSerializable()
class Suscription {
  //TODO disenar un sistema no repetitivo para gestionar las ID de las suscripciones
  int id;
  var name;
  var description;
  DateTime? date;
  double price;
  int color;
  var logo;

  Suscription(
      {required this.id,
      required this.name,
      this.description,
      this.date,
      required this.price,
      required this.color,
      required this.logo});

  factory Suscription.fromJson(Map<String, dynamic> data) =>
      _$SuscriptionFromJson(data);

  Map<String, dynamic> toJson() => _$SuscriptionToJson(this);
}
