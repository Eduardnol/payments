import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

//Get UID from firebase
  Future<String> getCurrentUID() async {
    return _firebaseAuth.currentUser!.uid;
  }
}
