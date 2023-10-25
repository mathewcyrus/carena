import 'package:carena/globals/colors.dart';
import 'package:carena/routes/routes.dart';
import 'package:carena/screens/car_sale_Screens/widgets/car_on_sale_post_card.dart';
import 'package:carena/authentication/widgets/input.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MarketPageTabWidget extends StatefulWidget {
  final String? type;

  const MarketPageTabWidget({Key? key, this.type}) : super(key: key);

  @override
  State<MarketPageTabWidget> createState() => _MarketPageTabWidgetState();
}

class _MarketPageTabWidgetState extends State<MarketPageTabWidget> {
  bool openSearch = false;

  final TextEditingController _carpostsearchcontroller =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
      ),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: 70.0,
                child: Row(
                  children: [
                    Expanded(
                      child: UserInputField(
                        textInputType: TextInputType.text,
                        textEditingController: _carpostsearchcontroller,
                        labeltext: "search for cars on sale",
                        prefixicon: Icons.search,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("posts")
                    .orderBy(
                      'dateposted',
                      descending: true,
                    )
                    .snapshots(),
                builder: (
                  context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot,
                ) {
                  if (snapshot.data == null) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return Skeletonizer(
                    enabled:
                        snapshot.connectionState == ConnectionState.waiting,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final post = snapshot.data!.docs[index].data();

                        // Get the current post
                        return CarSalePost(post: post);
                      },
                    ),
                  );
                },
              )
            ],
          ),
        ),
        floatingActionButton: widget.type != 'hire'
            ? FloatingActionButton(
                backgroundColor: brandcolor,
                onPressed: () =>
                    Navigator.of(context).pushNamed(RouteManager.addPost),
                tooltip: 'Sell',
                child: const Icon(Icons.add),
              )
            : null,
      ),
    );
  }
}
