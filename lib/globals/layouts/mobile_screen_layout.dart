import 'package:carena/screens/car_sale_Screens/screens/car_selling_and_buying_screen.dart';
import 'package:carena/screens/drivers_screens/screens/find_a_driver_screen.dart';
import 'package:carena/screens/mechanic_screens.dart/find_a_mechanic_screen.dart';
import 'package:carena/screens/taxi_services.dart/get_a_taxi_screen.dart';
import 'package:carena/screens/carhire_services_screens/hire_a_car_screen.dart';
import 'package:carena/globals/colors.dart';
import 'package:flutter/material.dart';

class MobileScreenlayout extends StatefulWidget {
  const MobileScreenlayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenlayout> createState() => _MobileScreenlayoutState();
}

class _MobileScreenlayoutState extends State<MobileScreenlayout> {
  var indexClicked = 2;

  final screens = [
    const TaxiPage(),
    const CarhirePage(),
    const MarketPage(),
    const MechanicPage(),
    const DriverForHirePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 2.0, color: Colors.white10),
            ),
          ),
        ),
        title: const Text("Carena"),
        backgroundColor: darkmodecolor,
        actions: [
          IconButton(
              iconSize: 30.0,
              onPressed: () {},
              icon: const Icon(Icons.light_mode_outlined)),
          IconButton(
              iconSize: 30.0,
              onPressed: () {},
              icon: const Icon(Icons.account_circle_outlined))
        ],
      ),
      body: screens[indexClicked],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(width: 0.5, color: Colors.grey),
          ),
        ),
        child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.teal,
            backgroundColor: darkmodecolor,
            currentIndex: indexClicked,
            onTap: (value) {
              setState(() {
                indexClicked = value;
              });
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.local_taxi), label: "taxi"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.minor_crash_sharp), label: "car hire"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined), label: "home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.miscellaneous_services), label: "mechanic"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.safety_divider_sharp), label: "driver"),
            ]),
      ),
    );
  }
}
