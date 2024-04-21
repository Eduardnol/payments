import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:payments/providers/PaymentProvider.dart';
import 'package:provider/provider.dart';
import '../../Model/PaymentObject.dart';

class PaymentItemView extends StatelessWidget {
  //list of payment components
  final PaymentItemObject paymentItemObject;

  const PaymentItemView({
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
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              borderRadius: BorderRadius.circular(10),
            ),
            child: PaymentRowItem(
                title: "Title",
                paymentItemObject: paymentItemObject,
                icon: Icons.title),
          ),
          Divider(),
          PaymentRowItem(
            title: "Price",
            icon: Icons.attach_money,
            paymentItemObject: paymentItemObject,
          ),
          Divider(),
          PaymentRowItem(
              title: "Date",
              paymentItemObject: paymentItemObject,
              icon: Icons.calendar_today),
          Divider(),
          PaymentRowItem(
              title: "Description",
              paymentItemObject: paymentItemObject,
              icon: Icons.description),
          Divider(),
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
      value = context.watch<PaymentProvider>().paymentItemObject.title;
    } else if (title == "Price") {
      value =
          context.watch<PaymentProvider>().paymentItemObject.price.toString();
    } else if (title == "Description") {
      value = context.watch<PaymentProvider>().paymentItemObject.description;
    } else if (title == "Date") {
      value =
          context.watch<PaymentProvider>().paymentItemObject.date.toString();
    } else if (title == "Id") {
      value =
          context.watch<PaymentProvider>().paymentItemObject.id.id.toString();
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
                      title: title, value: value, isEditable: isEditable),
                  flex: 6),
            ],
          ),
        ),
      ],
    );
  }
}

class ValueName extends StatelessWidget {
  const ValueName({
    super.key,
    required this.title,
    required this.value,
    required this.isEditable,
  });

  final String title;
  final String value;
  final bool isEditable;

  @override
  Widget build(BuildContext context) {
    var maxLines = 1;
    var keyboardType = TextInputType.text;
    var inputFormatters = <TextInputFormatter>[];
    var isDate = false;
    if (title == "Description") {
      maxLines = 5;
    }
    if (title == "Price") {
      keyboardType = TextInputType.number;
      inputFormatters = <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
      ];
    }
    if (title == "Date") {
      isDate = true;
    }
    if (isDate) {
      var myFormat = new DateFormat('dd-MM-yyyy');
      return TextButton(
        onPressed: () {
          processDateModalBottomSheet(context);
        },
        child: Text(
            '${myFormat.format(context.watch<PaymentProvider>().paymentItemObject.date)}'),
      );
    } else {
      return TextButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              final TextEditingController controller =
                  TextEditingController(text: value);
              return Column(
                children: [
                  TextFormField(
                    keyboardType: keyboardType,
                    inputFormatters: inputFormatters,
                    maxLines: maxLines,
                    decoration: InputDecoration(
                      enabled: isEditable,
                      border: OutlineInputBorder(),
                      labelText: title,
                      labelStyle:
                          Theme.of(context).textTheme.bodySmall!.copyWith(
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                    ),
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                    controller: controller,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (title == "Title") {
                        context
                            .read<PaymentProvider>()
                            .setTitle(controller.text);
                      } else if (title == "Price") {
                        context
                            .read<PaymentProvider>()
                            .setPrice(double.parse(controller.text));
                      } else if (title == "Description") {
                        context
                            .read<PaymentProvider>()
                            .setDescription(controller.text);
                      }
                      Navigator.of(context).pop();
                    },
                    child: Text('Save'),
                  ),
                ],
              );
            },
          );
        },
        child: Text(value),
      );
    }
  }

  processDateModalBottomSheet(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      context.watch<PaymentProvider>().paymentItemObject.date = picked;
    }
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
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                )),
      ],
    );
  }
}
