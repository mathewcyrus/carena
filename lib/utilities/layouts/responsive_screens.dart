import 'package:carena/utilities/layouts/screen_dimensions.dart';
import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobileScreenlayout;
  final Widget webScreenlayout;
  const ResponsiveLayout(
      {super.key,
      required this.mobileScreenlayout,
      required this.webScreenlayout});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > webScreenSize) {
        //website layout version of the applications
        return webScreenlayout;
      }
      //mobile layout version of the application
      return mobileScreenlayout;
    });
  }
}
