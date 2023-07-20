import 'package:carena/authentication/methods/auth_methods.dart';
import 'package:carena/authentication/screens/login_screen.dart';
import 'package:carena/globals/colors.dart';
import 'package:flutter/material.dart';

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
    return Drawer(
      width: 350.0,
      backgroundColor: darkmodecolor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/person7.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: ListView(
                children: [
                  Container(
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Emilia Clarke",
                          style: TextStyle(
                            fontSize: 24.0,
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.credit_card,
                              color: brandcolor,
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Text(
                              "class a\\n driver",
                              style:
                                  TextStyle(fontSize: 20.0, color: bordercolor),
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
                    ),
                  ),
                  const Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.person,
                              size: 35.0,
                            ),
                            SizedBox(
                              width: 20.0,
                            ),
                            Text(
                              "Profile",
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.settings,
                              size: 35.0,
                            ),
                            SizedBox(
                              width: 20.0,
                            ),
                            Text(
                              "Settings",
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.help_center,
                              size: 35.0,
                            ),
                            SizedBox(
                              width: 20.0,
                            ),
                            Text(
                              "Help Center",
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
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
          )
        ],
      ),
    );
  }
}
