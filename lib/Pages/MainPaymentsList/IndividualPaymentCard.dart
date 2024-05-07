import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../Model/PaymentObject.dart';
import '../../providers/PaymentProvider.dart';
import '../ModalViewPaymentInfo/ModalBottomSheetPayment.dart';

class IndividualPaymentCard extends StatelessWidget {
  final PaymentItemObject paymentItemObject;

  const IndividualPaymentCard({super.key, required this.paymentItemObject});

  @override
  Widget build(BuildContext context) {
    var myFormat = new DateFormat('dd-MM-yyyy');
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
          '${myFormat.format(paymentItemObject.date)}',
          style: TextStyle(
              color: Theme.of(context).colorScheme.onSecondaryContainer),
        ),
        leading: CircleAvatar(
          child: Icon(Icons.attach_money),
        ),
        trailing: Text(paymentItemObject.price.toString(),
            style: TextStyle(
                color: Theme.of(context).colorScheme.onSecondaryContainer)),
      ),
    );
  }

  void showItemFromModalBottomSheetDialog(BuildContext context) {
    context.read<PaymentProvider>().paymentItemObject = paymentItemObject;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            child:
                ModalBottomSheetPayment(paymentItemObject: paymentItemObject),
          ),
        );
      },
    );
  }
}
