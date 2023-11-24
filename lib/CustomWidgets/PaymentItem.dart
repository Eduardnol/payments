import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PaymentItem extends StatelessWidget {
  //list of payment components
  final String title;
  final String price;
  final String description;
  final String date;
  final String category;

  const PaymentItem({
    super.key,
    required this.title,
    required this.price,
    required this.description,
    required this.date,
    required this.category,
  });
  savePayment() {
    FirebaseFirestore.instance.collection('payments').add({
      'title': title,
      'price': price,
      'description': description,
      'date': date,
      'category': category,
    });
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
                    title: "Title", value: this.title, icon: Icons.title),
                PaymentRowItem(
                    title: "Price",
                    value: this.price,
                    icon: Icons.attach_money),
                PaymentRowItem(
                    title: "Description",
                    value: this.description,
                    icon: Icons.description),
                PaymentRowItem(
                    title: "Date",
                    value: this.date,
                    icon: Icons.calendar_today),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PaymentRowItem extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  PaymentRowItem({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  child: Row(
                    children: [
                      Icon(
                        icon,
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                      Text(title,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                color:
                                    Theme.of(context).colorScheme.onSecondary,
                                fontWeight: FontWeight.bold,
                              )),
                    ],
                  ),
                  flex: 8),
              Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: title,
                      labelStyle: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                    ),
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                    controller: TextEditingController(text: value),
                  ),
                  flex: 2),
            ],
          ),
        ),
        Divider(),
      ],
    );
  }
}
