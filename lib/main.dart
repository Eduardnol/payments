import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'CustomWidgets/PaymentItem.dart';
import 'firebase_options.dart';

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
      title: 'Payments',
      theme: ThemeData(
        // This is the theme of your application.
        primaryColor: Colors.blue,
        hintColor: Colors.blueAccent,
        textTheme: GoogleFonts.montserratTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: MyHomePage(title: "Hello World Flutter Application"),
    );
  }
}

class MyHomePage extends StatelessWidget {
  // This widget is the home page of your application.
  final String title;

  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: Text(title),
          floating: true,
          backgroundColor: Colors.green,
          expandedHeight: 200.0,
          flexibleSpace: FlexibleSpaceBar(
            background: Image.network('https://picsum.photos/250?image=9'),
          ),
          stretch: true,
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Container(
                height: MediaQuery.of(context).size.height,
              ),
            ],
          ),
        ),
      ],
    );
  }

  void showModalBottomSheetDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height,
          child: PaymentItem(),
        );
      },
    );
  }
}
