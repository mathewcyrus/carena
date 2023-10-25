import 'package:carena/globals/colors.dart';
import 'package:carena/models/user.dart' as model;
import 'package:skeletonizer/skeletonizer.dart';
import 'package:carena/providers/user_provider.dart';
import 'package:carena/screens/car_sale_Screens/methods/firestore_methods.dart';
import 'package:carena/screens/car_sale_Screens/widgets/comment_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OnsaleCommentScreen extends StatefulWidget {
  final dynamic post;
  const OnsaleCommentScreen({Key? key, this.post}) : super(key: key);

  @override
  State<OnsaleCommentScreen> createState() => _OnsaleCommentScreenState();
}

class _OnsaleCommentScreenState extends State<OnsaleCommentScreen> {
  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    model.User user = Provider.of<UserProvider>(context).getUser;

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
            widget.post['username'],
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
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("posts")
                    .doc(widget.post['postId'])
                    .collection('comments')
                    .orderBy('datecommented', descending: true)
                    .snapshots(),
                builder: (
                  context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot,
                ) {
                  return Skeletonizer(
                    enabled:
                        snapshot.connectionState == ConnectionState.waiting,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final comment = snapshot.data!.docs[index].data();
                        return CommentCard(
                          comment: comment,
                        );
                      },
                    ),
                  );
                },
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(
                    width: 0.2,
                    color: bordercolor,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _commentController,
                      maxLines: null,
                      cursorColor: brandcolor,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.comment_bank,
                          size: 35.0,
                          color: brandcolor,
                        ),
                        hintText: "reply to ${widget.post['username']}",
                        hintStyle: const TextStyle(fontSize: 17.0),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.attach_file,
                        size: 35.0,
                      )),
                  const SizedBox(width: 10.0),
                  IconButton(
                    onPressed: () async {
                      await FirestoreMethods().addComment(
                        user.username,
                        user.uid,
                        user.profilephoto,
                        widget.post['postId'],
                        _commentController.text,
                      );

                      setState(() {
                        _commentController.text = "";
                      });
                    },
                    icon: const Icon(
                      Icons.send,
                      size: 35.0,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
