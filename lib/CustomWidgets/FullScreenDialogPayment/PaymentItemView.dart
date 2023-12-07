import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../Model/PaymentObject.dart';

class PaymentItem extends StatelessWidget {
  //list of payment components
  final PaymentItemObject paymentItemObject;

  const PaymentItem({
    super.key,
    required this.paymentItemObject,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 9,
            child: Column(
              children: [
                PaymentRowItem(
                    title: "Id",
                    paymentItemObject: paymentItemObject,
                    icon: Icons.key),
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
                    title: "Date",
                    paymentItemObject: paymentItemObject,
                    icon: Icons.calendar_today),
                PaymentRowItem(
                    title: "Description",
                    paymentItemObject: paymentItemObject,
                    icon: Icons.description),
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
    var isEditable = true;
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
      isEditable = false;
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  child: TagName(
                    title: title,
                    icon: icon,
                  ),
                  flex: 4),
              Expanded(
                  child: ValueName(
                      title: title,
                      paymentItemObject: paymentItemObject,
                      value: value,
                      isEditable: isEditable),
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
    required this.isEditable,
  });

  final String title;
  final PaymentItemObject paymentItemObject;
  final String value;
  final bool isEditable;

  @override
  Widget build(BuildContext context) {
    var maxLines = 1;
    var keyboardType = TextInputType.text;
    var inputFormatters = <TextInputFormatter>[];
    if (title == "Description") {
      maxLines = 5;
    }
    if (title == "Price") {
      keyboardType = TextInputType.number;
      inputFormatters = <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
      ];
    }
    return TextFormField(
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
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      maxLines: maxLines,
      decoration: InputDecoration(
        enabled: isEditable,
        border: OutlineInputBorder(),
        labelText: title,
        labelStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
      ),
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
      controller: TextEditingController(text: value),
    );
  }
}

class TagName extends StatelessWidget {
  const TagName({
    super.key,
    required this.title,
    required this.icon,
  });

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: Theme.of(context).colorScheme.onSurface,
        ),
        Text(title,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                )),
      ],
    );
  }
}
