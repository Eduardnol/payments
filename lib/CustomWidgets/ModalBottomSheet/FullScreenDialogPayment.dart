import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../Model/PaymentItemObject.dart';
import 'PaymentItemView.dart';

class ModalBottomSheetCustom extends StatelessWidget {
  final PaymentItemObject paymentItemObject;

  const ModalBottomSheetCustom({super.key, required this.paymentItemObject});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment Details"),
        actions: [
          IconButton(
            onPressed: () {
              savePayment();
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.save),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.scrim,
      body: PaymentItem(paymentItemObject: paymentItemObject),
    );
  }

  savePayment() {
    FirebaseFirestore.instance
        .collection('payments')
        .doc(paymentItemObject.id.id)
        .update(({
          'title': paymentItemObject.title,
          'price': paymentItemObject.price,
          'description': paymentItemObject.description,
          'date': paymentItemObject.date,
          'category': paymentItemObject.category,
          'createdOn': paymentItemObject.createdOn.toString(),
        }));
  }
}
