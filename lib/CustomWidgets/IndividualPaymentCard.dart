import 'package:flutter/material.dart';

import '../Model/PaymentObject.dart';
import 'FullScreenDialogPayment/FullScreenDialogPayment.dart';

class PaymentCard extends StatelessWidget {
  final PaymentItemObject paymentItemObject;

  const PaymentCard({super.key, required this.paymentItemObject});

  @override
  Widget build(BuildContext context) {
    print("PaymentCard: ${paymentItemObject.title}");
    return Card(
      color: Theme.of(context).colorScheme.secondaryContainer,
      child: ListTile(
        onTap: () {
          showItemFromModalBottomSheetDialog(context);
        },
        title: Text(
          paymentItemObject.title,
          style: TextStyle(
              color: Theme.of(context).colorScheme.onSecondaryContainer),
        ),
        subtitle: Text(
          paymentItemObject.date,
          style: TextStyle(
              color: Theme.of(context).colorScheme.onSecondaryContainer),
        ),
        leading: CircleAvatar(
          child: Icon(Icons.attach_money),
        ),
        trailing: Text(paymentItemObject.price,
            style: TextStyle(
                color: Theme.of(context).colorScheme.onSecondaryContainer)),
      ),
    );
  }

  void showItemFromModalBottomSheetDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            child: ModalBottomSheetCustom(paymentItemObject: paymentItemObject),
          ),
        );
      },
    );
  }
}
