import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:payments/Pages/ModalViewPaymentInfo/ModalBottomSheetPayment.dart';
import 'package:payments/Pages/Profile/ProfilePage.dart';
import 'package:payments/providers/PaymentProvider.dart';
import 'package:payments/services/AuthService.dart';
import 'package:provider/provider.dart';
import 'Model/PaymentObject.dart';
import 'Pages/LoginPage.dart';
import 'firebase_options.dart';
import 'Pages/MainPaymentsList/ListViewPayments.dart';

//TODO iOS firebase cloud messaging
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ChangeNotifierProvider(
    create: (context) => PaymentProvider(
      PaymentItemObject.empty(),
    ),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AuthService>(
      create: (_) => AuthService(),
      child: MaterialApp(
        theme: ThemeData(
          // This is the theme of your application.
          colorSchemeSeed: Colors.blueGrey,
          brightness: Brightness.light,
          textTheme: GoogleFonts.montserratTextTheme(
            Theme.of(context).textTheme,
          ),
          useMaterial3: true,
        ),
        home: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return const MyHomePage(title: "Payments App");
              } else {
                return const LoginPage();
              }
            }),
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
      ),
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
            onStretchTrigger: () async {
              print("SliverAppBar onStretchTrigger");
            },
            floating: true,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.account_circle),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilePage()),
                  );
                },
              ),
            ],
            pinned: true,
            snap: true,
            backgroundColor: Theme.of(context).colorScheme.primary,
            expandedHeight: 200.0,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: false,
              title: Text("Your Payments",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      )),
              stretchModes: <StretchMode>[
                StretchMode.zoomBackground,
                StretchMode.blurBackground,
                StretchMode.fadeTitle
              ],
              background: FittedBox(
                fit: BoxFit.fitWidth,
                child: Image.asset('images/main_screen.jpg'),
              ),
              collapseMode: CollapseMode.pin,
            ),
            stretch: true,
          ),
          GridListPayments(),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).colorScheme.surfaceVariant,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
      floatingActionButton: FloatingActionButton(
        //backgroundColor: Theme.of(context).colorScheme.primary,
        onPressed: () async {
          await createItemFromModalBottomSheetDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> createItemFromModalBottomSheetDialog(
      BuildContext context) async {
    final paymentItemObject = PaymentItemObject.empty();
    context.read<PaymentProvider>().paymentItemObject = paymentItemObject;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            child:
                ModalBottomSheetPayment(paymentItemObject: paymentItemObject),
          ),
        );
      },
    );
  }
}
