import 'package:carena/utilities/colors.dart';
import 'package:carena/utilities/data.dart';
import 'package:carena/screens/car_sale_Screens/widgets/car_on_sale_post_card.dart';
import 'package:carena/widgets/text_input_widget.dart';
import 'package:flutter/material.dart';

class MarketPage extends StatefulWidget {
  const MarketPage({Key? key}) : super(key: key);

  @override
  State<MarketPage> createState() => _MarketPageState();
}

class _MarketPageState extends State<MarketPage> {
  final TextEditingController _carpostsearchcontroller =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 45.0,
            child: Row(
              children: [
                Expanded(
                  child: UserInputField(
                      textInputType: TextInputType.text,
                      textEditingController: _carpostsearchcontroller,
                      hintText: 'search for cars on sale'),
                ),
                const SizedBox(
                  width: 20.0,
                ),
                const Icon(
                  Icons.add_box_rounded,
                  color: brandcolor,
                  size: 40.0,
                ),
              ],
            ),
          ),
          Expanded(
            // Wrap the ListView.builder with Expanded
            child: ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index]; // Get the current post
                return CarSalePost(post: post);
              },
            ),
          ),
        ],
      ),
    );
  }
}
