import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:payments/CustomWidgets/BottomAppBarInfo.dart';
import 'package:payments/CustomWidgets/FullDialogPayment/FullScreenDialogPayment.dart';
import 'Model/PaymentItemObject.dart';
import 'firebase_options.dart';
import 'CustomWidgets/GridListPayments.dart';

//TODO iOS firebase cloud messaging
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // This is the theme of your application.
        colorSchemeSeed: Colors.blueGrey,
        brightness: Brightness.light,
        textTheme: GoogleFonts.montserratTextTheme(
          Theme.of(context).textTheme,
        ),
        useMaterial3: true,
      ),
      home: MyHomePage(title: "Hello World Flutter Application"),
      title: 'Payments',
      darkTheme: ThemeData(
        colorSchemeSeed: Colors.blueGrey,
        brightness: Brightness.dark,
        textTheme: GoogleFonts.montserratTextTheme(
          Theme.of(context).textTheme,
        ),
        useMaterial3: true,
      ),
      themeMode: ThemeMode.system, // device controls theme
    );
  }
}

class MyHomePage extends StatelessWidget {
  // This widget is the home page of your application.
  final String title;

  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            pinned: true,
            snap: true,
            backgroundColor: Theme.of(context).colorScheme.primary,
            expandedHeight: 200.0,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: false,
              title: Text("Hello There!",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onPrimary,
                      )),
              stretchModes: <StretchMode>[
                StretchMode.zoomBackground,
                StretchMode.blurBackground,
                StretchMode.fadeTitle
              ],
              background: FittedBox(
                fit: BoxFit.fitWidth,
                child: Image.network(
                    "https://images.unsplash.com/photo-1619970291267-0e61f239c59e?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80"),
              ),
              collapseMode: CollapseMode.pin,
            ),
            stretch: true,
          ),
          GridListPayments(),
        ],
      ),
      bottomNavigationBar: BottomAppBarInfo(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        onPressed: () async {
          await createItemFromModalBottomSheetDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> createItemFromModalBottomSheetDialog(
      BuildContext context) async {
    final paymentItemObject = PaymentItemObject(
      id: await FirebaseFirestore.instance.collection('payments').doc(),
      date: "2021-05-01",
      title: "Hello World",
      category: "Food",
      price: "10.00",
      description: 'DESC',
      createdOn: DateTime.now(),
    );

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return ModalBottomSheetCustom(paymentItemObject: paymentItemObject);
      },
    );
  }
}
