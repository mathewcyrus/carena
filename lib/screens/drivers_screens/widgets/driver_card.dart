import 'package:carena/models/driver.dart';
import 'package:carena/routes/routes.dart';
import 'package:carena/globals/colors.dart';
import 'package:flutter/material.dart';

class DriverCard extends StatelessWidget {
  final Driver driver;
  final String? type;
  const DriverCard({super.key, required this.driver, this.type});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: type == "locationbased" ? 260.0 : 370.0,
      height: type == "locationbased" ? 350.0 : 130.0,
      padding: type == "locationbased"
          ? null
          : const EdgeInsets.symmetric(vertical: 10.0),
      decoration: BoxDecoration(
        color: type == "locationbased" ? darkmodecolor : null,
        border: type != "locationbased"
            ? const Border(
                bottom: BorderSide(
                  width: 0.2,
                  color: bordercolor,
                ),
              )
            : Border.all(
                width: borderwidth,
                color: bordercolor,
              ),
        borderRadius: type == "locationbased"
            ? const BorderRadius.all(Radius.circular(10.0))
            : null,
      ),
      child: Column(
        children: [
          type != "locationbased"
              ? ListTile(
                  onTap: () => Navigator.of(context)
                      .pushNamed(RouteManager.profilePage, arguments: driver),
                  contentPadding: const EdgeInsets.all(0.0),
                  leading: CircleAvatar(
                    backgroundColor: Colors.white24,
                    radius: 30.0,
                    backgroundImage: NetworkImage(driver.profileImage),
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      driver.driverusername.isNotEmpty
                          ? Text(
                              driver.driverusername,
                              style: const TextStyle(fontSize: 20.0),
                            )
                          : Container(
                              width: 100.0,
                              height: 30.0,
                              decoration: const BoxDecoration(
                                color: Colors.white24,
                              ),
                            ),
                      Row(
                        children: [
                          const Icon(
                            Icons.phone,
                            size: 20.0,
                            color: brandcolor,
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            driver.phonenumber,
                            style: const TextStyle(fontSize: 14.0),
                          ),
                        ],
                      ),
                    ],
                  ),
                  subtitle: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Text(
                          driver.available == true
                              ? "available"
                              : "not available",
                          style: driver.available == true
                              ? const TextStyle(
                                  fontSize: 17.0, color: brandcolor)
                              : const TextStyle(
                                  fontSize: 17.0, color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                )
              : Column(
                  children: [
                    InkWell(
                      onTap: () => Navigator.of(context).pushNamed(
                          RouteManager.profilePage,
                          arguments: driver),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0),
                        ),
                        child: Container(
                          height: 180.0,
                          width: double.infinity,
                          decoration:
                              const BoxDecoration(color: Colors.white24),
                          child: Image(
                            height: 180.0,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              driver.profileImage,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 10.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            driver.driverusername,
                            style: const TextStyle(fontSize: 20.0),
                          ),
                          Text(
                            driver.available == true
                                ? "available"
                                : "not available",
                            style: driver.available == true
                                ? const TextStyle(
                                    fontSize: 17.0, color: brandcolor)
                                : const TextStyle(
                                    fontSize: 17.0, color: Colors.red),
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(top: 4.0, right: 5.0),
                                child: Icon(
                                  Icons.location_on,
                                  color: brandcolor,
                                  size: 18.0,
                                ),
                              ),
                              Text(
                                driver.location,
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Container(
                            width: double.infinity,
                            height: 50.0,
                            color: brandcolor,
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.call),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Text(
                                  "call",
                                  style: TextStyle(
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
          if (type != "locationbased")
            Padding(
              padding: const EdgeInsets.only(left: 70.0, top: 10.0),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 4.0, right: 5.0),
                    child: Icon(
                      Icons.location_on,
                      color: brandcolor,
                      size: 18.0,
                    ),
                  ),
                  Text(
                    driver.location,
                    style: const TextStyle(
                      fontSize: 18.0,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
