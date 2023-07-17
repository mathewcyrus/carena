import 'package:carena/screens/drivers_screens/widgets/driver_card.dart';
import 'package:carena/globals/colors.dart';
import 'package:carena/globals/data.dart';
import 'package:flutter/material.dart';

class DriverForHirePage extends StatelessWidget {
  const DriverForHirePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                width: double.infinity,
                child: TextField(
                  cursorColor: brandcolor,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: brandcolor, width: borderwidth)),
                    border:
                        OutlineInputBorder(borderSide: BorderSide(width: 0.5)),
                    hintText: "search  drivers",
                    hintStyle: TextStyle(fontSize: 18.0),
                    prefixIcon: Icon(
                      Icons.search,
                      color: brandcolor,
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  "Based on your location",
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: SizedBox(
                  height: 360.0,
                  width: double.infinity,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: drivers.length,
                    itemBuilder: (context, index) {
                      final driver = drivers[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DriverCard(
                          driver: driver,
                          type: "locationbased",
                        ),
                      );
                    },
                  ),
                ),
              ),
              const Text(
                "Available",
                style: TextStyle(fontSize: 20.0),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: drivers.length,
                itemBuilder: (context, index) {
                  final driver = drivers[index];
                  return DriverCard(driver: driver);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
