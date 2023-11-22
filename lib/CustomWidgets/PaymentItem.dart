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
            child: Row(
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancel"),
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.red),
                  ),
                ),
                Spacer(),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Save"),
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.green),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 9,
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(child: Text("Title"), flex: 8),
                    Expanded(child: Text("Sample Text"), flex: 2),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
