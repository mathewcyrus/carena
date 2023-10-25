import 'dart:typed_data';
import 'package:carena/authentication/methods/auth_methods.dart';
import 'package:carena/authentication/widgets/input.dart';
import 'package:carena/globals/colors.dart';
import 'package:carena/globals/methods/flush_bar.dart';
import 'package:carena/globals/methods/image_picker.dart';
import 'package:carena/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../layouts/mobile_screen_layout.dart';
import '../../layouts/responsive_screens.dart';
import '../../layouts/web_screen_layout.dart';

class UserRegistrationDetails extends StatefulWidget {
  const UserRegistrationDetails({Key? key}) : super(key: key);

  @override
  UserRegistrationDetailsState createState() => UserRegistrationDetailsState();
}

class UserRegistrationDetailsState extends State<UserRegistrationDetails> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  Uint8List? profileImage;
  bool isSigning = false;

  void pickImage() async {
    Uint8List? image = await imagePicker(
      ImageSource.gallery,
      isRegister: true,
    );

    setState(() {
      profileImage = image;
    });
  }

  void signUpUser(BuildContext context) async {
    setState(() {
      isSigning = true;
    });
    String res = await AuthMethods().signUpUser(
        email: _emailController.text,
        account: "regular",
        username: _usernameController.text,
        password: _passwordController.text,
        phonenumber: _phoneController.text,
        profilephoto: profileImage!);
    if (res != "success") {
      showNotificationBar(
        context,
        res,
        Icons.error,
        Colors.red,
      );
    } else {
      showNotificationBar(
        context,
        "signed up successfully",
        Icons.check,
        brandcolor,
      );
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
            mobileScreenlayout: MobileScreenlayout(),
            webScreenlayout: WebScreenlayout(),
          ),
        ),
      );
    }

    setState(() {
      isSigning = false;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 80.0,
        ),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // const SizedBox(
                    //   height: 100,
                    // ),
                    const Text(
                      "Carena",
                      style: TextStyle(fontSize: 45.0),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: SizedBox(
                        child: Stack(
                          children: [
                            profileImage != null
                                ? CircleAvatar(
                                    radius: 80.0,
                                    backgroundImage: MemoryImage(profileImage!),
                                  )
                                : const CircleAvatar(
                                    radius: 80.0,
                                    backgroundImage: NetworkImage(
                                        "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b5/Windows_10_Default_Profile_Picture.svg/2048px-Windows_10_Default_Profile_Picture.svg.png"),
                                  ),
                            Positioned(
                              bottom: 0.0,
                              right: 15.0,
                              child: IconButton(
                                onPressed: pickImage,
                                icon: const Icon(
                                  Icons.add_a_photo,
                                  size: 35.0,
                                  color: brandcolor,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    UserInputField(
                      textInputType: TextInputType.text,
                      prefixicon: Icons.person,
                      textEditingController: _usernameController,
                      labeltext: "username",
                    ),
                    const SizedBox(
                      height: 20.0,
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
                      height: 20.0,
                    ),
                    UserInputField(
                      textInputType: TextInputType.text,
                      prefixicon: Icons.phone,
                      textEditingController: _phoneController,
                      labeltext: "phonenumber",
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () => signUpUser(context),
                      child: Container(
                        height: 60, // Height of the container
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(color: brandcolor),
                        child: isSigning
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                            : const Center(
                                child: Text(
                                'Sign up',
                                style: TextStyle(fontSize: 20.0),
                              )),
                      ),
                    ),
                    const SizedBox(
                      height: 50.0,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Have an account already?",
                          style: TextStyle(fontSize: 18.0),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        InkWell(
                          onTap: () => Navigator.of(context)
                              .pushNamed(RouteManager.loginPage),
                          child: const Text(
                            "log in",
                            style: TextStyle(fontSize: 20.0, color: brandcolor),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
