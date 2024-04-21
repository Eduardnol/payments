import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:payments/services/AuthService.dart';
import 'package:provider/provider.dart';

import '../Model/PaymentObject.dart';
import 'IndividualPaymentCard.dart';

class GridListPayments extends StatefulWidget {
  @override
  State<GridListPayments> createState() => _GridListPaymentsState();
}

class _GridListPaymentsState extends State<GridListPayments> {
  List<PaymentItemObject> paymentItemObjects = [];
  bool _isLoadingData = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    retrievePayments();
  }

  retrievePayments() async {
    final uid = await context.read<AuthService>().getCurrentUID();
    //TODO get only payments of current user
    FirebaseFirestore.instance
        .collection('userData')
        .doc(uid)
        .collection('payments')
        .snapshots()
        .listen((event) {
      _isLoadingData = false;

      paymentItemObjects.clear();
      event.docs.forEach((element) {
        paymentItemObjects.add(PaymentItemObject(
          id: element.reference,
          title: element.data()['title'],
          price: double.parse(element.data()['price']),
          description: element.data()['description'],
          date: element.data()['date'].toDate(),
          category: element.data()['category'],
          createdOn: DateTime.parse(element.data()['createdOn']),
        ));
      });

      paymentItemObjects.sort(
          (a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()));

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoadingData
        ? SliverToBoxAdapter(
            child: const Center(child: CircularProgressIndicator()))
        : paymentItemObjects.isEmpty
            ? SliverToBoxAdapter(
                child: Center(
                child: Text("No payments added yet!",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface)),
              ))
            : SliverList(
                delegate: SliverChildListDelegate([
                  for (var paymentItemObject in paymentItemObjects)
                    IndividualPaymentCard(paymentItemObject: paymentItemObject),
                ]),
              );
  }
}
