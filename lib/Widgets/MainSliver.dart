import 'package:flutter/material.dart';
import 'package:payments/services/authenticate/auth.dart';

class MainSliver extends StatelessWidget {
  final AuthService _auth = AuthService();

  SliverAppBar appBar() {
    return SliverAppBar(
      expandedHeight: 200.0,
      floating: false,
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
        stretchModes: [
          StretchMode.zoomBackground,
          StretchMode.blurBackground,
          StretchMode.fadeTitle
        ],
        title: Text("Collapsing Toolbar",
            style: TextStyle(
              color: Colors.white,
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
            )),
        background: Image.network(
          //"https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350",
          "https://images.unsplash.com/photo-1597319807488-0e901f36e2d5?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1547&q=80",
          fit: BoxFit.cover,
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
