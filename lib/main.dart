import 'package:flutter/material.dart';
import 'package:verify_feild_worker/Login_page.dart';
import 'package:verify_feild_worker/routes.dart';
import 'package:verify_feild_worker/splash.dart';

import 'Home_Screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        /* light theme settings */
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: Splash.route,
      routes:
      Routes.routes,
      /*theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: Login_page(),*/
    );
  }
}
