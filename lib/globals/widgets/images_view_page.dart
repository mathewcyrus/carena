import 'package:carena/globals/colors.dart';
import 'package:flutter/material.dart';

class ImagesViewPage extends StatefulWidget {
  final dynamic imagedetails;
  const ImagesViewPage({
    super.key,
    required this.imagedetails,
  });

  @override
  State<ImagesViewPage> createState() => _ImagesViewPageState();
}

class _ImagesViewPageState extends State<ImagesViewPage> {
  int currentimageindex = 0;
  final carimages = [
    {"url": "assets/images/audi1.jpg"},
    {"url": "assets/images/carthree.jpg"},
    {"url": "assets/images/rs7.jpg"},
    {"url": "assets/images/lexus.jpg"}
  ];

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkmodecolor,
      ),
      body: Stack(
        children: [
          Center(
            child: Image(
              fit: BoxFit.contain,
              image: AssetImage(carimages[currentimageindex]["url"]!),
            ),
          ),
          Positioned(
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 40.0,
                    height: 60.0,
                    decoration: BoxDecoration(
                      color: brandcolor,
                      border: Border.all(width: 0.5, color: bordercolor),
                    ),
                    child: Center(
                      child: IconButton(
                        onPressed: () => moveToImage("back"),
                        icon: const Icon(Icons.arrow_back_ios),
                        iconSize: 35.0,
                      ),
                    ),
                  ),
                  Container(
                    width: 40.0,
                    height: 60.0,
                    decoration: BoxDecoration(
                      color: brandcolor,
                      border: Border.all(width: 0.5, color: bordercolor),
                    ),
                    child: Center(
                      child: IconButton(
                        onPressed: () => moveToImage("forward"),
                        icon: const Icon(Icons.arrow_forward_ios),
                        iconSize: 35.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
