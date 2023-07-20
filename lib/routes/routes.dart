import 'package:carena/authentication/screens/login_screen.dart';
import 'package:carena/authentication/screens/registration_screen.dart';
import 'package:carena/globals/layouts/mobile_screen_layout.dart';
import 'package:carena/globals/layouts/responsive_screens.dart';
import 'package:carena/globals/layouts/web_screen_layout.dart';
import 'package:carena/screens/car_sale_Screens/screens/car_details_screen.dart';
import 'package:carena/screens/car_sale_Screens/screens/car_on_sale_comments_screen.dart';
import 'package:carena/screens/car_sale_Screens/screens/car_on_sale_post_page.dart';
import 'package:carena/screens/drivers_screens/screens/drivers_profile.dart';
import 'package:carena/screens/drivers_screens/screens/rating_and_review_screen.dart';
import 'package:flutter/material.dart';

class RouteManager {
  static const String mainPage = '/';
  static const String loginPage = '/loginpage';
  static const String settingsPage = '/settingspage';
  static const String signupPage = '/signuppage';
  static const String profilePage = '/profilepage';
  static const String ratingAndReviewPage = '/profilepage/ratingandreviewpage';
  static const String singlePostPage = '/singlepostpage';
  static const String singlePostCommentPage = '/singlepostCommentpage';
  static const String singlePostDetailsPage = '/singlepostdetailspage';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case mainPage:
        return MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
            mobileScreenlayout: MobileScreenlayout(),
            webScreenlayout: WebScreenlayout(),
          ),
        );
      case loginPage:
        return MaterialPageRoute(
          builder: (context) => const UserLogin(),
        );
      case settingsPage:
        return MaterialPageRoute(
          builder: (context) => const UserLogin(),
        );
      case signupPage:
        return MaterialPageRoute(
          builder: (context) => const UserRegistrationDetails(),
        );
      case profilePage:
        return MaterialPageRoute(
          builder: (context) => const DriverProfilePage(),
        );
      case ratingAndReviewPage:
        return MaterialPageRoute(
          builder: (context) => const RatingAndReviewPage(),
        );
      case singlePostPage:
        final post = settings.arguments;
        return MaterialPageRoute(
          builder: (context) => CarSaleSinglePostPage(post: post),
        );
      case singlePostCommentPage:
        final post = settings.arguments;
        return MaterialPageRoute(
          builder: (context) => OnsaleCommentScreen(post: post),
        );
      case singlePostDetailsPage:
        return MaterialPageRoute(
          builder: (context) => const CarDetailsPage(),
        );

      default:
        throw const FormatException("Page not found");
    }
  }
}
