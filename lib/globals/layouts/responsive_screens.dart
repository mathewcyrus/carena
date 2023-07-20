import 'package:carena/globals/layouts/screen_dimensions.dart';
import 'package:carena/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResponsiveLayout extends StatefulWidget {
  final Widget mobileScreenlayout;
  final Widget webScreenlayout;
  const ResponsiveLayout(
      {super.key,
      required this.mobileScreenlayout,
      required this.webScreenlayout});

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  fetchUserData() async {
    UserProvider userprovider = Provider.of(context);
    await userprovider.refreshUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > webScreenSize) {
          //website layout version of the applications
          return widget.webScreenlayout;
        }
        //mobile layout version of the application
        return widget.mobileScreenlayout;
      },
    );
  }
}
