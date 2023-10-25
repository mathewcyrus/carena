import 'dart:typed_data';

import 'package:carena/firebasestorage/storage_methods.dart';
import 'package:carena/models/post.dart';
import 'package:carena/models/post_comment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> uploadAPost(
    String username,
    String profileImage,
    String uid,
    String postcaption,
    List<Uint8List> images,
    List<Map<String, dynamic>> carspecifications,
  ) async {
    String res = "Failed to upload your post";
    try {
      List<String> imagesurls = await Future.wait(
          [...images.map((image) => StorageMethods().uploadImage(image))]);

      String postId = const Uuid().v1();
      Post post = Post(
        username: username,
        profileImage: profileImage,
        uid: uid,
        postId: postId,
        postcaption: postcaption,
        dateposted: DateTime.now(),
        imagesurls: imagesurls,
        likes: [],
        shares: [],
        carspecifications: carspecifications,
      );

      _firestore.collection('posts').doc(postId).set(
            post.toJson(),
          );
      res = 'success';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<String> addComment(
    String username,
    String uid,
    String profilepicture,
    String postId,
    String postcomment,
  ) async {
    String res = "Failed to comment";
    try {
      String commentId = const Uuid().v1();
      Comment comment = Comment(
        username: username,
        uid: uid,
        profilepicture: profilepicture,
        comment: postcomment,
        postId: postId,
        datecommented: DateTime.now(),
      );

      _firestore
          .collection("posts")
          .doc(postId)
          .collection("comments")
          .doc(commentId)
          .set(
            comment.toJson(),
          );
    } catch (e) {
      res = e.toString();
    }

    return res;
  }

  Future<void> likePost(String postId, String uid, List likes) async {
    try {
      if (likes.contains(uid)) {
        await _firestore.collection("posts").doc(postId).update({
          "likes": FieldValue.arrayRemove([uid])
        });
      } else {
        await _firestore.collection("posts").doc(postId).update({
          "likes": FieldValue.arrayUnion([uid])
        });
      }
    } catch (e) {}
  }
}
