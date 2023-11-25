import 'package:flutter/material.dart';

class BottomAppBarInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final total = 9.9;
    return BottomAppBar(
      shape: AutomaticNotchedShape(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(0),
          ),
        ),
        RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
      ),
      color: Theme.of(context).colorScheme.surfaceVariant,
    );
  }
}
