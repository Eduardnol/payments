import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Model/PaymentItemObject.dart';

class GridListPayments extends StatelessWidget {
  void retrievePayments(List<PaymentItemObject> paymentItemObjects) async {
    var downloadedData =
        await FirebaseFirestore.instance.collection('payments').get();
    downloadedData.docs.forEach((element) {
      paymentItemObjects.add(PaymentItemObject(
        title: element.data()['title'],
        price: element.data()['price'],
        description: element.data()['description'],
        date: element.data()['date'],
        category: element.data()['category'],
      ));
    });
    print("Elements saved: ${paymentItemObjects.length}");
  }

  @override
  Widget build(BuildContext context) {
    List<PaymentItemObject> paymentItemObjects = [];
    retrievePayments(paymentItemObjects);
    print("GridListPayments: ${paymentItemObjects.length}");
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
    print("PaymentCard: ${paymentItemObject.title}");
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
