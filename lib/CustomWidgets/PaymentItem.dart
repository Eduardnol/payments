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
                PaymentRowItem(
                    title: "Title", value: "Spotify", icon: Icons.title),
                PaymentRowItem(
                    title: "Price",
                    value: "R\$ 16,90",
                    icon: Icons.attach_money),
                PaymentRowItem(
                    title: "Desctiption",
                    value: "Music",
                    icon: Icons.description),
                PaymentRowItem(
                    title: "Date",
                    value: "01/01/2021",
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
                      Icon(icon),
                      Text(title),
                    ],
                  ),
                  flex: 8),
              Expanded(child: Text(value), flex: 2),
            ],
          ),
        ),
        Divider(),
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
