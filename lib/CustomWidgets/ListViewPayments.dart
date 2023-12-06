import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Model/PaymentObject.dart';
import '../services/ProviderWidget.dart';
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
    final uid = await Provider.of(context).auth.getCurrentUID();
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
          price: element.data()['price'],
          description: element.data()['description'],
          date: element.data()['date'],
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
            ? const SliverToBoxAdapter(
                child: Center(child: CircularProgressIndicator()))
            : SliverList(
                delegate: SliverChildListDelegate([
                  for (var paymentItemObject in paymentItemObjects)
                    PaymentCard(paymentItemObject: paymentItemObject),
                ]),
              );
  }
}
