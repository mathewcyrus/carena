import 'package:cloud_firestore/cloud_firestore.dart';

class CarHire {
  final String username;
  final String uid;
  final String postId;
  final DateTime dateposted;
  final String priceperday;
  final List<String> imagesurls;
  final String carMake;
  final String carModel;
  final String carVin;
  final String location;
  bool available = true;
  List<Map<String, DateTime>> hiredDates = [];

  CarHire({
    required this.username,
    required this.uid,
    required this.postId,
    required this.dateposted,
    required this.priceperday,
    required this.imagesurls,
    required this.carMake,
    required this.carModel,
    required this.carVin,
    required this.location,
    required this.available,
    required this.hiredDates,
  });

  factory CarHire.fromJson(Map<String, dynamic> json) {
    return CarHire(
      username: json['username'] as String,
      uid: json['uid'] as String,
      postId: json['postId'] as String,
      priceperday: json['priceperday'] as String,
      dateposted: (json['dateposted']).toDate(),
      imagesurls: (json['imagesurls'] as List).map((e) => e as String).toList(),
      carMake: json['carMake'] as String,
      carModel: json['carModel'] as String,
      carVin: json['carVin'] as String,
      location: json['location'] as String,
      available: json['available'] as bool,
      hiredDates: (json['hiredDates'] as List).map((e) {
        final Map<String, dynamic> dateRange = e as Map<String, dynamic>;
        final DateTime pickupDate =
            (dateRange['pickupDate'] as Timestamp).toDate();
        final DateTime returnDate =
            (dateRange['returnDate'] as Timestamp).toDate();

        return {
          'pickupDate': pickupDate,
          'returnDate': returnDate,
        };
      }).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "postId": postId,
        "dateposted": dateposted,
        "priceperday": priceperday,
        "imagesurls": imagesurls,
        "carModel": carModel,
        "carMake": carMake,
        "carVin": carVin,
        "location": location,
        "available": available,
        "hiredDates": hiredDates,
      };

  bool isBooked(DateTime pickUpDate, DateTime returnDate) {
    for (final dateRange in hiredDates) {
      final DateTime pickupDate = dateRange['pickupDate']!;
      final DateTime bookedReturnDate = dateRange['returnDate']!;

      if (pickUpDate.isBefore(bookedReturnDate) &&
          returnDate.isAfter(pickupDate)) {
        return true; // There is an overlap, so the car is booked
      }
    }

    return false;
  }
}
