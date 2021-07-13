import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:payments/exceptions/ExceptionHandlerSpecific.dart';
import 'package:payments/models/UserLocal.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Create user obj base on FireBaseUser
  UserLocal? _userFromFirebaseUser(User? user) {
    return user != null ? UserLocal(uid: user.uid) : null;
  }

  //Auth change user stream
  Stream<UserLocal?> get user {
    return _auth
        .authStateChanges()
        .map((User? user) => _userFromFirebaseUser(user));
  }

  //Sign in Anonymously
  Future signInAnon() async {
    try {
      var result = await _auth.signInAnonymously();
      FirebaseAuth.instance.setPersistence(Persistence.NONE);
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } on FirebaseAuthException catch (e) {
      ExceptionSignIn(e.code).getMessageFromErrorCode();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

//Sign in with email and password
  Future signInEmail({required email, required password}) async {
    try {
      var result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      FirebaseAuth.instance.setPersistence(Persistence.LOCAL);

      User? user = result.user;

      return _userFromFirebaseUser(user);
    } on FirebaseAuthException catch (e) {
      ExceptionSignIn(e.code).getMessageFromErrorCode();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

//Register with email and password
  Future signUpEmail({required email, required password}) async {
    try {
      var result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseAuth.instance.setPersistence(Persistence.LOCAL);
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } on FirebaseAuthException catch (e) {
      ExceptionSignIn(e.code).getMessageFromErrorCode();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

//Sign Out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

//Error show

  void showErrorMessage(String message, BuildContext context) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
