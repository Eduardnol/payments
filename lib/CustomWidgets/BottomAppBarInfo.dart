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
      color: Theme.of(context).primaryColor,
      child: Container(
        height: 55,
        color: Colors.blue.withOpacity(0.1),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "",
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
