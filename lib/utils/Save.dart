import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:payments/models/SaveInformation.dart';
import 'package:payments/models/Session.dart';
import 'package:payments/models/Suscription.dart';

class SaveFile {
  static List<Suscription>? decodeJson() {
    String? suscriptionsString = SaveInformation.getInfoFromSharedPref();

    if (suscriptionsString != null) {
      Map<String, dynamic> map = jsonDecode(suscriptionsString);
      Session session = Session.fromJson(map);

      return session.suscriptionList;
    } else {
      List<Suscription> none = [];
      none.add(Suscription(
        id: 0,
        name: "vacio",
        color: Colors.green.value,
        date: DateTime.now(),
        description: "None",
        price: 9,
        logo: Icons.queue,
      ));
      return none;
    }
  }

  static String encodeJson(Session info) {
    return info.toJson();
  }
}
