import 'package:carena/routes/routes.dart';
import 'package:carena/globals/colors.dart';
import 'package:flutter/material.dart';

class MechanicContactCard extends StatelessWidget {
  final dynamic driver;
  final String? type;
  const MechanicContactCard({super.key, required this.driver, this.type});

  @override
  Widget build(BuildContext context) {
    void navigateToProfile() {
      Navigator.of(context).pushNamed(RouteManager.profilePage);
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 0.2,
            color: bordercolor,
          ),
        ),
      ),
      child: Column(
        children: [
          ListTile(
            onTap: () => navigateToProfile(),
            contentPadding: const EdgeInsets.all(0.0),
            leading: CircleAvatar(
              backgroundColor: Colors.white24,
              radius: 30.0,
              backgroundImage: AssetImage(driver['url']),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                driver['username'] != null
                    ? Text(
                        driver['username'],
                        style: const TextStyle(fontSize: 20.0),
                      )
                    : Container(
                        width: 100.0,
                        height: 30.0,
                        decoration: const BoxDecoration(
                          color: Colors.white24,
                        ),
                      ),
                const Text("13 min"),
              ],
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Row(
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
                    style: const TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            ),
          ),
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
