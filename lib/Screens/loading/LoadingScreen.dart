import 'package:flutter/material.dart';

/*
Clase de la pantalla de carga con la libreria de iconos de carga
 */
class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with TickerProviderStateMixin {
  var _color;

  @override
  void initState() {
    super.initState();
    AnimationController _animationController =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    _color = _animationController
        .drive(ColorTween(begin: Colors.yellow, end: Colors.blue));
    _animationController.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: CircularProgressIndicator(
          valueColor: _color,
        ),
      ),
    );
  }
}
