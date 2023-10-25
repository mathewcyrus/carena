import 'package:carena/globals/colors.dart';
import 'package:carena/providers/user_provider.dart';
import 'package:carena/routes/routes.dart';
import 'package:carena/models/user.dart' as model;

import 'package:carena/screens/car_sale_Screens/methods/firestore_methods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LikesAndCommentsBar extends StatefulWidget {
  final dynamic post;
  final String type;
  const LikesAndCommentsBar(
      {super.key, required this.post, this.type = "normal"});

  @override
  State<LikesAndCommentsBar> createState() => _LikesAndCommentsBarState();
}

class _LikesAndCommentsBarState extends State<LikesAndCommentsBar>
    with TickerProviderStateMixin {
  bool isLiked = false;
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;
  int _commentsLength = 0;

  @override
  void initState() {
    super.initState();
    model.User user = Provider.of<UserProvider>(context, listen: false).getUser;
    isLiked = widget.post['likes']!.contains(user.uid);
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _rotationAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    ));
  }

  void handleLikePressed() async {
    _controller.reset();
    await _controller.forward();

    // Handle like/unlike logic here
    setState(() {
      isLiked = !isLiked;
    });

    // You can also call your like/unlike function here if needed
  }

  @override
  Widget build(BuildContext context) {
    model.User user = Provider.of<UserProvider>(context).getUser;
    CollectionReference<Map<String, dynamic>> comments = FirebaseFirestore
        .instance
        .collection("posts")
        .doc(widget.post['postId'])
        .collection('comments');

    comments.get().then((querySnapshot) {
      int commentsCount = querySnapshot.size;
      setState(() {
        _commentsLength = commentsCount;
      });
    });

    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            child: Row(
              children: [
                InkWell(
                  onTap: () async {
                    handleLikePressed();
                    await FirestoreMethods().likePost(
                      widget.post["postId"],
                      user.uid,
                      widget.post['likes'],
                    );
                  },
                  child: AnimatedBuilder(
                    animation: _rotationAnimation,
                    builder: (context, child) {
                      return Transform.rotate(
                        angle: _rotationAnimation.value * (2 * 3.14159265359),
                        child: child,
                      );
                    },
                    child: Icon(
                      isLiked ? Icons.favorite : Icons.favorite_border,
                      size: 28.0,
                      color: isLiked ? brandcolor : null,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Text(
                  '${widget.post['likes']!.length}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          InkWell(
            onTap: () => Navigator.of(context).pushNamed(
              RouteManager.singlePostCommentPage,
              arguments: widget.post,
            ),
            child: Row(
              children: [
                const Icon(
                  size: 26.0,
                  Icons.comment_bank,
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Text(
                  "$_commentsLength",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          InkWell(
            onTap: () => Navigator.of(context).pushNamed(
              RouteManager.singlePostDetailsPage,
              arguments: (widget.post['carSpecifications'] as List)
                  .cast<Map<String, dynamic>>(),
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.more_horiz,
                  size: 26.0,
                ),
              ],
            ),
          ),
          const InkWell(
            child: Row(
              children: [
                Icon(
                  Icons.share,
                  color: brandcolor,
                  size: 26.0,
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  "700",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
