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
        backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
        elevation: 0,
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
          leading: IconButton(
            onPressed: () {
              askForDiscardConfirmation(context);
            },
            icon: Icon(Icons.close),
          ),
        ),
      backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
      body: PaymentItem(paymentItemObject: paymentItemObject),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: Theme.of(context).colorScheme.surfaceVariant,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.errorContainer,
          ),
          onPressed: () {
            askForDeleteConfirmation(context);
          },
          child: Text(
            "Delete",
            style: TextStyle(
                color: Theme.of(context).colorScheme.onErrorContainer),
          ),
        ),
      ),
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

  deletePayment() {
    FirebaseFirestore.instance
        .collection('payments')
        .doc(paymentItemObject.id.id)
        .delete();
  }

  askForDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Text("Delete payment?",
            style: TextStyle(color: Theme.of(context).colorScheme.onSurface)),
        content: Text("Are you sure you want to delete this payment?",
            style: TextStyle(color: Theme.of(context).colorScheme.onSurface)),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              "Cancel",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimaryContainer),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              deletePayment();
              Navigator.of(context).pop();
            },
            child: Text(
              "Delete",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimaryContainer),
            ),
          ),
        ],
      ),
    );
  }

  askForDiscardConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Text(
          "Discard changes?",
          style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
        ),
        content: Text(
          "Are you sure you want to discard changes?",
          style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              "Cancel",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimaryContainer),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: Text(
              "Discard",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimaryContainer),
            ),
          ),
        ],
      ),
    );
  }
}
