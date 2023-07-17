import 'package:firebase_database/firebase_database.dart';
import 'package:flood_app/auth/auth.dart';
import 'package:flood_app/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'firebase_options.dart';

FlutterLocalNotificationsPlugin notificationsPlugin = FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseDatabase.instance.setPersistenceEnabled(true);

  final scoresRef = FirebaseDatabase.instance.ref("scores");
  scoresRef.keepSynced(true);

  AndroidInitializationSettings androidSettings = const AndroidInitializationSettings("@mipmap/splash");

  DarwinInitializationSettings iosSettings = const DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestCriticalPermission: true,
    requestSoundPermission: true
  );

  InitializationSettings initializationSettings = InitializationSettings(
    android: androidSettings,
    iOS: iosSettings
  );

  bool? initialized = await notificationsPlugin.initialize(
    initializationSettings
  );

  print("Notificaitons: $initialized");

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
