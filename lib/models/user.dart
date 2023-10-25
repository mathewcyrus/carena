import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String username;
  String profilephoto;
  String email;
  String uid;
  String phonenumber;
  String? bio;
  String? account;

  User({
    required this.username,
    required this.profilephoto,
    required this.email,
    required this.account,
    required this.uid,
    required this.phonenumber,
    this.bio,
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "account": account,
        "profilephoto": profilephoto,
        "email": email,
        "uid": uid,
        "phonenumber": phonenumber,
        "bio": bio,
      };

  static User convertUserFromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
      username: snapshot['username'],
      profilephoto: snapshot['profilephoto'],
      account: snapshot['account'],
      email: snapshot['email'],
      uid: snapshot['uid'],
      phonenumber: snapshot['phonenumber'],
      bio: snapshot['bio'],
    );
  }
}
