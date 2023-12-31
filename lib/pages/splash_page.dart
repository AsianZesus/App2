import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flood_app/auth/auth.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logo: Image.asset(
          'assets/images/splash.png',),
      backgroundColor: Colors.black,
      showLoader: false,
      navigator: const AuthPage(),
      durationInSeconds: 2,
    );
  }
}