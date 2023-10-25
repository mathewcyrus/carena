import 'package:carena/authentication/screens/login_screen.dart';
import 'package:carena/authentication/screens/registration_screen.dart';
import 'package:carena/layouts/mobile_screen_layout.dart';
import 'package:carena/layouts/responsive_screens.dart';
import 'package:carena/layouts/web_screen_layout.dart';
import 'package:carena/globals/widgets/images_view_page.dart';
import 'package:carena/messaging/screens/chat_page.dart';
import 'package:carena/models/car_on_hire.dart';
import 'package:carena/models/driver.dart';
import 'package:carena/screens/car_sale_Screens/screens/car_details_screen.dart';
import 'package:carena/screens/car_sale_Screens/screens/full_image_screen.dart';
import 'package:carena/screens/car_sale_Screens/screens/car_on_sale_comments_screen.dart';
import 'package:carena/screens/car_sale_Screens/screens/car_on_sale_post_page.dart';
import 'package:carena/screens/car_sale_Screens/screens/post_car_for_sale_screen.dart';
import 'package:carena/screens/carhire_services_screens/screens/carhire_details_screen.dart';
import 'package:carena/screens/carhire_services_screens/screens/registration_page.dart';
import 'package:carena/screens/drivers_screens/screens/drivers_profile.dart';
import 'package:carena/screens/drivers_screens/screens/rating_and_review_screen.dart';
import 'package:carena/screens/drivers_screens/screens/registration_screen.dart';
import 'package:carena/screens/drivers_screens/t_&_cs/termsandconditions.dart';
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
  static const String fullImagePage = '/singlepostpage/fullimagescreen';
  static const String addPost = '/addpost';
  static const String carHireDetailsPage = '/carhiredetials';
  static const String carHireRegistrationPage = '/carhireregistration';
  static const String imagesViewPage = '/imagesviewpage';
  static const String chatPage = '/chatpage';
  static const String termsAndConditions = '/termsandconditions';
  static const String driverRegistration =
      '/termsandconditions/driverregistration';

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
        final Driver driver = settings.arguments as Driver;
        return MaterialPageRoute(
          builder: (context) => DriverProfilePage(
            driver: driver,
          ),
        );
      case ratingAndReviewPage:
        final String driveruid = settings.arguments as String;
        return MaterialPageRoute(
          builder: (context) => RatingAndReviewPage(
            driveruid: driveruid,
          ),
        );
      case singlePostPage:
        final post = settings.arguments;
        return MaterialPageRoute(
          builder: (context) => CarSaleSinglePostPage(post: post),
        );
      case fullImagePage:
        final Map<String, dynamic> args =
            settings.arguments as Map<String, dynamic>;
        final List<dynamic> images = args['images'] ?? <String>[];
        final int currentImageIndex = args['currentImageIndex'] ?? 0;
        return MaterialPageRoute(
          builder: (context) => FullscreenImagePage(
            images: images,
            initialIndex: currentImageIndex,
          ),
        );

      case addPost:
        return MaterialPageRoute(
          builder: (context) => const PostPage(),
        );
      case singlePostCommentPage:
        final post = settings.arguments;
        return MaterialPageRoute(
          builder: (context) => OnsaleCommentScreen(post: post),
        );
      case singlePostDetailsPage:
        final carSpecs = settings.arguments as List<Map<String, dynamic>>;
        return MaterialPageRoute(
          builder: (context) => CarDetailsPage(carSpecifications: carSpecs),
        );
      case carHireDetailsPage:
        final Map<String, dynamic> args =
            settings.arguments as Map<String, dynamic>;
        final DateTime pickUpDate = args['pickupdate'];
        final DateTime returnDate = args['returndate'];
        final CarHire carHire = args['carHire'];

        return MaterialPageRoute(
          builder: (context) => CarHireDetailsPage(
            pickUpDate: pickUpDate,
            returnDate: returnDate,
            carHire: carHire,
          ),
        );
      case carHireRegistrationPage:
        return MaterialPageRoute(
          builder: (context) => const CarHireRegistrationPage(),
        );
      case imagesViewPage:
        final imagedetails = settings.arguments;
        return MaterialPageRoute(
          builder: (context) => ImagesViewPage(
            imagedetails: imagedetails,
          ),
        );
      case chatPage:
        return MaterialPageRoute(
          builder: (context) => const ChatHomePage(),
        );
      case termsAndConditions:
        return MaterialPageRoute(
          builder: (context) => const TermsAndConditions(),
        );
      case driverRegistration:
        return MaterialPageRoute(
          builder: (context) => const DriverRegScreen(),
        );

      default:
        throw const FormatException("Page not found");
    }
  }
}
