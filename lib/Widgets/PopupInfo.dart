import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:payments/Widgets/Pickers.dart';
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
//TODO Editar los cambios en la lista
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
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Image.asset(
                  "assets/images/logo_flutter_1080px_clr.png",
                  scale: 10.23,
                  fit: BoxFit.cover,
                ),
                Divider(
                  height: Borders.space * 2,
                  thickness: Borders.thickness * 4,
                ),
                Row(
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
                    GestureDetector(
                      onTap: () => _showCupertinoNamePicker(context),
                      child: Text(
                          session.suscriptionList!.elementAt(widget.index).name,
                          style: TextStyle(
                              color: Color(session.suscriptionList!
                                              .elementAt(widget.index)
                                              .color)
                                          .computeLuminance() >
                                      0.5
                                  ? Colors.black
                                  : Colors.white,
                              fontSize: TextSize.textSubtitle)),
                    ),
                  ],
                ), //Name
                Row(
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
                              fontSize: TextSize.textNormal)),
                    ),
                  ],
                ), //Payment Date
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Price:",
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
                        _showCupertinoNumberPicker(context);
                      },
                      child: Text(
                          session.suscriptionList!
                              .elementAt(widget.index)
                              .price
                              .toString(),
                          style: TextStyle(
                              color: Color(session.suscriptionList!
                                              .elementAt(widget.index)
                                              .color)
                                          .computeLuminance() >
                                      0.5
                                  ? Colors.black
                                  : Colors.white,
                              fontSize: TextSize.textNormal)),
                    ),
                  ],
                ), //Price
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
                    child: Text(
                        session.suscriptionList!
                            .elementAt(widget.index)
                            .description,
                        style: TextStyle(
                            color: Color(session.suscriptionList!
                                            .elementAt(widget.index)
                                            .color)
                                        .computeLuminance() >
                                    0.5
                                ? Colors.black
                                : Colors.white,
                            fontSize: TextSize.textButton)),
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
