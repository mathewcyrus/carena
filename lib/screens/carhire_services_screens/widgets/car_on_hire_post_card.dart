import 'package:carena/globals/colors.dart';
import 'package:carena/models/car_on_hire.dart';
import 'package:carena/routes/routes.dart';
import 'package:flutter/material.dart';

class CarOnHireCard extends StatelessWidget {
  final CarHire carHire;
  final DateTime pickUpDate;
  final DateTime returnDate;
  const CarOnHireCard({
    super.key,
    required this.carHire,
    required this.pickUpDate,
    required this.returnDate,
  });

  @override
  Widget build(BuildContext context) {
    navigateToImagesViewPage(int index, String imageUrl) {
      Navigator.of(context)
          .pushNamed(RouteManager.imagesViewPage, arguments: {index, imageUrl});
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 0.5,
            color: bordercolor,
          ),
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 240.0,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 1.5,
                crossAxisCount: 2,
                children: List.generate(
                  carHire.imagesurls.length,
                  (index) {
                    String imageUrl = carHire.imagesurls[index];
                    return GestureDetector(
                      onTap: () {
                        navigateToImagesViewPage(index, imageUrl);
                      },
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 0.0, vertical: 10.0),
            title: Text(
              carHire.carModel,
              style:
                  const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${carHire.priceperday} kes",
                    style: const TextStyle(
                      fontSize: 22.0,
                      color: brandcolor,
                    ),
                  ),
                ],
              ),
            ),
            trailing: Container(
              width: 120.0,
              height: 40.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: complemtarybrandcolor,
              ),
              child: Center(
                child: Text(
                  carHire.carVin,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.of(context)
                .pushNamed(RouteManager.carHireDetailsPage, arguments: {
              "pickupdate": pickUpDate,
              "returndate": returnDate,
              "carHire": carHire
            }),
            child: Container(
              height: 60.0,
              width: double.infinity,
              decoration: const BoxDecoration(color: brandcolor),
              child: const Center(
                child: Text(
                  "Hire This Car",
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
