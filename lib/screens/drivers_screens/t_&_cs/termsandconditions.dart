import 'package:carena/globals/colors.dart';
import 'package:carena/routes/routes.dart';
import 'package:flutter/material.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Terms and Conditions"),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(

                  // height: 500.0,
                  )
            ],
          ),
          Positioned(
            right: 10.0,
            bottom: 30.0,
            child: Row(
              children: [
                InkWell(
                  onTap: () => Navigator.of(context)
                      .pushNamed(RouteManager.driverRegistration),
                  child: Container(
                    width: 150.0,
                    height: 50.0,
                    padding: const EdgeInsets.all(10.0),
                    decoration: const BoxDecoration(
                      color: brandcolor,
                    ),
                    child: const Center(
                      child: Text(
                        "Continue",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
