import 'package:coop_shopping_app/pages/home_page.dart';
import 'package:coop_shopping_app/pages/splash_screen.dart';
import 'package:coop_shopping_app/providers/cart_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coop_shopping_app/pages/reports_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyAxTHauOaWVoZB3qHjzAVk_FvdRKFR-gvQ",
          appId: "1:528402176351:web:1ba2b7626f9fd3d220beea",
          messagingSenderId: "528402176351",
          projectId: "accra-buyers-club-firebase"),
    );
  }

  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  get a => null;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create:(context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => ReportProvider()),
      ],
      
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Accra Buyers Club',
        theme: ThemeData(
          fontFamily: 'Nunito',
          appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          ),
          inputDecorationTheme: const InputDecorationTheme(
              hintStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              prefixIconColor: Color.fromRGBO(120, 120, 120, 1)),
          textTheme: const TextTheme(
              titleLarge: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 35,
              ),
              titleMedium: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
              bodySmall: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              )),
          useMaterial3: true,
        ),
         home: const SplashScreen(
          child: HomePage()
        ),
      ),
    );
  }
}
