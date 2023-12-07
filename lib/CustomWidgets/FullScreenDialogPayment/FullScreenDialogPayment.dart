import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../Model/PaymentObject.dart';
import '../../services/ProviderWidget.dart';
import 'PaymentItemView.dart';

class ModalBottomSheetCustom extends StatelessWidget {
  final PaymentItemObject paymentItemObject;
  const ModalBottomSheetCustom({super.key, required this.paymentItemObject});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
        elevation: 0,
        title: Text("Payment Details"),
        actions: [
          TextButton.icon(
            onPressed: () {
              savePayment(context);
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.save),
            label: Text("Save"),
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
      body: SingleChildScrollView(
          child: PaymentItem(paymentItemObject: paymentItemObject)),
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

  savePayment(BuildContext context) async {
    final uid = await Provider.of(context).auth.getCurrentUID();
    Future<void> savedPayment = FirebaseFirestore.instance
        .collection('userData')
        .doc(uid)
        .collection('payments')
        .doc(paymentItemObject.id.id)
        .set(({
          'title': paymentItemObject.title,
          'price': paymentItemObject.price,
          'description': paymentItemObject.description,
          'date': paymentItemObject.date,
          'category': paymentItemObject.category,
          'createdOn': paymentItemObject.createdOn.toString(),
        }));

    savedPayment.onError((error, stackTrace) => print(error));
    savedPayment.whenComplete(() => ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Payment Updated!"))));
  }

  deletePayment(BuildContext context) async {
    final uid = await Provider.of(context).auth.getCurrentUID();
    FirebaseFirestore.instance
        .collection('userData')
        .doc(uid)
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
              deletePayment(context);
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
