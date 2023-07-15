import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flood_app/auth/auth.dart';
import 'package:flood_app/pages/notifications.dart';
import 'package:flood_app/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // theme: lightTheme,
      // darkTheme: darkTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => SplashPage(),
        '/home': (context) => AuthPage(),
      },
    );
  }
}
