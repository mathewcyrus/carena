import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String username;
  final String profilephoto;
  final String email;
  final String uid;
  final String phonenumber;
  final String? bio;

  const User({
    required this.username,
    required this.profilephoto,
    required this.email,
    required this.uid,
    required this.phonenumber,
    this.bio,
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "profilephoto": profilephoto,
        "email": email,
        "uid": uid,
        "phonenumber": phonenumber,
        "bio": bio,
      };

  static User convertUserFromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
        username: snap['username'],
        profilephoto: snap['profilephoto'],
        email: snap['email'],
        uid: snap['uid'],
        phonenumber: snap['phonenumber'],
        bio: snapshot['bio']);
  }
}
