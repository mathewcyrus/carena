import 'package:flutter/material.dart';
import 'package:carena/screens/car_sale_Screens/screens/car_details_screen.dart';
import 'package:carena/screens/car_sale_Screens/screens/car_on_sale_comments_screen.dart';

void navigateToScreens(String screen, BuildContext context, dynamic post) {
  if (screen == "details") {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const CarDetailsPage()),
    );
  } else if (screen == "comment") {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => OnsaleCommentScreen(post: post)),
    );
  }
}
