import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:payments/Screens/principal/Principal.dart';
import 'package:payments/models/UserLocal.dart';
import 'package:provider/provider.dart';

//Mira si estamos logueados para dirigirnos a una parte o a la otra de la aplicacion
class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserLocal?>(context);
    //return (user == null) ? LogIn() : MyHomePage();
    return MyHomePage();
  }
}
