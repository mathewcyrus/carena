class TaxiDriver {
  final String driverusername;
  final String driveruid;
  final String phonenumber;
  final String email;
  final String location;
  final String profileImage;
  int rides = 0;
  final String driversbio;
  final List<Map<String, dynamic>> reviewandrating;
  final List<String> vehicleimages;
  final List<String> vin;

  TaxiDriver({
    required this.driverusername,
    required this.driveruid,
    required this.location,
    required this.phonenumber,
    required this.email,
    required this.profileImage,
    required this.rides,
    required this.driversbio,
    required this.vehicleimages,
    required this.vin,
    required this.reviewandrating,
  });

  Map<String, dynamic> toJson() => {
        "driverusername": driverusername,
        "driveruid": driveruid,
        "location": location,
        "phonenumber": phonenumber,
        "email": email,
        "profileImage": profileImage,
        "vin": vin,
        "rides": rides,
        "driversbio": driversbio,
        "reviewandrating": reviewandrating,
      };
}
