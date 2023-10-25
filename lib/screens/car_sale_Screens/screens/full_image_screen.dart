import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class FullscreenImagePage extends StatelessWidget {
  final List<dynamic> images;
  final int initialIndex;

  const FullscreenImagePage(
      {super.key, required this.images, required this.initialIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black, // Customize the background color
        iconTheme: const IconThemeData(
            color: Colors.white), // Customize the icon color
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.close,
                color: Colors.white), // Add a close icon
          ),
        ],
      ),
      body: CarouselSlider(
        items: images.map((image) {
          return Container(
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(image),
                fit: BoxFit.contain, // Adjust the fit as needed
              ),
            ),
          );
        }).toList(),
        options: CarouselOptions(
          height: double.infinity,
          initialPage: initialIndex,
          viewportFraction: 1.0,
          enableInfiniteScroll: false,
        ),
      ),
    );
  }
}
