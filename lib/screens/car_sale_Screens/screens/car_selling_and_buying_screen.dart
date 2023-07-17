import 'package:carena/globals/colors.dart';
import 'package:carena/globals/data.dart';
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
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 60.0,
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
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index]; // Get the current post
                return CarSalePost(post: post);
              },
            ),
          ],
        ),
      ),
    );
  }
}
