import 'package:cloud_firestore/cloud_firestore.dart';

class PaymentItemObject {
  String title;
  double price;
  String description;
  DateTime date;
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

  PaymentItemObject.empty()
      : title = 'Title',
        price = 0.0,
        description = 'Description',
        date = DateTime.now(),
        category = '',
        id = FirebaseFirestore.instance.collection('payments').doc(),
        createdOn = DateTime.now();

  factory PaymentItemObject.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return PaymentItemObject(
      title: data['title'],
      price: (data['price'] as num).toDouble(),
      description: data['description'],
      date: data['date'].toDate(),
      category: data['category'],
      id: doc.reference,
      createdOn: DateTime.parse(data['createdOn']),
    );
  }
}
