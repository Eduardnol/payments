import 'package:flutter/material.dart';

import '../Model/PaymentItemObject.dart';
import 'PaymentItem.dart';

class GridListPayments extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        PaymentCard(),
        PaymentCard(),
        PaymentCard(),
        PaymentCard(),
      ],
    );
  }
}

class PaymentCard extends StatelessWidget {
  final PaymentItemObject paymentItemObject = PaymentItemObject(
      title: "Hello World",
      price: "100",
      description: "Sample Description",
      date: "Today",
      category: "Category Group");
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 200,
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
                flex: 8,
              ),
              Expanded(
                child: Text(paymentItemObject.price),
                flex: 1,
              ),
            ],
          ),
        ));
  }
}
