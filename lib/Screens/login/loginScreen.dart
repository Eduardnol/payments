import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:payments/Screens/loading/LoadingScreen.dart';
import 'package:payments/Screens/signin/signin.dart';
import 'package:payments/services/authenticate/auth.dart';
import 'package:payments/utils/Utils.dart';

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final AuthService _authService = AuthService();
  String email = '';
  String password = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? LoadingScreen()
        : Scaffold(
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
                          return 'Please enter valid email';
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
                    TextButton(
                      child: Text("Sign In Anon"),
                      onPressed: () async {
                        setState(() => loading = true);
                        dynamic result = await _authService
                            .signInAnon()
                            .whenComplete(
                                () => setState(() => loading = false));
                        if (result == null) {
                          print("Error signing in");
                        } else {
                          print("Signed In");
                          print(result.uid);
                        }
                      },
                    ),
                    TextButton(
                      child: Text("Log In Email"),
                      onPressed: () async {
                        setState(() => loading = true);
                        dynamic result = await _authService
                            .signInEmail(email: email, password: password)
                            .whenComplete(
                                () => setState(() => loading = false));
                        print(result.uid);
                      },
                    ),
                    TextButton(
                      child: Text("No account? --> Sign Up Email"),
                      onPressed: () async {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => SignIn()));
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
