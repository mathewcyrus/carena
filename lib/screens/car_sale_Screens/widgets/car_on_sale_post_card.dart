import 'package:carena/globals/colors.dart';
import 'package:carena/models/user.dart' as model;
import 'package:carena/providers/user_provider.dart';

import 'package:carena/routes/routes.dart';
import 'package:carena/screens/car_sale_Screens/methods/firestore_methods.dart';
import 'package:carena/screens/car_sale_Screens/screens/profile/car_seller_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CarSalePost extends StatefulWidget {
  final dynamic post;

  const CarSalePost({
    required this.post,
    Key? key,
  }) : super(key: key);

  @override
  State<CarSalePost> createState() => _CarSalePostState();
}

class _CarSalePostState extends State<CarSalePost>
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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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

  Map<String, String?> getPriceAndModel(
      List<Map<String, dynamic>> carSpecifications) {
    String? price;
    String? model;

    for (final specification in carSpecifications) {
      if (specification['label'] == 'Price') {
        price = specification['value'] as String?;
      } else if (specification['label'] == 'Model') {
        model = specification['value'] as String?;
      }
    }

    return {'price': price, 'model': model};
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

    List<Map<String, dynamic>> carSpecifications =
        (widget.post['carSpecifications'] as List).cast<Map<String, dynamic>>();

    Map<String, String?> info = getPriceAndModel(carSpecifications);
    String? price = info['price'];
    String? carmodel = info['model'];

    void navigateToPostScreen() => Navigator.of(context).pushNamed(
          RouteManager.singlePostPage,
          arguments: widget.post,
        );

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.white10,
            width: 2.0,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: InkWell(
              onTap: navigateToPostScreen,
              child: Container(
                width: double.infinity,
                height: 230.0,
                color: Colors.grey,
                child: GestureDetector(
                    onTap: navigateToPostScreen,
                    child: Image.network(
                      widget.post['imagesurls'][0]!,
                      fit: BoxFit.cover,
                    )),
              ),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CarSellerProfilePage(
                    userUid: widget.post['uid'],
                  ),
                ),
              );
            },
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 0.0, vertical: 10.0),
            leading: CircleAvatar(
              radius: 30.0,
              backgroundImage: NetworkImage(widget.post['profileimage']),
            ),
            title: Text(widget.post['username']),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(carmodel!),
                Text(
                  "$price ksh",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            trailing: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_vert),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 75.0, bottom: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.post['postcaption'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                  ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Text(DateFormat.yMMMd()
                    .format(widget.post['dateposted'].toDate()))
              ],
            ),
          ),
          Padding(
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
                              angle: _rotationAnimation.value *
                                  (2 * 3.14159265359),
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
          )
        ],
      ),
    );
  }
}
