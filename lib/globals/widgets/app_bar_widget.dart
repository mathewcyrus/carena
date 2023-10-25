import 'package:carena/authentication/screens/login_screen.dart';
import 'package:carena/authentication/screens/registration_screen.dart';
import 'package:carena/globals/colors.dart';
import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      flexibleSpace: Container(
        height: 100.0,
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 2.0, color: Colors.white10),
          ),
        ),
      ),
      title: const Text("carena"),
      backgroundColor: darkmodecolor,
      actions: [
        IconButton(
          iconSize: 30.0,
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const UserRegistrationDetails(),
              ),
            );
          },
          icon: const Icon(Icons.light_mode_outlined),
        ),
        IconButton(
          iconSize: 30.0,
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const UserLogin(),
              ),
            );
          },
          icon: const Icon(Icons.account_circle_outlined),
        )
      ],
    );
  }
}
