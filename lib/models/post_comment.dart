class Comment {
  final String username;
  final String uid;
  final String profilepicture;
  final String comment;
  final String postId;
  final DateTime datecommented;

  const Comment({
    required this.username,
    required this.uid,
    required this.profilepicture,
    required this.comment,
    required this.postId,
    required this.datecommented,
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "profilepicture": profilepicture,
        "comment": comment,
        "postId": postId,
        "datecommented": datecommented,
      };
}
