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
          floating: true,
          pinned: true,
          snap: true,
          backgroundColor: Colors.green,
          expandedHeight: 200.0,
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: false,
            title: Text("Hello There!",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
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
