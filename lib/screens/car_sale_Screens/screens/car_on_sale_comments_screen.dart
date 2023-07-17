import 'package:carena/globals/colors.dart';
import 'package:carena/globals/data.dart';
import 'package:carena/screens/car_sale_Screens/widgets/comment_card.dart';
import 'package:carena/screens/car_sale_Screens/widgets/input_widget.dart';
import 'package:flutter/material.dart';

class OnsaleCommentScreen extends StatefulWidget {
  final dynamic post;
  const OnsaleCommentScreen({Key? key, this.post}) : super(key: key);

  @override
  State<OnsaleCommentScreen> createState() => _OnsaleCommentScreenState();
}

class _OnsaleCommentScreenState extends State<OnsaleCommentScreen> {
  final TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          appBar: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 2.0, color: Colors.white10),
                ),
              ),
            ),
            backgroundColor: darkmodecolor,
            title: Text(
              widget.post['name'],
              style: const TextStyle(fontSize: 16.0),
            ),
            actions: const [
              Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "view post",
                    style: TextStyle(color: brandcolor, fontSize: 18.0),
                  ),
                ),
              ),
            ],
          ),
          body: Column(
            children: [
              Flexible(
                child: ListView.builder(
                  reverse: true,
                  itemCount: comments.length,
                  itemBuilder: (context, index) {
                    final comment = comments[index];
                    return CommentCard(
                      comment: comment,
                    );
                  },
                ),
              ),
              UserInputField(
                  controller: _commentController,
                  sendicon: Icons.send,
                  fileicon: Icons.attach_file,
                  icon: Icons.comment_bank,
                  replyto: widget.post['username']),
            ],
          )),
    );
  }
}
