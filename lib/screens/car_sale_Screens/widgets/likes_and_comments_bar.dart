import 'package:carena/routes/routes.dart';
import 'package:carena/screens/car_sale_Screens/screens/car_details_screen.dart';
import 'package:carena/screens/car_sale_Screens/screens/car_on_sale_comments_screen.dart';
import 'package:flutter/material.dart';

class LikesAndCommentsBar extends StatefulWidget {
  final dynamic post;
  final String type;
  const LikesAndCommentsBar(
      {super.key, required this.post, this.type = "normal"});

  @override
  State<LikesAndCommentsBar> createState() => _LikesAndCommentsBarState();
}

class _LikesAndCommentsBarState extends State<LikesAndCommentsBar> {
  @override
  Widget build(BuildContext context) {
    void navigateToScreens(
      String screen,
    ) {
      if (screen == "comments") {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => OnsaleCommentScreen(
            post: widget.post,
          ),
        ));
      } else if (screen == "details") {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const CarDetailsPage(),
        ));
      }
    }

    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const InkWell(
            child: Row(
              children: [
                Icon(Icons.favorite_border),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  "2k",
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          InkWell(
            onTap: () => Navigator.of(context).pushNamed(
              RouteManager.singlePostCommentPage,
              arguments: widget.post,
            ),
            child: const Row(
              children: [
                Icon(Icons.comment_bank),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  "200",
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          InkWell(
            onTap: () => Navigator.of(context)
                .pushNamed(RouteManager.singlePostDetailsPage),
            child: const Row(
              children: [
                Icon(Icons.more_horiz),
              ],
            ),
          ),
          const InkWell(
            child: Row(
              children: [
                Icon(Icons.share),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  "750",
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
