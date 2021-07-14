import 'package:flutter/material.dart';
import 'package:payments/services/authenticate/auth.dart';

class MainSliver extends StatelessWidget {
  final AuthService _auth = AuthService();

  SliverAppBar appBar() {
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      expandedHeight: 200.0,
      floating: true,
      pinned: true,
      stretch: true,
      actions: <Widget>[
        TextButton.icon(
          onPressed: () async {
            await _auth.signOut();
          },
          icon: Icon(
            Icons.logout,
            color: Colors.white,
          ),
          label: Text("logout"),
        )
      ],
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        stretchModes: <StretchMode>[
          StretchMode.zoomBackground,
          StretchMode.blurBackground,
          StretchMode.fadeTitle
        ],
        background: Container(
          alignment: AlignmentDirectional.center,
          child: Text("Your Balance Is",
              style: TextStyle(
                color: Colors.white,
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
              )),
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
