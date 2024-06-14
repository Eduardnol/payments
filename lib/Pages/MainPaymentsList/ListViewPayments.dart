import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:payments/services/AuthService.dart';
import 'package:provider/provider.dart';

import '../../Model/PaymentObject.dart';
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

  retrievePayments() async {
    try {
      final uid = await context.read<AuthService>().getCurrentUID();
      //TODO get only payments of current user
      var data = FirebaseFirestore.instance
          .collection('userData')
          .doc(uid)
          .collection('payments')
          .get();

      data.then((QuerySnapshot elements) {
        _isLoadingData = false;
        paymentItemObjects.clear();
        elements.docs.forEach((element) {
          paymentItemObjects.add(PaymentItemObject.fromFirestore(element));
        });

        paymentItemObjects.sort(
            (a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()));

        setState(() {});
      });
    } catch (e) {
      print('Error retrieving payments: $e');
    }
  }
}
