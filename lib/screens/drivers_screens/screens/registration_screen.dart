import 'package:carena/globals/colors.dart';
import 'package:carena/globals/methods/flush_bar.dart';
import 'package:carena/providers/user_provider.dart';
import 'package:carena/screens/drivers_screens/methods/firebase.dart';
import 'package:flutter/material.dart';
import 'package:carena/authentication/widgets/input.dart';
import 'package:provider/provider.dart';
import 'package:carena/models/user.dart' as model;

class DriverRegScreen extends StatefulWidget {
  const DriverRegScreen({super.key});

  @override
  State<DriverRegScreen> createState() => _DriverRegScreenState();
}

class _DriverRegScreenState extends State<DriverRegScreen> {
  final TextEditingController _licenseTypeController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();

  final bool paid = true;
  bool isLoading = false;

  @override
  void dispose() {
    _licenseTypeController.dispose();
    _bioController.dispose();
    _countryController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    model.User user = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      appBar: AppBar(
          title: const Text("Driver registration"),
          backgroundColor: brandcolor,
          centerTitle: true,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(
                Icons.close,
                color: Colors.white,
              ),
            ),
          ]),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 70.0,
                      ),
                      UserInputField(
                        textInputType: TextInputType.text,
                        prefixicon: Icons.credit_card,
                        textEditingController: _licenseTypeController,
                        labeltext: "licence type",
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      UserInputField(
                        textInputType: TextInputType.text,
                        prefixicon: Icons.notes,
                        textEditingController: _bioController,
                        labeltext: "your driver's bio",
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      UserInputField(
                        textInputType: TextInputType.text,
                        prefixicon: Icons.flag,
                        textEditingController: _countryController,
                        labeltext: "Current country",
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      const UserInputField(
                        textInputType: TextInputType.text,
                        prefixicon: Icons.phone,
                        // textEditingController: _phoneController,
                        labeltext: "phonenumber",
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            height: 50.0,
                            width: double.infinity,
                            padding: const EdgeInsets.all(10.0),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(30.0),
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                "KES 2,000.00 / month",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      GestureDetector(
                        onTap: () async {
                          setState(() {
                            isLoading = true;
                          });
                          var res =
                              await DriversFirestoreMethods().registerDriver(
                            user.username,
                            user.uid,
                            user.phonenumber,
                            user.email,
                            _countryController.text,
                            user.profilephoto,
                            _licenseTypeController.text,
                            _bioController.text,
                          );
                          if (res == "success") {
                            showNotificationBar(
                              context,
                              "Registration successful!",
                              Icons.check,
                              brandcolor,
                            );

                            setState(() {
                              isLoading = false;
                            });
                          }

                          setState(() {
                            _bioController.text = "";
                            _countryController.text = "";
                            _licenseTypeController.text = "";
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            height: 50.0,
                            width: double.infinity,
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: paid ? brandcolor : Colors.white30,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                            child: Center(
                              child: isLoading
                                  ? const CircularProgressIndicator(
                                      color: Colors.white,
                                      value: 24.0,
                                    )
                                  : Text(
                                      "Register",
                                      style: TextStyle(
                                        color: paid
                                            ? Colors.white
                                            : Colors.white60,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 8.0,
                        ),
                        decoration: const BoxDecoration(
                          border: Border(
                            top: BorderSide(color: bordercolor, width: 0.4),
                          ),
                        ),
                        child: const Text(
                            "By subscribing, you agree to our Purchaser Terms of Service. Subscriptions auto-renew until canceled, as described in the Terms. Cancel anytime. A verified phone number is required to subscribe. If you've subscribed on another platform, manage your subscription through that platform."),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
