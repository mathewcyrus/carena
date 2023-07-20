import 'package:carena/routes/routes.dart';
import 'package:carena/screens/car_sale_Screens/widgets/comment_card.dart';
import 'package:carena/screens/drivers_screens/screens/rating_and_review_screen.dart';
import 'package:carena/globals/colors.dart';
import 'package:carena/globals/data.dart';
import 'package:carena/globals/url_launcher.dart';
import 'package:flutter/material.dart';

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
  const DriverProfilePage({super.key});

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
                const SizedBox(
                  width: double.infinity,
                  height: 200.0,
                  child: Image(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/rs7.jpg"),
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
                    child: const CircleAvatar(
                      radius: 60.0,
                      backgroundImage: AssetImage("assets/images/person6.jpg"),
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
                const Positioned(
                  bottom: 20.0,
                  left: 0.0,
                  right: 0.0,
                  child: ListTile(
                    leading: SizedBox(
                      width: 120.0,
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Emilia Clarke",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                      ],
                    ),
                    subtitle: Row(
                      children: [
                        Icon(
                          Icons.credit_card,
                          size: 20.0,
                          color: brandcolor,
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          "Class A\\n driver",
                          style: TextStyle(fontSize: 17.0),
                        ),
                      ],
                    ),
                    trailing: Icon(
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
                  text: "+254 11234566",
                  action: "call",
                  onTap: () => urllauncher("+254 11234566", "phone"),
                ),
                ContactInfoWidget(
                  icon: Icons.email,
                  text: "emiliaclarke@gmail.com",
                  action: "email",
                  onTap: () => urllauncher("+254 11234566", "phone"),
                ),
                const ContactInfoWidget(
                  icon: Icons.location_on,
                  text: "Nairobi, Kenya",
                ),
                const ContactInfoWidget(
                  icon: Icons.access_time_filled,
                  text: "5.00am - 9.00pm",
                ),
                // Align(
                //   alignment: Alignment.centerLeft,
                //   child: RatingBar.builder(
                //     //Ratins Icons here
                //     initialRating: 3,
                //     minRating: 1,
                //     direction: Axis.horizontal,
                //     allowHalfRating: true,
                //     itemCount: 5,
                //     itemSize: 30.0,
                //     itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                //     itemBuilder: (context, _) => const Icon(
                //       Icons.star,
                //       color: complemtarybrandcolor,
                //     ),
                //     onRatingUpdate: (rating) {},
                //   ),
                // ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    "I am a professional driver with 5 years of experience in long-haul transportation. I specialize in refrigerated and hazmat shipments. Safety and punctuality are my top priorities, and I always strive to provide excellent service to my clients. I am dedicated, responsible, and have a clean driving record. I look forward to working with you!",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 50.0,
                  decoration: const BoxDecoration(
                    color: brandcolor,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Vehicle",
                          style: TextStyle(fontSize: 24.0),
                        ),
                        Text(
                          "KCA 007Q",
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: complemtarybrandcolor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 371.0,
                  width: double.infinity,
                  decoration: const BoxDecoration(color: bordercolor),
                  child: GridView.count(
                    crossAxisCount:
                        2, // Adjust the number of columns according to your needs
                    children: List.generate(
                      carimages.length,
                      (index) {
                        String imageUrl = carimages[index]["url"]!;
                        return Image.asset(
                          imageUrl,
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                )
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
                            onPressed: () => Navigator.of(context)
                                .pushNamed(RouteManager.ratingAndReviewPage),
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
                    child: ListView.builder(
                      itemCount: reviews.length,
                      itemBuilder: (context, index) {
                        final review = reviews[index];
                        return CommentCard(
                          comment: review,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
