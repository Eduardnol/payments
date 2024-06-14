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
        title: Text('Perfil'),
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
            title: Text('Cambiar contraseña'),
            onTap: () {
              _changePassword();
            },
          ),
          ListTile(
            leading: Icon(Icons.delete_forever_rounded),
            title: Text('Eliminar cuenta'),
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
          title: Text('Cambiar contraseña',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  )),
          content: Column(
            children: <Widget>[
              TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Contraseña actual',
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
                    labelText: 'Nueva contraseña',
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
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Aceptar'),
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
                    content: Text("Se ha cambiado la contraseña"),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);

                  Navigator.of(context).pop();
                } catch (e) {
                  Navigator.of(context).pop();
                  // Manejar el error
                  print(e);
                  // Mostrar un Snackbar
                  final snackBar = SnackBar(
                    content: Text(
                        "Error al actualizar la contraseña:" + e.toString()),
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
          title: Text('Confirmar eliminación de cuenta'),
          content: Text(
              '¿Estás seguro de que quieres eliminar tu cuenta? Esta acción no se puede deshacer.'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Eliminar'),
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
                    content:
                        Text("Error al eliminar la cuenta: " + e.toString()),
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
