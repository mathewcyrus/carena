import 'package:carena/screens/drivers_screens/screens/drivers_profile.dart';
import 'package:carena/utilities/colors.dart';
import 'package:flutter/material.dart';

class DriverCard extends StatelessWidget {
  final dynamic driver;
  final String? type;
  const DriverCard({super.key, required this.driver, this.type});

  @override
  Widget build(BuildContext context) {
    void navigateToProfile() {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const DriverProfilePage(),
        ),
      );
    }

    return Container(
      width: type == "locationbased" ? 260.0 : double.infinity,
      height: type == "locationbased" ? 350.0 : null,
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
                  onTap: () => navigateToProfile(),
                  contentPadding: const EdgeInsets.all(0.0),
                  leading: CircleAvatar(
                    radius: 30.0,
                    backgroundImage: AssetImage(driver['url']),
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        driver['username'],
                        style: const TextStyle(fontSize: 20.0),
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
                            driver['contact'],
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
                          driver["availability"]
                              ? "available"
                              : "not available",
                          style: driver['availability']
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
                      onTap: () => navigateToProfile(),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0),
                        ),
                        child: Image(
                          height: 180.0,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          image: AssetImage(driver['url']),
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
                            driver['username'],
                            style: const TextStyle(fontSize: 20.0),
                          ),
                          Text(
                            driver["availability"]
                                ? "available"
                                : "not available",
                            style: driver['availability']
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
                                driver['location'],
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
                    driver['location'],
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
