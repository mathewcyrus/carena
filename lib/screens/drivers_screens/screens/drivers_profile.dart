import 'package:carena/models/driver.dart';
import 'package:carena/models/reviewandratings.dart';
import 'package:carena/routes/routes.dart';
import 'package:carena/globals/colors.dart';
import 'package:carena/globals/url_launcher.dart';
import 'package:carena/screens/drivers_screens/widgets/reveiw_and_rating.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ContactInfoWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final String? action;
  final VoidCallback? onTap;

  const ContactInfoWidget({
    Key? key,
    required this.icon,
    required this.text,
    this.action,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.grey,
            ),
            const SizedBox(width: 10.0),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: text,
                    style: const TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  if (action != null) ...[
                    const TextSpan(
                      text: " ",
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    TextSpan(
                      text: String.fromCharCode(0x00B7), // middot character
                      style: const TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    const TextSpan(
                      text: " ",
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    TextSpan(
                      text: action,
                      style: const TextStyle(
                        fontSize: 18.0,
                        color: brandcolor,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DriverProfilePage extends StatelessWidget {
  final Driver driver;
  const DriverProfilePage({super.key, required this.driver});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: darkmodecolor,
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 290.0, // Set an explicit height for the Container
            child: Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 200.0,
                  child: Image(
                    fit: BoxFit.cover,
                    image: NetworkImage(driver.profileImage),
                  ),
                ),
                Positioned(
                  top: 165.0,
                  left: 15.0,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 3.0,
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 60.0,
                      backgroundImage: NetworkImage(driver.profileImage),
                    ),
                  ),
                ),
                const Positioned(
                  bottom: 100.0,
                  right: 10.0,
                  child: Icon(
                    Icons.add_a_photo_outlined,
                    color: complemtarybrandcolor,
                    size: 35.0,
                  ),
                ),
                Positioned(
                  bottom: 20.0,
                  left: 0.0,
                  right: 0.0,
                  child: ListTile(
                    leading: const SizedBox(
                      width: 120.0,
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          driver.driverusername,
                          style: const TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                      ],
                    ),
                    subtitle: Row(
                      children: [
                        const Icon(
                          Icons.credit_card,
                          size: 20.0,
                          color: brandcolor,
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          driver.licensetype,
                          style: const TextStyle(fontSize: 17.0),
                        ),
                      ],
                    ),
                    trailing: const Icon(
                      Icons.edit,
                      size: 35.0,
                      color: brandcolor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Text(
              "statistics",
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 20.0,
              top: 5.0,
              right: 20.0,
            ),
            child: Container(
              height: 90.0,
              decoration: BoxDecoration(
                  color: brandcolor,
                  border: Border.all(width: borderwidth, color: brandcolor),
                  borderRadius: const BorderRadius.all(Radius.circular(10.0))),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          "312",
                          style: TextStyle(
                            fontSize: 28.0,
                            fontWeight: FontWeight.bold,
                            color: complemtarybrandcolor,
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          "Rides",
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "3.5",
                          style: TextStyle(
                            fontSize: 28.0,
                            fontWeight: FontWeight.bold,
                            color: complemtarybrandcolor,
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          "Rating",
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "228",
                          style: TextStyle(
                            fontSize: 28.0,
                            fontWeight: FontWeight.bold,
                            color: complemtarybrandcolor,
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          "Reviews",
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            decoration: const BoxDecoration(
                // color: Colors.amber,
                ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.person,
                        color: complemtarybrandcolor,
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        "personal details",
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: brandcolor,
                        ),
                      ),
                    ],
                  ),
                ),
                ContactInfoWidget(
                  icon: Icons.phone,
                  text: driver.phonenumber,
                  action: "call",
                  onTap: () => urllauncher(driver.phonenumber, "phone"),
                ),
                ContactInfoWidget(
                  icon: Icons.email,
                  text: driver.email,
                  action: "email",
                  onTap: () => urllauncher(driver.email, "email"),
                ),
                ContactInfoWidget(
                  icon: Icons.location_on,
                  text: driver.location,
                ),
                const ContactInfoWidget(
                  icon: Icons.access_time_filled,
                  text: "5.00am - 9.00pm",
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    driver.driversbio,
                    style: const TextStyle(
                      fontSize: 18.0,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
            child: Container(
              height: 700.0, // Provide a fixed height for the container
              decoration: const BoxDecoration(
                color: Colors.white12,
              ),
              child: Column(
                children: [
                  Container(
                    height: 50.0,
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom:
                                BorderSide(width: 0.5, color: Colors.grey))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            "Reviews & Ratings",
                            style: TextStyle(
                              fontSize: 20.0,
                              color: brandcolor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(
                            flex: 1,
                          ),
                          IconButton(
                            onPressed: () => Navigator.of(context).pushNamed(
                                RouteManager.ratingAndReviewPage,
                                arguments: driver.driveruid),
                            icon: const Icon(
                              Icons.comment_bank,
                              color: complemtarybrandcolor,
                            ),
                            iconSize: 30.0,
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                      child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("drivers")
                        .doc(driver.driveruid)
                        .collection("reviewsandratings")
                        .snapshots(),
                    builder: (
                      context,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                          snapshot,
                    ) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (snapshot.hasData) {
                        final reviewsAndRatings = snapshot.data!.docs
                            .map((doc) => RatingAndReview.fromJson(doc.data()))
                            .toList();

                        if (reviewsAndRatings.isNotEmpty) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Skeletonizer(
                              enabled: snapshot.connectionState ==
                                  ConnectionState.waiting,
                              child: ListView.builder(
                                itemCount: reviewsAndRatings.length,
                                itemBuilder: (context, index) {
                                  final reviewAndRating =
                                      reviewsAndRatings[index];
                                  return ReviewAndRatingsCard(
                                    ratingAndReview: reviewAndRating,
                                  );
                                },
                              ),
                            ),
                          );
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      } else {
                        return const Center(child: Text("No data available."));
                      }
                    },
                  )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
