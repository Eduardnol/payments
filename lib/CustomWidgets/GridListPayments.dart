import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Model/PaymentItemObject.dart';
import 'ModalBottomSheetCustom.dart';

class GridListPayments extends StatelessWidget {
  Future<List<PaymentItemObject>> retrievePayments() async {
    var downloadedData =
        await FirebaseFirestore.instance.collection('payments').get();
    List<PaymentItemObject> paymentItemObjects = [];
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
    return paymentItemObjects;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: retrievePayments(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: CircularProgressIndicator()); // or any loading indicator
        } else if (snapshot.hasError) {
          return Text('Connection ERROR');
        } else {
          List<PaymentItemObject>? paymentItemObjects = snapshot.data;
          return ListView(
            children: [
              for (var paymentItemObject in paymentItemObjects!)
                PaymentCard(paymentItemObject: paymentItemObject),
            ],
          );
        }
      },
    );
  }
}

class PaymentCard extends StatelessWidget {
  final PaymentItemObject paymentItemObject;

  const PaymentCard({super.key, required this.paymentItemObject});

  @override
  Widget build(BuildContext context) {
    print("PaymentCard: ${paymentItemObject.title}");
    return GestureDetector(
      onTap: () {
        showItemFromModalBottomSheetDialog(context);
      },
      child: Container(
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
          )),
    );
  }

  void showItemFromModalBottomSheetDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.secondary,
      builder: (BuildContext context) {
        return ModalBottomSheetCustom(paymentItemObject: paymentItemObject);
      },
    );
  }
}
