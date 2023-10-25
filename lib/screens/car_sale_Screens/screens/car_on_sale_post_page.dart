import 'package:carena/globals/colors.dart';
import 'package:carena/routes/routes.dart';
import 'package:carena/screens/car_sale_Screens/widgets/likes_and_comments_bar.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CarSaleSinglePostPage extends StatefulWidget {
  final dynamic post;
  const CarSaleSinglePostPage({super.key, required this.post});

  @override
  State<CarSaleSinglePostPage> createState() => _CarSaleSinglePostPageState();
}

class _CarSaleSinglePostPageState extends State<CarSaleSinglePostPage> {
  int currentimageindex = 0;

  void moveToImage(String tap) {
    if (tap == "forward" && currentimageindex < 3) {
      setState(() {
        currentimageindex++;
      });
    } else {
      setState(() {
        if (currentimageindex > 0) {
          currentimageindex--;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> images = widget.post['imagesurls'];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkmodecolor,
        title: const Text("Post"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 390.0,
            child: Column(
              children: [
                Stack(
                  children: [
                    CarouselSlider(
                      items: images.map((image) {
                        return Container(
                          width: double.infinity,
                          height: 350.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(image),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      }).toList(),
                      options: CarouselOptions(
                        height: 350.0,
                        viewportFraction: 1.0,
                        enableInfiniteScroll: false,
                        onPageChanged: (index, reason) {
                          setState(() {
                            currentimageindex = index;
                          });
                        },
                      ),
                    ),
                    Positioned(
                      bottom: 0.0,
                      right: 0.0,
                      child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                            RouteManager.fullImagePage,
                            arguments: {
                              'images': images,
                              'currentImageIndex': currentimageindex,
                            },
                          );
                        },
                        iconSize: 50.0,
                        icon: const Icon(
                          Icons.fullscreen,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: double.infinity,
                  height: 40.0,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: images.asMap().entries.map((entry) {
                        int index = entry.key;
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Icon(
                            Icons.circle,
                            size: currentimageindex == index ? 18.0 : 12.0,
                            color: currentimageindex == index
                                ? Colors.green
                                : bordercolor,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          LikesAndCommentsBar(post: widget.post),
          Container(
            padding: const EdgeInsets.only(bottom: 5.0, left: 35.0, top: 15.0),
            // decoration: const BoxDecoration(
            //   border: Border(
            //     bottom: BorderSide(color: Colors.white10, width: 2.0),
            //   ),
            // ),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    widget.post['postcaption'],
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
            child: Column(
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  // contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
                  leading: const CircleAvatar(
                    radius: 28.0,
                    backgroundImage: AssetImage('assets/images/audi1.jpg'),
                  ),
                  title: Padding(
                    padding: const EdgeInsets.only(top: 14.0),
                    child: Text(
                      widget.post['username'],
                      style: const TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Text(
                      widget.post['postcaption'],
                      style: const TextStyle(fontSize: 17.0),
                    ),
                  ),
                  trailing: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.comment_bank,
                      size: 35.0,
                      color: brandcolor,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
