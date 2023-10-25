import 'package:carena/models/driver.dart';
import 'package:carena/models/reviewandratings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class DriversFirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> registerDriver(
    final String driverusername,
    final String driveruid,
    final String phonenumber,
    final String email,
    final String location,
    final String profileImage,
    final String licensetype,
    final String driversbio,
  ) async {
    String res = "Failed to upload your post";
    try {
      Driver driver = Driver(
        driverusername: driverusername,
        driveruid: driveruid,
        location: location,
        phonenumber: phonenumber,
        email: email,
        profileImage: profileImage,
        licensetype: licensetype,
        driversbio: driversbio,
        available: true,
        reviewandrating: [],
      );

      await _firestore.collection('drivers').doc(driveruid).set(
            driver.toJson(),
          );
      res = 'success';
    } catch (e) {}

    return res;
  }

  Future<List<Driver>> getAllDrivers() async {
    try {
      var driverCollection = _firestore.collection("drivers");
      var querySnapshot = await driverCollection.get();

      List<Driver> drivers = [];

      for (var doc in querySnapshot.docs) {
        var driverData = doc.data();
        var driver = Driver.fromJson(driverData);
        drivers.add(driver);
      }

      return drivers;
    } catch (e) {
      return [];
    }
  }

  Future<String> reviewAndRateDriver(
    final String username,
    final String useruid,
    final String profileImage,
    final String driveruid,
    final String review,
    final double rating,
    final DateTime reviewdate,
  ) async {
    var res = "success";
    try {
      String reviewUid = const Uuid().v1();

      RatingAndReview ratingandreview = RatingAndReview(
        username: username,
        useruid: useruid,
        driveruid: driveruid,
        profileImage: profileImage,
        review: review,
        rating: rating,
        uid: reviewUid,
        reviewdate: reviewdate,
      );
      await _firestore
          .collection("drivers")
          .doc(driveruid)
          .collection("reviewsandratings")
          .doc(reviewUid)
          .set(
            ratingandreview.toJson(),
          );

      res = "success";
    } catch (e) {}
    return res;
  }

  Future<List<RatingAndReview>> getAllReviewsAndRatings(
    final String driveruid,
  ) async {
    try {
      var ratingAndReviewCollection = _firestore
          .collection("drivers")
          .doc(driveruid)
          .collection("reviewsandratings");
      var querySnapshot = await ratingAndReviewCollection.get();

      List<RatingAndReview> ratingsandreviews = [];

      for (var doc in querySnapshot.docs) {
        var reviewsAndRatingsData = doc.data();
        var driver = RatingAndReview.fromJson(reviewsAndRatingsData);
        ratingsandreviews.add(driver);
      }

      return ratingsandreviews;
    } catch (e) {
      return [];
    }
  }
}
