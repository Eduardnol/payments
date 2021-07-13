import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:payments/utils/Utils.dart';

class EditableField extends StatefulWidget {
  String? pista = "Text";
  var suscription;

  EditableField({this.pista, this.suscription});

  @override
  _EditableFieldState createState() => _EditableFieldState();
}

class _EditableFieldState extends State<EditableField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(
          color: widget.suscription.color.computeLuminance() > 0.5
              ? Colors.black
              : Colors.white,
          fontSize: TextSize.textNormal),
      autocorrect: true,
      autofocus: false,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: widget.pista,
      ),
    );
  }
}
