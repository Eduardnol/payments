import 'package:flutter/material.dart';

class PaymentItem extends StatelessWidget {
  const PaymentItem({
    super.key,
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
            flex: 1,
            child: SaveCancelButtons(),
          ),
          Expanded(
            flex: 9,
            child: Column(
              children: [
                PaymentRowItem(title: "Title", value: "Spotify"),
                PaymentRowItem(title: "Price", value: "R\$ 16,90"),
                PaymentRowItem(title: "Desctiption", value: "Music"),
                PaymentRowItem(title: "Date", value: "01/01/2021"),
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

  PaymentRowItem({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(child: Text(title), flex: 8),
        Expanded(child: Text(value), flex: 2),
      ],
    );
  }
}

class SaveCancelButtons extends StatelessWidget {
  const SaveCancelButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Cancel"),
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
          ),
        ),
        Spacer(),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Save"),
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.green),
          ),
        ),
      ],
    );
  }
}
