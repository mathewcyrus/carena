import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

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

  //add multiple images to storage

  // Future<List<String>> uploadMulipleImagesToStorage(
  //   String childName,
  //   List<Uint8List> postImages,
  // ) async {
  //   String id = const Uuid().v1();
  //   Reference ref = storage.ref().child(childName).child(id);

  //   print("size: ${postImages.length}");
  //   print("Uploading image to: ${ref.fullPath}");

  //   List<String> downloadUrls = await Future.wait(
  //       [...postImages.map((image) => uploadImage(ref, image))]);
  //   return downloadUrls;
  // }

  // Future<String> uploadImage(Reference ref, Uint8List image) async {
  //   UploadTask uploadTask = ref.putData(image);
  //   print(" new pic is ....$image");

  //   TaskSnapshot snap = await uploadTask;
  //   String downloadUrl = await snap.ref.getDownloadURL();
  //   print(" is a .... $downloadUrl");

  //   return downloadUrl;
  // }

  Future<String> uploadImage(Uint8List image) async {
    // Get a reference to the storage bucket.
    final FirebaseStorage storage = FirebaseStorage.instance;

    // Create a reference to the file to be uploaded.
    final Reference ref = storage.ref().child('posts/${const Uuid().v1()}');

    // Upload the image to Firebase Storage.
    final UploadTask uploadTask = ref.putData(image);

    // Wait for the upload to complete.
    final TaskSnapshot snap = await uploadTask.whenComplete(() => {});

    // Get the download URL for the uploaded image.
    final String downloadUrl = await snap.ref.getDownloadURL();

    return downloadUrl;
  }
}
