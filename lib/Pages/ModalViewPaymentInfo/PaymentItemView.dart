import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconpicker/Models/IconPack.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
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
          CircleAvatar(
            radius: 50,
            child: IconButton(
              icon: Icon(
                  context.watch<PaymentProvider>().paymentItemObject.icon.icon),
              onPressed: () => {},
            ),
          ),
          Divider(),
          PaymentRowItem(
              title: "Title",
              paymentItemObject: paymentItemObject,
              icon: Icons.title),
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
          PaymentRowItem(
              title: "Icon",
              paymentItemObject: paymentItemObject,
              icon: Icons.emoji_emotions),
          Divider(),
        ],
      ),
    );
  }

  Future<void> _pickIcon(BuildContext context) async {
    IconData? icon = await showIconPicker(
      context,
      iconPackModes: [IconPack.material],
      backgroundColor: Theme.of(context).colorScheme.surface,
      iconColor: Theme.of(context).colorScheme.onSurface,
      iconSize: 40,
      title: Text(
        'Seleccionar un icono',
        style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
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
    } else if (title == "Icon") {
      value = "Cambia el icono del pago";
      isEditable = true;
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
              Spacer(),
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
    var isIcon = false;

    if (title == "Title") {
      inputFormatters = <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9 ]')),
        LengthLimitingTextInputFormatter(25),
      ];
    }
    if (title == "Description") {
      maxLines = 5;
      inputFormatters = <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9 ]')),
        LengthLimitingTextInputFormatter(100),
      ];
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
    if (title == "Icon") {
      isIcon = true;
    }

    if (isDate) {
      var myFormat = new DateFormat('dd-MM-yyyy');
      return Align(
        alignment: Alignment.centerRight,
        child: TextButton.icon(
          onPressed: () {
            processDateModalBottomSheet(context);
          },
          icon: Icon(Icons.edit),
          label: Text(
              '${myFormat.format(context.watch<PaymentProvider>().paymentItemObject.date)}'),
        ),
      );
    } else if (isIcon) {
      return Align(
        alignment: Alignment.centerRight,
        child: TextButton.icon(
          icon: Icon(Icons.emoji_emotions),
          label: Text("Change Icon"),
          onPressed: () async {
            IconData? icon = await showIconPicker(
              context,
              iconPackModes: [IconPack.material],
              backgroundColor: Theme.of(context).colorScheme.surface,
              iconColor: Theme.of(context).colorScheme.onSurface,
              iconSize: 40,
              title: Text(
                'Select an Icon',
                style:
                    TextStyle(color: Theme.of(context).colorScheme.onSurface),
              ),
            );

            if (icon != null) {
              context.read<PaymentProvider>().setIcon(Icon(icon));
            }
          },
        ),
      );
    } else {
      return Align(
        alignment: Alignment.centerRight,
        child: TextButton.icon(
          icon: Icon(Icons.edit),
          label: Text(value),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                final TextEditingController controller =
                    TextEditingController(text: value);
                return ModalEditPaymentInfo(
                    keyboardType: keyboardType,
                    inputFormatters: inputFormatters,
                    maxLines: maxLines,
                    isEditable: isEditable,
                    title: title,
                    controller: controller);
              },
            );
          },
        ),
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
      context.read<PaymentProvider>().setDate(picked);
    }
  }
}

class ModalEditPaymentInfo extends StatelessWidget {
  const ModalEditPaymentInfo({
    super.key,
    required this.keyboardType,
    required this.inputFormatters,
    required this.maxLines,
    required this.isEditable,
    required this.title,
    required this.controller,
  });

  final TextInputType keyboardType;
  final List<TextInputFormatter> inputFormatters;
  final int maxLines;
  final bool isEditable;
  final String title;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(10.0),
          child: TextFormField(
            keyboardType: keyboardType,
            inputFormatters: inputFormatters,
            maxLines: maxLines,
            decoration: InputDecoration(
              enabled: isEditable,
              labelText: title,
              labelStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 24,
                ),
            controller: controller,
          ),
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(10),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
            onPressed: () {
              if (title == "Title") {
                context.read<PaymentProvider>().setTitle(controller.text);
              } else if (title == "Price") {
                context
                    .read<PaymentProvider>()
                    .setPrice(double.parse(controller.text));
              } else if (title == "Description") {
                context.read<PaymentProvider>().setDescription(controller.text);
              }
              Navigator.of(context).pop();
            },
            child: Text(
              "Save",
              style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
            ),
          ),
        ),
      ],
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
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                )),
      ],
    );
  }
}
