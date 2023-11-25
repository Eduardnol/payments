import 'package:flutter/material.dart';

import '../../Model/PaymentItemObject.dart';
import 'PaymentItem.dart';

class ModalBottomSheetCustom extends StatelessWidget {
  final PaymentItemObject paymentItemObject;

  const ModalBottomSheetCustom({super.key, required this.paymentItemObject});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: PaymentItem(paymentItemObject: paymentItemObject),
    );
  }
}
