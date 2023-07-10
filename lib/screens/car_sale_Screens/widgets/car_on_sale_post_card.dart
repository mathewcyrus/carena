import 'package:carena/screens/car_sale_Screens/screens/car_on_sale_post_page.dart';
import 'package:carena/screens/car_sale_Screens/screens/profile/car_seller_profile.dart';
import 'package:carena/screens/car_sale_Screens/widgets/likes_and_comments_bar.dart';
import 'package:flutter/material.dart';

class CarSalePost extends StatelessWidget {
  final dynamic post;

  const CarSalePost({
    required this.post,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void navigateToPostScreen() => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => CarSaleSinglePostPage(post: post),
          ),
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
              child: Image(
                height: 250.0,
                image: AssetImage(post['url']),
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const CarSellerProfilePage(),
                ),
              );
            },
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 0.0, vertical: 10.0),
            leading: CircleAvatar(
              radius: 30.0,
              backgroundImage: AssetImage(post['url']),
            ),
            title: Text(post['username']),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(post['name']),
                Text(
                  "${post['Price']} ksh",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            trailing:
                IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 75.0, bottom: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Love speed? Enjoy an accelaration rate of upto 80km/hr per second...",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text("22/6/2023")
              ],
            ),
          ),
          LikesAndCommentsBar(post: post)
        ],
      ),
    );
  }
}
