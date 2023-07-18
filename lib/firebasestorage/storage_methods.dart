import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageMethods {
  final FirebaseStorage storage = FirebaseStorage.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  //add an image to firebase
  Future<String> uploadAnImageToStorage(
    String childName,
    Uint8List profileImage,
  ) async {
    Reference ref = storage.ref().child(childName).child(auth.currentUser!.uid);
    UploadTask uploadTask = ref.putData(profileImage);

    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }
}
