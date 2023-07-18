import 'package:carena/authentication/methods/auth_methods.dart';
import 'package:carena/authentication/screens/registration_screen.dart';
import 'package:carena/authentication/widgets/input.dart';
import 'package:carena/globals/colors.dart';
import 'package:carena/globals/methods/flush_bar.dart';
import 'package:flutter/material.dart';

class UserLogin extends StatefulWidget {
  const UserLogin({super.key});

  @override
  State<UserLogin> createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isloggingin = false;

  void logInUser(BuildContext context) async {
    setState(() {
      isloggingin = true;
    });
    String res = await AuthMethods().logInUser(
      email: _emailController.text,
      password: _passwordController.text,
    );

    if (res != "success") {
      showNotificationBar(context, res, Icons.error, Colors.red);
    } else {
      showNotificationBar(
          context, "logged in succesfully ", Icons.check, brandcolor);
    }
    setState(() {
      isloggingin = false;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkmodecolor,
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            Flexible(
              flex: 1,
              child: Container(),
            ),
            const Text(
              "Carena",
              style: TextStyle(fontSize: 45.0),
            ),
            const SizedBox(
              height: 50.0,
            ),
            UserInputField(
              textInputType: TextInputType.emailAddress,
              prefixicon: Icons.email,
              textEditingController: _emailController,
              labeltext: "email",
            ),
            const SizedBox(
              height: 20.0,
            ),
            UserInputField(
              textInputType: TextInputType.text,
              prefixicon: Icons.visibility,
              textEditingController: _passwordController,
              ispass: true,
              labeltext: "password",
            ),
            const SizedBox(
              height: 60.0,
            ),
            GestureDetector(
              onTap: () => logInUser(context),
              child: Container(
                height: 60, // Height of the container
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(color: brandcolor),
                child: isloggingin
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      )
                    : const Center(
                        child: Text(
                        'Log in',
                        style: TextStyle(fontSize: 20.0),
                      )),
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't have an account?",
                  style: TextStyle(fontSize: 18.0),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                InkWell(
                  onTap: () => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const UserRegistrationDetails(),
                    ),
                  ),
                  child: const Text(
                    "sign up",
                    style: TextStyle(fontSize: 20.0, color: brandcolor),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 50.0,
            )
          ],
        ),
      ),
    );
  }
}
