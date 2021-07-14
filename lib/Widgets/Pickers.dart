import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:payments/actions/Checker.dart';
import 'package:payments/models/Session.dart';
import 'package:payments/utils/Utils.dart';
import 'package:provider/provider.dart';

//Editaremos las entradas de widgets desde aqui
class DateCupertino extends StatefulWidget {
  int? index;

  DateCupertino({required this.index});

  @override
  _DateCupertinoState createState() => _DateCupertinoState();
}

class _DateCupertinoState extends State<DateCupertino> {
  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    Session suscription = Provider.of<Session>(context);

    return Container(
      height: BoxSize.popupSize,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CupertinoButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Cancel",
                  style: TextStyle(color: Colors.red),
                ),
              ), //Cancel
              CupertinoButton(
                onPressed: () {
                  if (checkDate(date)) {
                    suscription.editDate(widget.index!, date);
                    Navigator.pop(context);
                  } else {
                    selectDialog(context);
                  }
                },
                child: Text(
                  "Accept",
                  style: TextStyle(color: Colors.blue),
                ),
              ), //Accept
            ],
          ), //Buttons
          Container(
            height: BoxSize.popupSizeInterior,
            child: CupertinoDatePicker(
              initialDateTime: date,
              onDateTimeChanged: (DateTime value) {
                date = value;
              },
              mode: CupertinoDatePickerMode.date,
            ),
          ),
        ],
      ),
    );
  }

  void selectDialog(BuildContext context) {
    var platform = Theme.of(context).platform;
    print("Changing Price");

    if (platform == TargetPlatform.android) {
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                title: Text(
                  "Error",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                content: Text("El dia debe ser menor a 29"),
                actions: [
                  TextButton(
                    child: Text("Aceptar"),
                    onPressed: () => Navigator.pop(context),
                  )
                ],
              ));
    }

    if (platform == TargetPlatform.iOS) {
      showDialog(
          context: context,
          builder: (_) => CupertinoAlertDialog(
                title: Text("Error"),
                content: Text("El dia debe ser menor a 29"),
                actions: [
                  CupertinoDialogAction(
                    child: Text("Aceptar"),
                    onPressed: () => Navigator.pop(context),
                  )
                ],
              ));
    }
  }
}

class PricePicker extends StatefulWidget {
  final int numbersToGenerate;
  int? index;

  PricePicker({required this.numbersToGenerate, required this.index});

  @override
  _PricePickerState createState() => _PricePickerState();
}

//List<Widget>.generate(
//                widget.numbersToGenerate, (i) => Text((i + 1).toString()))));

class _PricePickerState extends State<PricePicker> {
  var price;
  var desfasae = 0;
  FocusNode _focusNode = new FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_focusNodeListener);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_focusNodeListener);
    super.dispose();
  }

  Future<Null> _focusNodeListener() async {
    if (_focusNode.hasFocus) {
      print('TextField got the focus');
      desfasae = 90;
    } else {
      print('TextField lost the focus');
      desfasae = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    Session suscription = Provider.of<Session>(context);
    print("el precio es $price");
    return Material(
      child: Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CupertinoButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Cancel",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                CupertinoButton(
                  onPressed: () {
                    suscription.editPrice(widget.index!, price);
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Accept",
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
            TextField(
              onChanged: (String str) => price = transformValue(str),
              focusNode: _focusNode,
              autofocus: true,
              keyboardType:
                  TextInputType.numberWithOptions(signed: false, decimal: true),
              decoration: InputDecoration(
                labelText: 'Price',
                border: OutlineInputBorder(),
                suffixIcon: Icon(
                  Icons.monetization_on,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NamePicker extends StatefulWidget {
  int? index;

  NamePicker({required this.index});

  @override
  _NamePickerState createState() => _NamePickerState();
}

class _NamePickerState extends State<NamePicker> {
  var name;
  var desfasae = 0;
  FocusNode _focusNode = new FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_focusNodeListener);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_focusNodeListener);
    super.dispose();
  }

  Future<Null> _focusNodeListener() async {
    if (_focusNode.hasFocus) {
      print('TextField got the focus');
      desfasae = 90;
    } else {
      print('TextField lost the focus');
      desfasae = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    Session suscription = Provider.of<Session>(context);
    print("el nombre es $name");
    return Material(
      child: Container(
        height: BoxSize.popupSize + desfasae,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CupertinoButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Cancel",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                CupertinoButton(
                  onPressed: () {
                    suscription.editName(widget.index!, name);
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Accept",
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
            TextField(
              onChanged: (String str) => name = str,
              focusNode: _focusNode,
              keyboardType: TextInputType.name,
              enableSuggestions: true,
              maxLines: 1,
              autofocus: true,
              decoration: InputDecoration(
                labelText: 'Nombre',
                border: OutlineInputBorder(),
                suffixIcon: Icon(
                  Icons.title,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ColourPicker {
  static Widget colorPicker(var currentColor, int index, BuildContext context) {
    Color currentColorChanged;
    void changeColor(Color color) {
      currentColorChanged = color;
      Provider.of<Session>(context, listen: false)
          .editColor(index, currentColorChanged);
    }

    return AlertDialog(
      titlePadding: const EdgeInsets.all(0.0),
      contentPadding: const EdgeInsets.all(0.0),
      content: SingleChildScrollView(
        child: BlockPicker(
          pickerColor: currentColor,
          onColorChanged: changeColor,
        ),
      ),
    );
  }
}
