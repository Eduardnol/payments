import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:payments/Screens/loading/LoadingScreen.dart';
import 'package:payments/actions/Checker.dart';
import 'package:payments/services/authenticate/auth.dart';
import 'package:payments/utils/Utils.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  late String email;
  String? password;
  String? password2;

  bool passValid = false;
  bool emailValid = false;

  bool loading = false;

  late var callback;

  @override
  Widget build(BuildContext context) {
    return loading
        ? LoadingScreen()
        : Scaffold(
            appBar: AppBar(),
            body: Form(
              child: Padding(
                padding: const EdgeInsets.all(Borders.space),
                child: Column(
                  children: [
                    SizedBox(
                      height: BoxSize.paddingSize,
                    ),
                    Text("email"),
                    TextFormField(
                      validator: (value) {
                        if (!Auth.emailRegex.hasMatch(value!)) {
                          emailValid = false;
                          return 'Please enter valid email';
                        } else {
                          emailValid = true;
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                      decoration: InputDecoration(
                        labelText: 'email',
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(
                          Icons.mail,
                        ),
                      ),
                    ),
                    Text("password"),
                    TextFormField(
                      validator: (String? value) {
                        if (!checkPassword(value!)) {
                          passValid = false;
                          return 'Password not valid (6 characters required)';
                        } else {
                          passValid = true;
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.text,
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                      obscureText: true,
                      autocorrect: false,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(
                          Icons.lock_outline,
                        ),
                      ),
                    ),
                    Text("password confirmation"),
                    TextFormField(
                      validator: (String? value) {
                        if (password != password2) {
                          passValid = false;
                          return 'Passwords don\'t match';
                        }
                        if (value!.isNotEmpty) {
                          passValid = true;
                        }
                        if (!checkPassword(value)) {
                          passValid = false;
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.text,
                      onChanged: (val) {
                        setState(() => password2 = val);
                      },
                      obscureText: true,
                      autocorrect: false,
                      decoration: InputDecoration(
                        labelText: 'Password Confirmation',
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(
                          Icons.lock_outline,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      child: Text("Sign In Email"),
                      onPressed: () async {
                        setState(() => loading = true);
                        if (passValid && emailValid) {
                          print("Sign In");
                          callback = AuthService()
                              .signUpEmail(email: email, password: password)
                              .whenComplete(
                                  () => setState(() => loading = false));
                        } else {
                          setState(() => loading = false);
                          AuthService().showErrorMessage(
                              "Error, compruebe los datos", context);
                          print("Errors");
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
