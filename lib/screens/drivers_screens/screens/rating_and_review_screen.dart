import 'package:carena/globals/colors.dart';
import 'package:carena/globals/methods/flush_bar.dart';
import 'package:carena/providers/user_provider.dart';
import 'package:carena/screens/drivers_screens/methods/firebase.dart';
import 'package:flutter/material.dart';
import 'package:carena/models/user.dart' as model;

import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class RatingAndReviewPage extends StatefulWidget {
  final String driveruid;
  RatingAndReviewPage({Key? key, required this.driveruid}) : super(key: key);

  @override
  State<RatingAndReviewPage> createState() => _RatingAndReviewPageState();
}

class _RatingAndReviewPageState extends State<RatingAndReviewPage> {
  final TextEditingController _reviewController = TextEditingController();
  double _rating = 1.0;
  bool isLoading = false;

  @override
  void dispose() {
    _reviewController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    model.User user = Provider.of<UserProvider>(context).getUser;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Rating and Review"),
          backgroundColor: darkmodecolor,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 0.5, color: Colors.grey),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                border: Border.all(width: 1.0, color: Colors.grey),
                borderRadius: const BorderRadius.all(Radius.circular(20.0)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 10.0, bottom: 20.0),
                    child: Text(
                      "Review",
                      style: TextStyle(fontSize: 24.0),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _reviewController,
                          maxLines: 10,
                          cursorColor: brandcolor,
                          style: const TextStyle(fontSize: 18.0),
                          decoration: const InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 0.5, color: brandcolor),
                            ),
                            prefixIcon: SizedBox(
                              width: 10.0,
                              height: 220.0,
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Icon(
                                  Icons.notes,
                                  size: 35.0,
                                  color: brandcolor,
                                ),
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1.0,
                              ),
                            ),
                            hintText: "Review Emilia Clarke",
                            hintStyle: TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Rate",
                          style: TextStyle(fontSize: 24.0),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: RatingBar.builder(
                                  initialRating: _rating,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemSize: 35.0,
                                  itemPadding: const EdgeInsets.symmetric(
                                      horizontal: 4.0),
                                  itemBuilder: (context, _) => const Icon(
                                    Icons.star,
                                    color: Colors.orange,
                                  ),
                                  onRatingUpdate: (rating) {
                                    setState(() {
                                      _rating = rating;
                                    });
                                  },
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10.0, top: 3.0),
                                child: SizedBox(
                                  width: 30.0,
                                  child: Text(
                                    "$_rating",
                                    style: const TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.orange,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      setState(() {
                        isLoading = true;
                      });
                      var res =
                          await DriversFirestoreMethods().reviewAndRateDriver(
                        user.username,
                        user.uid,
                        user.profilephoto,
                        widget.driveruid,
                        _reviewController.text,
                        _rating,
                        DateTime.now(),
                      );
                      if (res == "success") {
                        showNotificationBar(
                            context, "review sent!", Icons.check, brandcolor);
                      }

                      setState(() {
                        _rating = 1.0;
                        _reviewController.text = "";
                      });
                      setState(() {
                        isLoading = false;
                      });
                    },
                    child: Container(
                      width: double.infinity,
                      height: 60.0,
                      padding: const EdgeInsets.all(10.0),
                      decoration: const BoxDecoration(
                        color: brandcolor,
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      ),
                      child: Center(
                        child: isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text(
                                "Send",
                                style: TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                  color: complemtarybrandcolor,
                                ),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
