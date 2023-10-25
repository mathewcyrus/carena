// ignore_for_file: use_build_context_synchronously
import 'package:carena/models/user.dart' as model;

import 'package:carena/authentication/methods/auth_methods.dart';
import 'package:carena/authentication/screens/login_screen.dart';
import 'package:carena/globals/colors.dart';
import 'package:carena/providers/user_provider.dart';
import 'package:carena/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  bool isloggingout = false;

  void logOutUser() async {
    setState(() {
      isloggingout = true;
    });

    await AuthMethods().logOutUser();

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const UserLogin(),
      ),
    );
    setState(() {
      isloggingout = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    model.User? user = Provider.of<UserProvider>(context).getUser;

    return Drawer(
      width: 350.0,
      backgroundColor: Colors.black,
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DrawerHeader(
                margin: const EdgeInsets.all(0.0),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(user.profilephoto),
                    fit: BoxFit.contain,
                  ),
                ),
                child: Container(),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: ListView(
                    children: [
                      SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user.username,
                              style: const TextStyle(
                                fontSize: 24.0,
                              ),
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            const Row(
                              children: [
                                Icon(
                                  Icons.credit_card,
                                  color: bordercolor,
                                  size: 35.0,
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Text(
                                  "Class a\\n driver",
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    color: brandcolor,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 5.0),
                        child: Divider(
                          thickness: 0.2,
                          color: bordercolor,
                        ),
                      ),
                      const Column(
                        children: [
                          DrawerCard(
                            icon: Icons.person,
                            text: 'Profile',
                          ),
                          DrawerCard(
                            icon: Icons.settings,
                            text: 'Settings',
                          ),
                          DrawerCard(
                            icon: Icons.credit_card,
                            text: 'Upgrade your account',
                          ),
                          DrawerCard(
                            icon: Icons.help_center,
                            text: 'Help Center',
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 5.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Your Services',
                              style: TextStyle(
                                fontSize: 20.0,
                                color: brandcolor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Divider(
                              thickness: 0.2,
                              color: bordercolor,
                            ),
                            DrawerCard(
                              icon: Icons.local_taxi,
                              text: 'Taxi Driver',
                              type: "subscribed",
                            ),
                            DrawerCard(
                              icon: Icons.miscellaneous_services,
                              text: 'Mechanic',
                            ),
                            DrawerCard(
                              icon: Icons.safety_divider_sharp,
                              text: 'Driver',
                              type: "subscribed",
                            ),
                            DrawerCard(
                              icon: Icons.local_taxi,
                              text: 'Car Seller',
                            ),
                            DrawerCard(
                              icon: Icons.local_taxi,
                              text: 'Car Seller',
                            ),
                            DrawerCard(
                              icon: Icons.local_taxi,
                              text: 'Car Seller',
                            ),
                            DrawerCard(
                              icon: Icons.local_taxi,
                              text: 'Car Seller',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          Positioned(
            bottom: 0.0,
            child: Container(
              width: 350.0,
              height: 70.0,
              color: Colors.black,
              child: Column(
                children: [
                  const Divider(
                    thickness: 0.2,
                    color: bordercolor,
                  ),
                  SizedBox(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () => logOutUser(),
                          child: isloggingout
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Row(
                                  children: [
                                    Icon(
                                      Icons.logout,
                                      color: brandcolor,
                                      size: 35.0,
                                    ),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    Text(
                                      "Log out",
                                      style: TextStyle(fontSize: 20.0),
                                    ),
                                  ],
                                ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DrawerCard extends StatelessWidget {
  final IconData icon;
  final String text;
  final String? type;
  const DrawerCard({
    super.key,
    required this.icon,
    required this.text,
    this.type,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          Navigator.of(context).pushNamed(RouteManager.termsAndConditions),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        child: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    size: 35.0,
                    color: bordercolor,
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Text(
                    text,
                    style: const TextStyle(fontSize: 18.0),
                  ),
                ],
              ),
            ),
            if (type == "subscribed")
              const Positioned(
                right: 0.0,
                child: Icon(
                  Icons.check,
                  size: 35.0,
                  color: brandcolor,
                ),
              )
          ],
        ),
      ),
    );
  }
}
