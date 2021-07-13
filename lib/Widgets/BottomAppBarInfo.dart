import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:payments/utils/Utils.dart';

class BottomAppBarInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final total = 9.9;
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      color: ColorsApp.primary,
      child: Container(
        height: 55,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Total este mes: $total",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
