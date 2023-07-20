import 'dart:typed_data';
import 'package:carena/firebasestorage/storage_methods.dart';
import 'package:carena/models/user.dart' as model;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snap =
        await _firestore.collection('all_users').doc(currentUser.uid).get();

    print(snap);
    return model.User.convertUserFromSnap(snap);
  }

  Future<String> signUpUser({
    required String email,
    required String username,
    required String password,
    required String phonenumber,
    required Uint8List profilephoto,
  }) async {
    String res = "some error occurred";
    try {
      if (email.isNotEmpty ||
          username.isNotEmpty ||
          password.isNotEmpty ||
          phonenumber.isNotEmpty ||
          profilephoto != null) {
        // Register user to auth database
        UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        //save profile image to firebasestorage
        String profileImageUrl = await StorageMethods().uploadAnImageToStorage(
          "profile_pictures",
          profilephoto,
        );

        // Create a reference to the user document
        DocumentReference userRef =
            _firestore.collection("all_Users").doc(credential.user!.uid);

        model.User user = model.User(
          username: username,
          profilephoto: profileImageUrl,
          email: email,
          uid: credential.user!.uid,
          phonenumber: phonenumber,
        );
        // Add user data to the "all users" subcollection
        await userRef.set(
          user.toJson(),
        );

        res = 'success';
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        res = "invalid email";
      } else if (e.code == 'weak-password') {
        res = "password should be atleast 6 characters";
      } else {
        res = 'server error';
      }
    }
    return res;
  }

  Future<String> logInUser({
    required String email,
    required String password,
  }) async {
    String res = 'network error';
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = 'success';
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        res = 'User not found';
      } else if (e.code == 'wrong-password') {
        res = 'Wrong password';
      } else if (e.code == 'invalid-email') {
        res = 'Invalid email';
      } else {
        res = 'Login failed';
      }
    }
    return res;
  }

  Future<String> logOutUser() async {
    String res = 'error occurred';
    try {
      await _auth.signOut();
      res = 'success';
    } catch (e) {
      res = 'Logout failed';
    }
    return res;
  }
}
