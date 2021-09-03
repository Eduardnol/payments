import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:payments/Widgets/Pickers.dart';
import 'package:payments/actions/Checker.dart';
import 'package:payments/models/Session.dart';
import 'package:payments/utils/Utils.dart';
import 'package:provider/provider.dart';

class SuscriptionInfo extends StatefulWidget {
  var index;

  SuscriptionInfo(this.index);

  @override
  _SuscriptionInfoState createState() => _SuscriptionInfoState();
}

class _SuscriptionInfoState extends State<SuscriptionInfo> {
  void _iconPicker(BuildContext context) async {
    Session suscription = Provider.of<Session>(context, listen: false);
    IconData? icon = await FlutterIconPicker.showIconPicker(context,
        iconPackMode: IconPack.material);
    if (icon != null) {
      suscription.editLogo(widget.index, Icon(icon));
    }
  }

  ///Confirmation for the delete of one Suscription
  void _confirmation(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => CupertinoAlertDialog(
              title: Text("¿Eliminar Permanentemente?"),
              actions: [
                CupertinoDialogAction(
                    isDestructiveAction: true,
                    child: Text("Aceptar"),
                    onPressed: () {
                      Provider.of<Session>(context, listen: false)
                          .delete(widget.index);
                      Navigator.pop(context);
                      Navigator.pop(context);
                    }),
                CupertinoDialogAction(
                  child: Text("Cancelar"),
                  onPressed: () => Navigator.pop(context),
                )
              ],
            ));
  }

  ///Date Picker for Cupertino
  void _showCupertinoDatePicker(BuildContext context) {
    var platform = Theme.of(context).platform;

    if (platform == TargetPlatform.android)
      showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2090));
    else
      showCupertinoModalBottomSheet(
          bounce: false,
          expand: false,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Borders.borderCard)),
          enableDrag: true,
          context: context,
          builder: (context) {
            return DateCupertino(
              index: widget.index,
            );
            //TODO scroll controler
          });
  }

  ///Number picker for Cupertino
  void _showCupertinoNumberPicker(BuildContext context) {
    var platform = Theme.of(context).platform;
    print("Changing Price");

    if (platform == TargetPlatform.android)
      showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2090));
    else
      showCupertinoModalBottomSheet(
        expand: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Borders.borderCard)),
        enableDrag: true,
        context: context,
        builder: (context) {
          return PricePicker(
            numbersToGenerate: 10,
            index: widget.index,
          );
        },
      );
  }

  ///Name picker for Cupertino
  void _showCupertinoNamePicker(BuildContext context) {
    showCupertinoModalBottomSheet(
      expand: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Borders.borderCard)),
      enableDrag: true,
      context: context,
      builder: (context) {
        return NamePicker(
          index: widget.index,
        );
      },
    );
  }

  ///Color picker for Cupertino
  void _showCupertinoColorPicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ColourPicker.colorPicker(Colors.red, widget.index, context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Session>(
      builder: (context, session, child) => Material(
        child: Container(
          decoration: BoxDecoration(
            color:
            Color(session.suscriptionList!.elementAt(widget.index).color),
          ),
          height: 510,
          child: Padding(
            padding: const EdgeInsets.all(Borders.textOptions),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(Borders.interiorPadding),
                  child: GestureDetector(
                      onTap: () => _iconPicker(context),
                      child: Icon(session.suscriptionList!
                          .elementAt(widget.index)
                          .logo
                          .icon)),
                ),
                Padding(
                  padding: const EdgeInsets.all(Borders.interiorPadding),
                  child: TextField(
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    keyboardType: TextInputType.number,
                    onSubmitted: (String name) {
                      double value = transformValue(name);
                      return session.editPrice(widget.index, value);
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: session.suscriptionList!
                              .elementAt(widget.index)
                              .price
                              .toStringAsFixed(2) +
                          " €",
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(session.suscriptionList!
                                          .elementAt(widget.index)
                                          .color)
                                      .computeLuminance() >
                                  0.5
                              ? Colors.black
                              : Colors.white,
                          fontSize: TextSize.textPrice),
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                    ),
                  ),
                ),
                Divider(
                  height: Borders.space * 2,
                  thickness: Borders.thickness * 4,
                ),
                Padding(
                  padding: const EdgeInsets.all(Borders.textOptions),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Name:",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(session.suscriptionList!
                                              .elementAt(widget.index)
                                              .color)
                                          .computeLuminance() >
                                      0.5
                                  ? Colors.black
                                  : Colors.white,
                              fontSize: TextSize.textSubtitle)),
                      Container(
                        constraints: BoxConstraints.tightForFinite(width: 200),
                        child: TextField(
                          textAlign: TextAlign.end,
                          maxLines: 1,
                          onSubmitted: (String name) {
                            return session.editName(widget.index, name);
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: session.suscriptionList!
                                .elementAt(widget.index)
                                .name
                                .toString(),
                            hintStyle: TextStyle(
                                color: Color(session.suscriptionList!
                                                .elementAt(widget.index)
                                                .color)
                                            .computeLuminance() >
                                        0.5
                                    ? Colors.black
                                    : Colors.white,
                                fontSize: TextSize.textNormal),
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                          ),
                        ),
                      ),
                    ],
                  ),
                ), //Name
                Padding(
                  padding: const EdgeInsets.all(Borders.textOptions),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Payment Date:",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(session.suscriptionList!
                                              .elementAt(widget.index)
                                              .color)
                                          .computeLuminance() >
                                      0.5
                                  ? Colors.black
                                  : Colors.white,
                              fontSize: TextSize.textSubtitle)),
                      GestureDetector(
                        onTap: () {
                          _showCupertinoDatePicker(context);
                          //TODO cambiar el set state por el watcher que hemos aprendido
                        },
                        child: Text(
                          session.suscriptionList!
                                  .elementAt(widget.index)
                                  .date!
                                  .day
                                  .toString() +
                              '-' +
                              session.suscriptionList!
                                  .elementAt(widget.index)
                                  .date!
                                  .month
                                  .toString() +
                              '-' +
                              session.suscriptionList!
                                  .elementAt(widget.index)
                                  .date!
                                  .year
                                  .toString(),
                          style: TextStyle(
                              color: Color(session.suscriptionList!
                                              .elementAt(widget.index)
                                              .color)
                                          .computeLuminance() >
                                      0.5
                                  ? Colors.black
                                  : Colors.white,
                              fontSize: TextSize.textNormal),
                        ),
                      ),
                    ],
                  ),
                ), //Payment Date//Price
                Padding(
                  padding: const EdgeInsets.all(Borders.textOptions),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Color:",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(session.suscriptionList!
                                              .elementAt(widget.index)
                                              .color)
                                          .computeLuminance() >
                                      0.5
                                  ? Colors.black
                                  : Colors.white,
                              fontSize: TextSize.textSubtitle)),
                      GestureDetector(
                        onTap: () {
                          _showCupertinoColorPicker(context);
                        },
                        child: Text(
                          "Change Color",
                          style: TextStyle(
                              color: Color(session.suscriptionList!
                                              .elementAt(widget.index)
                                              .color)
                                          .computeLuminance() >
                                      0.5
                                  ? Colors.black
                                  : Colors.white,
                              fontSize: TextSize.textNormal),
                        ),
                      ),
                    ],
                  ),
                ),
                Text("Description:",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(session.suscriptionList!
                                        .elementAt(widget.index)
                                        .color)
                                    .computeLuminance() >
                                0.5
                            ? Colors.black
                            : Colors.white,
                        fontSize: TextSize.textSubtitle)), //Description
                Divider(
                  thickness: 0.0,
                ),
                Expanded(
                  flex: 1,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: TextField(
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      textAlign: TextAlign.center,
                      onSubmitted: (String description) {
                        return session.editDescripion(
                            widget.index, description);
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: session.suscriptionList!
                            .elementAt(widget.index)
                            .description
                            .toString(),
                        hintStyle: TextStyle(
                            color: Color(session.suscriptionList!
                                            .elementAt(widget.index)
                                            .color)
                                        .computeLuminance() >
                                    0.5
                                ? Colors.black
                                : Colors.white,
                            fontSize: TextSize.textNormal),
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => _confirmation(context),
                  child: Text(
                    "Delete",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
