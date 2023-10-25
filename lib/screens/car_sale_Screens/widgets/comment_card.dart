import 'package:flutter/material.dart';

class CommentCard extends StatelessWidget {
  final dynamic comment;
  const CommentCard({
    Key? key,
    this.comment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(comment['profilepicture']),
      ),
      title: Text(comment['username']),
      subtitle: Text(comment['comment']),
    );
  }
}
