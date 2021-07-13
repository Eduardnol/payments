import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:payments/Widgets/PopupInfo.dart';
import 'package:payments/models/Suscription.dart';
import 'package:payments/utils/Utils.dart';

///Creates all the cards containing the suscriptions
class SuscriptionCards extends StatefulWidget {
  final Suscription? suscriptions;

  SuscriptionCards(this.suscriptions);

  @override
  _SuscriptionCardsState createState() => _SuscriptionCardsState();
}

class _SuscriptionCardsState extends State<SuscriptionCards> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: new EdgeInsets.all(0.0),
      child: GestureDetector(
        onTap: () {
          _onButtonPressed(context);
        },
        child: Card(
          color: Color(widget.suscriptions!.color),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Borders.borderCard)),
          child: Padding(
            padding: EdgeInsets.all(Borders.padding),
            child: FittedBox(
              fit: BoxFit.contain,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Hero(
                    tag: 'icon',
                    child: Image.asset(
                      "assets/images/logo_flutter_1080px_clr.png",
                      scale: 10.23,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ///Name
                      Text(
                        widget.suscriptions!.name,
                        style: TextStyle(
                          color: Color(widget.suscriptions!.color)
                                      .computeLuminance() >
                                  0.5
                              ? Colors.black
                              : Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      ///Date
                      Text(
                        widget.suscriptions!.date!.day.toString() +
                            '-' +
                            widget.suscriptions!.date!.month.toString() +
                            '-' +
                            widget.suscriptions!.date!.year.toString(),
                        style: TextStyle(
                          color: Color(widget.suscriptions!.color)
                                      .computeLuminance() >
                                  0.5
                              ? Colors.black
                              : Colors.white,
                          fontSize: 12,
                        ),
                      ),

                      ///Price
                      Text(
                        widget.suscriptions!.price.toString() + " €",
                        style: TextStyle(
                          color: Color(widget.suscriptions!.color)
                                      .computeLuminance() >
                                  0.5
                              ? Colors.black
                              : Colors.white,
                          fontSize: 12,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  ///Is going to show a Bottom Sheet coming down the screen showing more info about the card
  void _onButtonPressed(BuildContext pepe) {
    showCupertinoModalBottomSheet(
        bounce: true,
        expand: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Borders.borderCard)),
        enableDrag: true,
        context: context,
        builder: (pepe) {
          return SuscriptionInfo(widget.suscriptions!.id);
        });
  }

//TODO eliminar update interface y revisar el modo de obtener datos de las SuscriptionCards y su relacion con la gridView

}
