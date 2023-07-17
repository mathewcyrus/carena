import 'package:carena/globals/colors.dart';
import 'package:carena/globals/location.dart';
import 'package:carena/globals/widgets/maps_and_locations.dart';
import 'package:flutter/material.dart';

class MechanicPage extends StatefulWidget {
  const MechanicPage({Key? key}) : super(key: key);

  @override
  MechanicPageState createState() => MechanicPageState();
}

class MechanicPageState extends State<MechanicPage> {
  bool isToggled = false;
  String locationText = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.location_on,
                        size: 30.0,
                        color: brandcolor,
                      ),
                      hintText: locationText.isNotEmpty
                          ? locationText
                          : "Enter or turn on your location",
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(
                          width: borderwidth,
                          color: bordercolor,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10.0),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isToggled = !isToggled;
                    });
                    if (isToggled) {
                      locationRequests().then((location) {
                        setState(() {
                          locationText = location;
                        });
                      });
                    } else {
                      setState(() {
                        locationText = '';
                      });
                    }
                  },
                  child: Icon(
                    isToggled ? Icons.toggle_on : Icons.toggle_off,
                    color: isToggled ? brandcolor : bordercolor,
                    size: 60.0,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            Container(
              height: 500.0,
              width: double.infinity,
              // decoration: const BoxDecoration(
              //   color: bordercolor,
              // ),
              child: const MapsAndLocation(),
            )
          ],
        ),
      ),
    );
  }
}
