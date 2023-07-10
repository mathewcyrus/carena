import 'package:carena/utilities/colors.dart';
import 'package:carena/utilities/layouts/mobile_screen_layout.dart';
import 'package:carena/utilities/layouts/responsive_screens.dart';
import 'package:carena/utilities/layouts/web_screen_layout.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Carena',
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: darkmodecolor),
      home: const ResponsiveLayout(
        mobileScreenlayout: MobileScreenlayout(),
        webScreenlayout: WebScreenlayout(),
      ),
    );
  }
}
