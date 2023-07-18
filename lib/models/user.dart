class User {
  final String username;
  final String profilephoto;
  final String email;
  final String password;
  final String uid;
  final String phonenumber;
  final String? bio;
  final String accounttype;
  final List? reviews;
  final List? ratings;
  final List? carphotos;
  final String? carplatenumber;
  final String? licensetype;
  final String? location;

  const User({
    required this.username,
    required this.profilephoto,
    required this.email,
    required this.password,
    required this.uid,
    required this.phonenumber,
    required this.accounttype,
    this.bio,
    this.reviews,
    this.ratings,
    this.carphotos,
    this.carplatenumber,
    this.licensetype,
    this.location,
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "profilephoto": profilephoto,
        "email": email,
        "password": password,
        "uid": uid,
        "phonenumber": phonenumber,
        "accounttype": accounttype,
        "bio": bio,
        "reviews": reviews,
        "ratings": ratings,
        "carphotos": carphotos,
        "carplatenumber": carplatenumber,
        "licensetype": licensetype,
        "location": location
      };
}
