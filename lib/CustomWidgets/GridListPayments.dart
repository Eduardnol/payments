import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Model/PaymentItemObject.dart';

class GridListPayments extends StatelessWidget {
  List<PaymentItemObject> retrievePayments() {
    List<PaymentItemObject> paymentItemObjects = [
      PaymentItemObject(
        title: 'Payment 31',
        price: '100.00',
        description: 'This is a description for payment 1',
        date: '2023-11-25',
        category: 'Electronics',
      ),
    ];

    FirebaseFirestore.instance.collection('payments').get().then(
      (value) {
        print("Retrieved: " + "${value.docs.length}");
        value.docs.forEach((element) {
          paymentItemObjects.add(PaymentItemObject(
            title: element.data()['title'],
            price: element.data()['price'],
            description: element.data()['description'],
            date: element.data()['date'],
            category: element.data()['category'],
          ));
        });
      },
      onError: (e) => print("Error completing: $e"),
    );
    return paymentItemObjects;
  }

  @override
  Widget build(BuildContext context) {
    List<PaymentItemObject> paymentItemObjects = retrievePayments();
    return ListView(
      children: [
        for (var paymentItemObject in paymentItemObjects)
          PaymentCard(paymentItemObject: paymentItemObject),
      ],
    );
  }
}

class PaymentCard extends StatelessWidget {
  final PaymentItemObject paymentItemObject;

  const PaymentCard({super.key, required this.paymentItemObject});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 100,
        child: Card(
          child: Row(
            children: [
              Expanded(
                  child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                      child: Icon(Icons.attach_money)),
                  flex: 1),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(paymentItemObject.title,
                          style: Theme.of(context).textTheme.titleLarge!),
                      Text(paymentItemObject.date),
                      Text(paymentItemObject.category),
                    ],
                  ),
                ),
                flex: 8,
              ),
              Expanded(
                child: Text(paymentItemObject.price),
                flex: 1,
              ),
            ],
          ),
        ));
  }
}
