import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthService with ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

//Get UID from firebase
  Future<String> getCurrentUID() async {
    return _firebaseAuth.currentUser!.uid;
  }
}
