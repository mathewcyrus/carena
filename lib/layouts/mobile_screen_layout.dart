import 'package:carena/globals/methods/flush_bar.dart';
import 'package:carena/globals/widgets/drawer_widget.dart';
import 'package:carena/routes/routes.dart';
import 'package:carena/models/user.dart' as model;
import 'package:carena/providers/user_provider.dart';
import 'package:carena/screens/car_sale_Screens/screens/car_selling_and_buying_screen.dart';
import 'package:carena/screens/car_sale_Screens/screens/profile/car_seller_profile.dart';
import 'package:carena/screens/drivers_screens/screens/find_a_driver_screen.dart';
import 'package:carena/screens/mechanic_screens.dart/screens/find_a_mechanic_screen.dart';
import 'package:carena/screens/search/search_screen.dart';
import 'package:carena/screens/taxi_services.dart/get_a_taxi_screen.dart';
import 'package:carena/globals/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MobileScreenlayout extends StatefulWidget {
  const MobileScreenlayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenlayout> createState() => _MobileScreenlayoutState();
}

class _MobileScreenlayoutState extends State<MobileScreenlayout> {
  var indexClicked = 2;

  final screens = [
    const TaxiPage(),
    const SearchScreen(),
    const MarketPage(),
    const MechanicPage(),
    const DriverForHirePage()
  ];
  void showNotificationFlushBar() {
    // const FlushBar(
    //   message: "This is a notification!",
    //   icon: Icons.notifications,
    //   iconcolor: Colors.red,
    // );
    showNotificationBar(
      context,
      "This is a notification",
      Icons.error,
      Colors.red,
    );
  }

  @override
  Widget build(BuildContext context) {
    model.User? user = Provider.of<UserProvider>(context).getUser;

    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: RichText(
            textScaleFactor: 1.5,
            text: const TextSpan(
              children: [
                TextSpan(
                  text: 'Car',
                  style: TextStyle(
                    color: brandcolor,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                TextSpan(
                  text: 'ena',
                  style: TextStyle(
                    color: complemtarybrandcolor,
                    fontStyle: FontStyle.italic,
                  ),
                )
              ],
            ),
          ),
          titleTextStyle: const TextStyle(
            fontSize: 30.0,
            fontStyle: FontStyle.italic,
            color: complemtarybrandcolor,
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                border:
                    Border(bottom: BorderSide(width: 0.2, color: bordercolor))),
          ),
          backgroundColor: darkmodecolor,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Row(
                children: [
                  IconButton(
                    iconSize: 30.0,
                    onPressed: showNotificationFlushBar,
                    icon: const Icon(
                      Icons.notifications,
                      color: brandcolor,
                      size: 30.0,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).pushNamed(
                      RouteManager.chatPage,
                    ),
                    child: const Stack(
                      children: [
                        Icon(
                          Icons.messenger,
                          color: bordercolor,
                          size: 35.0,
                        ),
                        Positioned(
                          left: 8.0,
                          bottom: 10.0,
                          child: Center(
                            child: CircleAvatar(
                              radius: 10.0,
                              child: Text(
                                '12',
                                style: TextStyle(
                                  color: complemtarybrandcolor,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  InkWell(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const CarSellerProfilePage(),
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 18.0,
                      backgroundImage: NetworkImage(user.profilephoto),
                    ),
                  )
                ],
              ),
            ),
          ],
          bottom: indexClicked == 2
              ? const TabBar(
                  labelColor: brandcolor,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorPadding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                  unselectedLabelColor: bordercolor,
                  unselectedLabelStyle:
                      TextStyle(fontSize: 18.0, fontWeight: FontWeight.normal),
                  labelStyle:
                      TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
                  indicatorColor: brandcolor,
                  tabs: [
                    Tab(
                      text: 'Car Market',
                    ),
                    Tab(
                      text: 'Car Hire',
                    ),
                  ],
                )
              : null,
        ),
        body: screens[indexClicked],
        drawer: const DrawerWidget(),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(width: 0.1, color: brandcolor),
            ),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.teal,
            backgroundColor: darkmodecolor,
            currentIndex: indexClicked,
            onTap: (value) {
              setState(
                () {
                  indexClicked = value;
                },
              );
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.local_taxi), label: "taxi"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search), label: "search"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined), label: "home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.miscellaneous_services), label: "mechanic"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.safety_divider_sharp), label: "driver"),
            ],
          ),
        ),
      ),
    );
  }
}
