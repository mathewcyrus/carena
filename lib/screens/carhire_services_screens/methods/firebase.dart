import 'dart:typed_data';

import 'package:carena/firebasestorage/storage_methods.dart';
import 'package:carena/models/car_on_hire.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class CarhireFirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> registerCarforHire(
    String username,
    String uid,
    String priceperday,
    String carMake,
    String carModel,
    String location,
    String carVin,
    List<Uint8List> images,
  ) async {
    String res = "Failed to register your car";
    try {
      List<String> imagesurls = await Future.wait(
          [...images.map((image) => StorageMethods().uploadImage(image))]);

      String postId = const Uuid().v1();
      CarHire carHire = CarHire(
        username: username,
        uid: uid,
        postId: postId,
        priceperday: priceperday,
        dateposted: DateTime.now(),
        imagesurls: imagesurls,
        carMake: carMake,
        carModel: carModel,
        carVin: carVin,
        location: location,
        available: true,
        hiredDates: [],
      );

      _firestore.collection('registered_cars_for_hire').doc(postId).set(
            carHire.toJson(),
          );
      res = 'success';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<String> updateHiredCar(
    String username,
    String email,
    String uid,
    int numOfDays,
    String postId,
    List<Map<String, DateTime>> hiredDates,
  ) async {
    var res = "something went wrong";
    try {
      // Update the hiredDates array in the main car document
      await _firestore
          .collection('registered_cars_for_hire')
          .doc(postId)
          .update({
        'hiredDates': FieldValue.arrayUnion(hiredDates),
      });

      // Create a new document in the clientsWhoHired subcollection with the user's UID as the document ID
      await _firestore
          .collection('registered_cars_for_hire')
          .doc(postId)
          .collection('clientsWhoHired')
          .doc(uid)
          .set({
        'username': username,
        'email': email,
        'uid': uid,
        'numOfDays': numOfDays,
        'hiredDates': hiredDates,
        // Add other client-related information as needed
      });

      res = 'success';
    } catch (e) {}

    return res;
  }
}
