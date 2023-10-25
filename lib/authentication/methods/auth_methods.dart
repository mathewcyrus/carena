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
        await _firestore.collection('all_Users').doc(currentUser.uid).get();

    return model.User.convertUserFromSnap(snap);
  }

  Future<String> signUpUser({
    required String email,
    required String username,
    required String account,
    required String password,
    required String phonenumber,
    required Uint8List profilephoto,
  }) async {
    String res = "some error occurred";
    try {
      if (email.isNotEmpty ||
          username.isNotEmpty ||
          password.isNotEmpty ||
          phonenumber.isNotEmpty) {
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
        DocumentReference userRef = _firestore.collection("all_Users").doc(
              credential.user!.uid,
            );

        model.User user = model.User(
          username: username,
          account: account,
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
          email: email,
          password: password,
        );
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

  Future<String> updateUser({
    required String uid,
    String? username,
    String? bio,
    String? email,
    String? phonenumber,
    Uint8List? profilephoto,
  }) async {
    String res = "Failed to update user";
    try {
      // Check if any fields are being updated
      if (username != null ||
          email != null ||
          bio != null ||
          phonenumber != null ||
          profilephoto != null) {
        // Create a reference to the user document in Firestore
        DocumentReference userRef = _firestore.collection("all_Users").doc(uid);

        // Fetch the existing user data
        DocumentSnapshot userSnapshot = await userRef.get();

        if (userSnapshot.exists) {
          // Convert the existing user data to a Map
          Map<String, dynamic> userData =
              userSnapshot.data() as Map<String, dynamic>;

          // Update the fields if provided
          if (username != null) {
            userData['username'] = username;
          }
          if (bio != null) {
            userData['bio'] = bio;
          }
          if (email != null) {
            userData['email'] = email;
          }
          if (phonenumber != null) {
            userData['phonenumber'] = phonenumber;
          }
          if (profilephoto != null) {
            String profileImageUrl =
                await StorageMethods().uploadAnImageToStorage(
              "profile_pictures",
              profilephoto,
            );
            userData['profilephoto'] = profileImageUrl;
          }

          // Update the user document in Firestore
          await userRef.set(userData);

          res = 'success';
        } else {
          res = 'User not found';
        }
      } else {
        res = 'No fields to update';
      }
    } catch (e) {
      res = e.toString();
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
