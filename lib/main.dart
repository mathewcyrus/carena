import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:carena/globals/colors.dart';
import 'package:carena/globals/layouts/mobile_screen_layout.dart';
import 'package:carena/globals/layouts/responsive_screens.dart';
import 'package:carena/globals/layouts/web_screen_layout.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
