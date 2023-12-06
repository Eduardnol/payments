import 'package:cloud_firestore/cloud_firestore.dart';

class PaymentItemObject {
  String title;
  String price;
  String description;
  String date;
  String category;
  DocumentReference id;
  DateTime createdOn;

  PaymentItemObject({
    required this.title,
    required this.price,
    required this.description,
    required this.date,
    required this.category,
    required this.id,
    required this.createdOn,
  });
}
