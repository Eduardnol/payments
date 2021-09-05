import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Auth {
  static final RegExp emailRegex = new RegExp(
      "[a-z0-9!#\$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#\$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?");
}

class Borders {
  static const borderCard = 16.0;
  static const padding = 5.0;
  static const space = 10.0;
  static const gridAaxis = 280.0;
  static const borderDialog = 46.0;
  static const thickness = 1.0;
  static const inferiorMargin = 60.0;
  static const interiorPadding = 18.0;
  static const textOptions = 12.0;
}

class BoxSize {
  static const popupSize = 252.0;
  static const popupSizeInterior = 200.0;
  static const paddingSize = 100.0;
}

class TextSize {
  static const textInfo = 12.0;
  static const textButton = 15.0;
  static const textSubtitle = 20.0;
  static const textNormal = 18.0;
  static const textPrice = 20.0;
  static const textTitle = 25.0;
}

class TextSizeCards {
  static const textTitle = 10.0;
  static const textDate = 6.0;
  static const textPrice = 6.0;
}

class ContainerSize {
  static const smallCard = 32.0;
  static const bigCard = 82.0;
}

class ColorsApp {
  //https://material.io/resources/color/#!/?view.left=1&view.right=0&primary.color=455A64&secondary.color=0097A7&primary.text.color=ffffff

  static const primary = Color.fromRGBO(69, 90, 100, 1);
  static const primaryLight = Color.fromRGBO(113, 135, 146, 1);
  static const primaryDark = Color.fromRGBO(28, 49, 58, 1);

  static const secondary = Color.fromRGBO(0, 151, 167, 1);
  static const secondaryLight = Color.fromRGBO(86, 200, 216, 1);
  static const secondaryDark = Color.fromRGBO(0, 105, 120, 1);

  static const background = Color.fromRGBO(245, 245, 245, 1);
  static const next = Color(0x0e2f44);
}
