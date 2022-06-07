import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../screen.dart';

import '../../services/routing/routes.dart';

class SplashScreen extends StatefulWidget implements Screen {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();

  @override
  String get path => Routes.splash;
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        child: const Text('Splash Screen'),
      ),
    );
  }
}
