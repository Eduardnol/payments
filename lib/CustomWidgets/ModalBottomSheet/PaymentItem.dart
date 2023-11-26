import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../Model/PaymentItemObject.dart';

class PaymentItem extends StatelessWidget {
  //list of payment components
  final PaymentItemObject paymentItemObject;

  const PaymentItem({
    super.key,
    required this.paymentItemObject,
  });
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: Row(
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancel",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).colorScheme.error,
                          )),
                ),
                Spacer(),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    savePayment();
                  },
                  child: Text("Save",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).colorScheme.scrim,
                          )),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 9,
            child: Column(
              children: [
                PaymentRowItem(
                    title: "Title",
                    paymentItemObject: paymentItemObject,
                    icon: Icons.title),
                PaymentRowItem(
                  title: "Price",
                  icon: Icons.attach_money,
                  paymentItemObject: paymentItemObject,
                ),
                PaymentRowItem(
                    title: "Description",
                    paymentItemObject: paymentItemObject,
                    icon: Icons.description),
                PaymentRowItem(
                    title: "Date",
                    paymentItemObject: paymentItemObject,
                    icon: Icons.calendar_today),
                PaymentRowItem(
                    title: "Id",
                    paymentItemObject: paymentItemObject,
                    icon: Icons.category),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PaymentRowItem extends StatelessWidget {
  final PaymentItemObject paymentItemObject;
  final String title;
  final IconData icon;

  PaymentRowItem({
    super.key,
    required this.paymentItemObject,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    var value = "";
    if (title == "Title") {
      value = paymentItemObject.title;
    } else if (title == "Price") {
      value = paymentItemObject.price;
    } else if (title == "Description") {
      value = paymentItemObject.description;
    } else if (title == "Date") {
      value = paymentItemObject.date;
    } else if (title == "Id") {
      value = paymentItemObject.id.id;
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(child: TagName(title: title), flex: 4),
              Expanded(
                  child: ValueName(
                      title: title,
                      paymentItemObject: paymentItemObject,
                      value: value),
                  flex: 6),
            ],
          ),
        ),
        Divider(),
      ],
    );
  }
}

class ValueName extends StatelessWidget {
  const ValueName({
    super.key,
    required this.title,
    required this.paymentItemObject,
    required this.value,
  });

  final String title;
  final PaymentItemObject paymentItemObject;
  final String value;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) {
        if (title == "Title") {
          paymentItemObject.title = value;
        } else if (title == "Price") {
          paymentItemObject.price = value;
        } else if (title == "Description") {
          paymentItemObject.description = value;
        } else if (title == "Date") {
          paymentItemObject.date = value;
        }
      },
      decoration: InputDecoration(
        labelText: title,
        labelStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Theme.of(context).colorScheme.onSecondary,
            ),
      ),
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: Theme.of(context).colorScheme.onSecondary,
          ),
      controller: TextEditingController(text: value),
    );
  }
}

class TagName extends StatelessWidget {
  const TagName({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.title,
          color: Theme.of(context).colorScheme.onSecondary,
        ),
        Text(title,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSecondary,
                  fontWeight: FontWeight.bold,
                )),
      ],
    );
  }
}
