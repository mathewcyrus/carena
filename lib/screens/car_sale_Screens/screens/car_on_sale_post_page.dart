import 'package:carena/globals/colors.dart';
import 'package:carena/screens/car_sale_Screens/widgets/likes_and_comments_bar.dart';
import 'package:flutter/material.dart';

class CarSaleSinglePostPage extends StatelessWidget {
  final dynamic post;
  const CarSaleSinglePostPage({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkmodecolor,
        title: const Text("Post"),
      ),
      body: Column(children: [
        Image(fit: BoxFit.contain, image: AssetImage(post['url'])),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
                leading: CircleAvatar(backgroundImage: AssetImage(post['url'])),
                title: Text(post['username']),
                subtitle: Text(
                  post['name'],
                ),
                trailing: IconButton(
                    onPressed: () {}, icon: const Icon(Icons.comment_bank)),
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 8.0),
                decoration: const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: Colors.white10, width: 2.0))),
                child: Column(
                  children: [
                    const Text(
                      "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Molestias molestiae exercitationem similique eum quam deserunt nostrum sunt? Culpa cum amet qui molestias recusandae laborum dolorum in illum possimus? Minima voluptatibus vel delectus. Eius consequuntur voluptatem beatae fugit vel consectetur molestiae eligendi officia adipisci ex doloribus labore in pariatur architecto delectus, accusamus neque nihil ea, tempora itaque dignissimos, possimus optio ipsum iste! Tenetur numquam libero harum eius ex eos aliquam tempore.",
                      style: TextStyle(fontSize: 15.0),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    LikesAndCommentsBar(post: post)
                  ],
                ),
              )
            ],
          ),
        )
      ]),
    );
  }
}
