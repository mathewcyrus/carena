import 'package:carena/authentication/widgets/input.dart';
import 'package:carena/globals/colors.dart';
import 'package:carena/globals/methods/flush_bar.dart';
import 'package:carena/models/user.dart' as model;
import 'package:carena/models/car_on_hire.dart';
import 'package:carena/providers/user_provider.dart';
import 'package:carena/screens/carhire_services_screens/methods/firebase.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CarHireDetailsPage extends StatefulWidget {
  final DateTime pickUpDate;
  final CarHire carHire;
  final DateTime returnDate;
  late int dayshired;

  CarHireDetailsPage({
    Key? key,
    required this.pickUpDate,
    required this.returnDate,
    required this.carHire,
  }) : super(key: key) {
    final DateTime midnightPickUp =
        DateTime(pickUpDate.year, pickUpDate.month, pickUpDate.day);
    final DateTime midnightReturn =
        DateTime(returnDate.year, returnDate.month, returnDate.day);

    if (midnightPickUp.isAtSameMomentAs(midnightReturn)) {
      dayshired = 1;
    } else {
      final Duration hireDuration = midnightReturn.difference(midnightPickUp);
      dayshired = hireDuration.inDays;
    }
  }

  @override
  State<CarHireDetailsPage> createState() => _CarHireDetailsPageState();
}

class _CarHireDetailsPageState extends State<CarHireDetailsPage> {
  bool _isloading = false;

  @override
  Widget build(BuildContext context) {
    model.User user = Provider.of<UserProvider>(context).getUser;
    List<Map<String, DateTime>> hiredDates = [
      for (int i = 0; i < widget.dayshired; i++)
        {
          'pickupDate': widget.pickUpDate.add(Duration(days: i)),
          'returnDate': widget.returnDate,
        },
    ];

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: darkmodecolor,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 0.5, color: bordercolor),
              ),
            ),
          ),
          title: const Text("Car Hire Details Page"),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 10.0,
          ),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 240.0,
                        width: double.infinity,
                        child: GridView.count(
                          physics: const NeverScrollableScrollPhysics(),
                          mainAxisSpacing: 10.0,
                          crossAxisSpacing: 10.0,
                          childAspectRatio: 1.5,
                          crossAxisCount: 2,
                          children: List.generate(
                            widget.carHire.imagesurls.length,
                            (index) {
                              String imageUrl =
                                  widget.carHire.imagesurls[index];
                              return Image.network(
                                imageUrl,
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.directions_car,
                              size: 35.0,
                            ),
                            const SizedBox(
                              width: 20.0,
                            ),
                            Text(
                              widget.carHire.carModel,
                              style: const TextStyle(fontSize: 20.0),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: UserInputField(
                                textInputType: TextInputType.text,
                                type: "readonly",
                                hinttext: user.email,
                                prefixicon: Icons.lock,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: UserInputField(
                                textInputType: TextInputType.text,
                                type: "readonly",
                                hinttext: user.phonenumber,
                                prefixicon: Icons.lock,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: UserInputField(
                                textInputType: TextInputType.text,
                                type: "readonly",
                                hinttext: DateFormat('MM/dd/yyyy')
                                    .format(widget.pickUpDate),
                                prefixicon: Icons.lock,
                              ),
                            ),
                            const SizedBox(
                              width: 20.0,
                            ),
                            Expanded(
                              child: UserInputField(
                                textInputType: TextInputType.text,
                                type: "readonly",
                                hinttext: DateFormat('MM/dd/yyyy')
                                    .format(widget.returnDate),
                                prefixicon: Icons.lock,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: UserInputField(
                                textInputType: TextInputType.text,
                                type: "readonly",
                                hinttext: widget.carHire.location,
                                prefixicon: Icons.lock,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Container(
                          height: 50.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            color: Colors.white,
                          ),
                          child: Center(
                            child: Text(
                              "${widget.dayshired} day(s)/${widget.dayshired * int.parse(widget.carHire.priceperday)} ksh",
                              style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          setState(() {
                            _isloading = true;
                          });
                          var res =
                              await CarhireFirestoreMethods().updateHiredCar(
                            user.username,
                            user.email,
                            user.uid,
                            widget.dayshired,
                            widget.carHire.postId,
                            hiredDates,
                          );
                          if (res == 'success') {
                            showNotificationBar(context, "hired succesfully!",
                                Icons.check, brandcolor);

                            setState(() {
                              _isloading = false;
                            });
                          }
                          ;
                        },
                        child: Container(
                          height: 50.0,
                          decoration: const BoxDecoration(
                            color: Colors.white24,
                          ),
                          child: Center(
                            child: _isloading
                                ? const CircularProgressIndicator(
                                    value: 40.0,
                                    color: Colors.white,
                                  )
                                : const Text(
                                    "Hire this car",
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white60,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
