import 'package:flutter/material.dart';
import 'package:payments/Widgets/SuscriptionCards.dart';
import 'package:payments/models/Suscription.dart';
import 'package:payments/utils/Utils.dart';

///Custom grid view integrated with CustomScrollView in order to pass info between Slivers
class GridViewSuscription extends StatefulWidget {
  List<Suscription>? suscriptionList = [];

  GridViewSuscription({required this.suscriptionList});

  @override
  _GridViewSuscriptionState createState() => _GridViewSuscriptionState();
}

class _GridViewSuscriptionState extends State<GridViewSuscription> {
  @override
  Widget build(BuildContext context) {
    return SliverGrid.extent(
      mainAxisSpacing: 0,
      crossAxisSpacing: 0,
      childAspectRatio: 3 / 2,
      maxCrossAxisExtent: Borders.gridAaxis,
      children: insertInformation(widget.suscriptionList),
    );
  }

  // Insertamos la informacion dentro de la lista de Cards a partir de la lista de suscripciones de Session
  List<SuscriptionCards> insertInformation(var cart) {
    List<SuscriptionCards> _suscriptionList = [];
    for (int i = 0; i < cart.length; i++) {
      _suscriptionList.add(SuscriptionCards(cart.elementAt(i), i));
    }
    return _suscriptionList;
  }
}
