import 'package:carena/authentication/screens/login_screen.dart';
import 'package:carena/providers/user_provider.dart';
import 'package:carena/routes/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
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
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Carena',
        theme:
            ThemeData.dark().copyWith(scaffoldBackgroundColor: darkmodecolor),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return const ResponsiveLayout(
                  mobileScreenlayout: MobileScreenlayout(),
                  webScreenlayout: WebScreenlayout(),
                );
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text("An error Ocurred"),
                );
              }
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator(
                color: Colors.white,
              );
            }
            return const UserLogin();
          },
        ),
        onGenerateRoute: RouteManager.generateRoute,
      ),
    );
  }
}
