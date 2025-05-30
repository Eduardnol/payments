import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../LoginPage.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? user;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.mail),
            title: Text('Email: ${user?.email}'),
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.lock),
            title: Text('Change Password'),
            onTap: () {
              _changePassword();
            },
          ),
          ListTile(
            leading: Icon(Icons.delete_forever_rounded),
            title: Text('Delete Account'),
            onTap: () async {
              _confirmDeleteAccount();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
            },
          ),
        ],
      ),
    );
  }

  Future<void> _changePassword() async {
    String oldPassword = '';
    String newPassword = '';

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Change Password',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  )),
          content: Column(
            children: <Widget>[
              TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Current Password',
                  ),
                  onChanged: (value) {
                    oldPassword = value;
                  },
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      )),
              TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'New Password',
                  ),
                  onChanged: (value) {
                    newPassword = value;
                  },
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      )),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Accept'),
              onPressed: () async {
                try {
                  // Crear una credencial
                  AuthCredential credential = EmailAuthProvider.credential(
                    email: user!.email!,
                    password: oldPassword,
                  );

                  // Reautenticar
                  await user!.reauthenticateWithCredential(credential);

                  // Actualizar la contraseña
                  await user!.updatePassword(newPassword);
                  final snackBar = SnackBar(
                    content: Text("Password has been changed"),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);

                  Navigator.of(context).pop();
                } catch (e) {
                  Navigator.of(context).pop();
                  // Manejar el error
                  print(e);
                  // Mostrar un Snackbar
                  final snackBar = SnackBar(
                    content: Text("Error updating password: " + e.toString()),
                    backgroundColor: Colors.red,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _confirmDeleteAccount() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Account Deletion'),
          content: Text(
              'Are you sure you want to delete your account? This action cannot be undone.'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () async {
                try {
                  //Get the current user id
                  String id = FirebaseAuth.instance.currentUser!.uid;
                  //Delete all the data of the user
                  await FirebaseFirestore.instance
                      .collection('userData')
                      .doc(id)
                      .delete();
                  //Delete the user
                  await user?.delete();
                  Navigator.of(context).pop();
                } catch (e) {
                  print(e);
                  final snackBar = SnackBar(
                    content: Text("Error deleting account: " + e.toString()),
                    backgroundColor: Colors.red,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
            ),
          ],
        );
      },
    );
  }
}
