import 'package:carena/models/reviewandratings.dart';

class Driver {
  final String driverusername;
  final String driveruid;
  final String phonenumber;
  final String email;
  final String location;
  final String profileImage;
  final String licensetype;
  final String driversbio;
  bool? available = true;
  List<RatingAndReview>? reviewandrating = [];

  Driver({
    required this.driverusername,
    required this.driveruid,
    required this.location,
    required this.phonenumber,
    required this.email,
    required this.profileImage,
    required this.licensetype,
    required this.available,
    required this.driversbio,
    required this.reviewandrating,
  });

  Map<String, dynamic> toJson() => {
        "driverusername": driverusername,
        "driveruid": driveruid,
        "location": location,
        "phonenumber": phonenumber,
        "email": email,
        "profileImage": profileImage,
        "licensetype": licensetype,
        "driversbio": driversbio,
        "available": available,
        "reviewandrating": reviewandrating,
      };

  Driver.fromJson(Map<String, dynamic> json)
      : driverusername = json['driverusername'],
        driveruid = json['driveruid'],
        phonenumber = json['phonenumber'],
        email = json['email'],
        location = json['location'],
        profileImage = json['profileImage'],
        licensetype = json['licensetype'],
        driversbio = json['driversbio'],
        available = json['available'],
        reviewandrating = (json['reviewandrating'] as List<dynamic>?)
            ?.map((item) => RatingAndReview.fromJson(item))
            .toList();
}
