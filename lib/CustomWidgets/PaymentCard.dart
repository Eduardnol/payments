import 'package:flutter/material.dart';

import '../Model/PaymentItemObject.dart';
import 'FullDialogPayment/FullScreenDialogPayment.dart';

class PaymentCard extends StatelessWidget {
  final PaymentItemObject paymentItemObject;

  const PaymentCard({super.key, required this.paymentItemObject});

  @override
  Widget build(BuildContext context) {
    print("PaymentCard: ${paymentItemObject.title}");
    return GestureDetector(
      onTap: () {
        showItemFromModalBottomSheetDialog(context);
      },
      child: Card(
        color: Theme.of(context).colorScheme.secondaryContainer,
        child: Row(
          children: [
            Expanded(
                child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                    child: Icon(Icons.attach_money)),
                flex: 1),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      paymentItemObject.title,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context)
                                .colorScheme
                                .onSecondaryContainer,
                          ),
                    ),
                    Text(
                      paymentItemObject.date,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.normal,
                            color: Theme.of(context)
                                .colorScheme
                                .onSecondaryContainer,
                          ),
                    ),
                    Text(
                      paymentItemObject.category,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.normal,
                            color: Theme.of(context)
                                .colorScheme
                                .onSecondaryContainer,
                          ),
                    ),
                  ],
                ),
              ),
              flex: 8,
            ),
            Expanded(
              child: Text(
                paymentItemObject.price,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.normal,
                      color: Theme.of(context).colorScheme.onSecondaryContainer,
                    ),
              ),
              flex: 1,
            ),
          ],
        ),
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
