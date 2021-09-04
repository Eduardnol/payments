import 'package:flutter/material.dart';
import 'package:payments/services/authenticate/auth.dart';
import 'package:payments/utils/Utils.dart';

class MainSliver extends StatelessWidget {
  final AuthService _auth = AuthService();

  SliverAppBar appBar() {
    return SliverAppBar(
      backgroundColor: Colors.blueGrey,
      expandedHeight: 200.0,
      floating: true,
      pinned: false,
      stretch: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: false,
        title: Text("Hello There!",
            style: TextStyle(
              color: Colors.white,
              fontSize: TextSize.textTitle,
              fontWeight: FontWeight.bold,
            )),
        stretchModes: <StretchMode>[
          StretchMode.zoomBackground,
          StretchMode.blurBackground,
          StretchMode.fadeTitle
        ],
        background: FittedBox(
          fit: BoxFit.fitWidth,
          child: Image.network(
              "https://images.unsplash.com/photo-1619970291267-0e61f239c59e?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80"),
        ),
        collapseMode: CollapseMode.parallax,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return appBar();
  }
}
