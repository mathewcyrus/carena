import 'package:carena/authentication/methods/auth_methods.dart';
import 'package:carena/globals/methods/flush_bar.dart';
import 'package:carena/providers/user_provider.dart';
// import 'package:carena/s/car_sale_Screens/widgets/comment_card.dart';
import 'package:carena/globals/colors.dart';
import 'package:carena/globals/data.dart';
import 'package:carena/models/user.dart' as model;
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:carena/globals/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

class CarSellerProfilePage extends StatefulWidget {
  final String? userUid;
  const CarSellerProfilePage({super.key, this.userUid});

  @override
  State<CarSellerProfilePage> createState() => _CarSellerProfilePageState();
}

class _CarSellerProfilePageState extends State<CarSellerProfilePage> {
  final TextEditingController _bioController = TextEditingController();

  @override
  void dispose() {
    _bioController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    model.User? user = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: darkmodecolor,
      ),
      body: FutureBuilder<model.User>(
        future: getUserDetails(widget.userUid, user),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            }

            if (snapshot.hasData) {
              final userDetails = snapshot.data;

              return ListView(
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
                            image: NetworkImage(userDetails!.profilephoto),
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
                              backgroundImage:
                                  NetworkImage(userDetails.profilephoto),
                            ),
                          ),
                        ),
                        if (widget.userUid == user.uid ||
                            widget.userUid == null)
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
                                  widget.userUid != ""
                                      ? userDetails.username
                                      : user.username,
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
                            subtitle: const Row(
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
                                  "Motor dealer",
                                  style: TextStyle(fontSize: 17.0),
                                ),
                              ],
                            ),
                            trailing: widget.userUid == user.uid ||
                                    widget.userUid == null
                                ? const Icon(
                                    Icons.edit,
                                    size: 35.0,
                                    color: brandcolor,
                                  )
                                : null,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10.0),
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
                          text: userDetails.phonenumber,
                          action: "call",
                          onTap: () =>
                              urllauncher(userDetails.phonenumber, "phone"),
                        ),
                        ContactInfoWidget(
                          icon: Icons.email,
                          text: userDetails.email,
                          action: "email",
                          onTap: () => urllauncher(userDetails.email, "email"),
                        ),
                        const ContactInfoWidget(
                          icon: Icons.location_on,
                          text: "Nairobi, Kenya",
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: userDetails.bio != null
                              ? Text(
                                  userDetails.bio!,
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.grey,
                                  ),
                                )
                              : SizedBox(
                                  width: double.infinity,
                                  height: 40.0,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: TextField(
                                          controller: _bioController,
                                          decoration: const InputDecoration(
                                            hintText: "Click here to add a bio",
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: brandcolor,
                                              ),
                                            ),
                                            hintStyle: TextStyle(
                                              fontSize: 18.0,
                                              fontStyle: FontStyle.italic,
                                            ),
                                            contentPadding:
                                                EdgeInsets.only(left: 10.0),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 15.0,
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          var bio = _bioController.text;
                                          var res =
                                              await AuthMethods().updateUser(
                                            uid: user.uid,
                                            bio: bio,
                                          );

                                          if (res == "success") {
                                            showNotificationBar(
                                              context,
                                              "Bio updated successfully",
                                              Icons.check,
                                              brandcolor,
                                            );
                                          }

                                          setState(() {
                                            userDetails.bio = bio;

                                            _bioController.text = "";
                                          });
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(8.0),
                                          width: 100.0,
                                          height: double.infinity,
                                          decoration: BoxDecoration(
                                            color: brandcolor,
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          child: const Center(
                                            child: Text("Update"),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
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
                                    bottom: BorderSide(
                                        width: 0.5, color: Colors.grey))),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "posts",
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      color: brandcolor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Spacer(
                                    flex: 1,
                                  ),
                                  Text(
                                    "reviews",
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      color: brandcolor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: reviews.length,
                              itemBuilder: (context, index) {
                                return null;
                                // final review = reviews[index];
                                // return CommentCard(
                                //   comment: review,
                                // );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return const Center(child: Text("User not found."));
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Future<model.User> getUserDetails(String? userUid, model.User? user) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    String targetUid = userUid ?? user?.uid ?? '';

    DocumentSnapshot snap =
        await firestore.collection('all_Users').doc(targetUid).get();
    return model.User.convertUserFromSnap(snap);
  }
}
