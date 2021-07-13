import 'package:flutter/material.dart';
import 'package:payments/Widgets/BottomAppBarInfo.dart';
import 'package:payments/Widgets/GridViewSuscription.dart';
import 'package:payments/Widgets/MainSliver.dart';
import 'package:payments/models/Session.dart';
import 'package:payments/models/Suscription.dart';
import 'package:payments/utils/Utils.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: <Widget>[
            MainSliver(),
            SliverPadding(
                padding: EdgeInsets.only(top: Borders.borderCard),
                sliver: Consumer<Session>(
                  builder: (context, session, child) => GridViewSuscription(
                      suscriptionList: session.suscriptionList),
                )),
            //content()),
          ]),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () => addNew(context),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBarInfo(),
    );
  }

  void addNew(BuildContext context) {
    var sus = Suscription(
      id: context.read<Session>().suscriptionList!.length,
      name: "name",
      description: "description",
      date: DateTime.now(),
      price: 0.00,
      color: Colors.grey.value,
      logo: null,
    );

    var listaSus = context.read<Session>();
    listaSus.add(sus);
  }
}
