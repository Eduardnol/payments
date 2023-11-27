import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Model/PaymentItemObject.dart';
import 'PaymentCard.dart';

class GridListPayments extends StatelessWidget {
  Future<List<PaymentItemObject>> retrievePayments() async {
    var downloadedData =
        await FirebaseFirestore.instance.collection('payments').get();
    List<PaymentItemObject> paymentItemObjects = [];
    downloadedData.docs.forEach((element) {
      paymentItemObjects.add(PaymentItemObject(
        id: element.reference,
        title: element.data()['title'],
        price: element.data()['price'],
        description: element.data()['description'],
        date: element.data()['date'],
        category: element.data()['category'],
        createdOn: DateTime.parse(element.data()['createdOn']),
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
          return SliverToBoxAdapter(
            child: Center(child: CircularProgressIndicator()),
          ); // or any loading indicator
        } else if (snapshot.hasError) {
          print(snapshot.error);
          return SliverToBoxAdapter(child: Text('Connection ERROR'));
        } else {
          List<PaymentItemObject>? paymentItemObjects = snapshot.data;
          return SliverList(
            delegate: SliverChildListDelegate([
              for (var paymentItemObject in paymentItemObjects!)
                PaymentCard(paymentItemObject: paymentItemObject),
            ]),
          );
        }
      },
    );
  }
}
