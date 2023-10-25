import 'package:carena/globals/colors.dart';
import 'package:carena/globals/data.dart';
import 'package:carena/models/car_on_hire.dart';
import 'package:carena/routes/routes.dart';
import 'package:carena/authentication/widgets/input.dart';
import 'package:carena/screens/carhire_services_screens/widgets/car_on_hire_post_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CarHireScreen extends StatefulWidget {
  const CarHireScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<CarHireScreen> createState() => _CarHireScreenState();
}

class _CarHireScreenState extends State<CarHireScreen> {
  final TextEditingController _pickuplocationcontroller =
      TextEditingController();
  final TextEditingController _cartypecontroller = TextEditingController();
  DateTime? _pickupDate;
  DateTime? _returnDate;
  final DateTime currentDate = DateTime.now(); // Get the current date
  bool openSearch = false;
  final List<CarHire> _availableToday = [];
  List<CarHire> _carsFromSearch = [];
  List<CarHire> allCars = [];

  @override
  void initState() {
    super.initState();
    // Populate _availableToday and _carsFromSearch here.
    _populateAvailableToday();
  }

  Future<void> searchAvailableCarsOnRange(
    String location,
    String cartype,
    DateTime pickUpDate,
    DateTime returnDate,
  ) async {
    // Filter cars based on location and car type

    final filteredCars = allCars.where((car) {
      final carLocation = car.location.toLowerCase();
      final carType = car.carMake.toLowerCase();
      location = location.toLowerCase();
      cartype = cartype.toLowerCase();

      return carLocation.contains(location) && carType.contains(cartype);
    }).toList();

    // Filter cars based on availability (pick-up and return date)
    final availableCars = filteredCars.where((car) {
      // Check if the car is available for the selected date range
      return !car.isBooked(pickUpDate, returnDate);
    }).toList();

    setState(() {
      _carsFromSearch = availableCars;
      _pickupDate = null;
      _returnDate = null;
    });
  }

// Filter cars that are available for the current day
  void _populateAvailableToday() {
    final currentDate = DateTime.now();

    // Filter cars that are available for the current day
    _availableToday.clear();
    _availableToday.addAll(allCars.where((car) {
      return !car.hiredDates.contains(currentDate);
    }));
  }

  Future<void> _selectDate(BuildContext context, String type) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (type == "pick-up") {
      setState(() {
        _pickupDate = picked;
      });
    } else {
      setState(() {
        _returnDate = picked;
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _cartypecontroller.dispose();
    _pickuplocationcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 18.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: openSearch ? 1 : 2,
                      child: GestureDetector(
                        onTap: () => Navigator.of(context).pushNamed(
                          RouteManager.carHireRegistrationPage,
                        ),
                        child: Container(
                          height: 50.0,
                          decoration: BoxDecoration(
                            color: brandcolor,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.fact_check_rounded,
                                  size: openSearch ? 24.0 : 35.0,
                                ),
                                const SizedBox(
                                  width: 15.0,
                                ),
                                Text(
                                  openSearch ? "Register" : "Register your car",
                                  style: const TextStyle(fontSize: 18.0),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    Expanded(
                      flex: openSearch ? 2 : 1,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            openSearch = !openSearch;
                          });
                        },
                        child: Container(
                          height: 50.0,
                          decoration: BoxDecoration(
                              color: openSearch ? Colors.red : null,
                              border:
                                  Border.all(width: 0.5, color: bordercolor),
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  openSearch ? "Close Search" : "Search",
                                  style: TextStyle(
                                    fontSize: openSearch ? 22.0 : 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  width: 15.0,
                                ),
                                Icon(
                                  openSearch
                                      ? Icons.close
                                      : Icons.keyboard_arrow_down,
                                  size: 35.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: openSearch
                    ? const EdgeInsets.only(
                        top: 5.0, left: 15.0, right: 15.0, bottom: 20.0)
                    : null,
                decoration: openSearch
                    ? BoxDecoration(
                        border: Border.all(width: 0.5, color: bordercolor),
                      )
                    : null,
                child: Column(
                  children: [
                    if (openSearch)
                      Column(
                        children: [
                          const SizedBox(
                            height: 10.0,
                          ),
                          UserInputField(
                            labeltext: 'pick-up location',
                            textInputType: TextInputType.text,
                            textEditingController: _pickuplocationcontroller,
                            prefixicon: Icons.location_on,
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          UserInputField(
                            labeltext: 'car type',
                            textInputType: TextInputType.text,
                            textEditingController: _cartypecontroller,
                            prefixicon: Icons.directions_car,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    _selectDate(context, "pick-up");
                                  },
                                  child: Container(
                                    height: 50.0,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 0.5, color: bordercolor),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12.0),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.calendar_today,
                                            color: brandcolor,
                                          ),
                                          const SizedBox(width: 10.0),
                                          Text(
                                            _pickupDate == null
                                                ? 'Pick-up Date'
                                                : DateFormat('MM/dd/yyyy')
                                                    .format(_pickupDate!),
                                            style:
                                                const TextStyle(fontSize: 14.0),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    _selectDate(context, "return");
                                  },
                                  child: Container(
                                    height: 50.0,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 0.5,
                                        color: bordercolor,
                                      ),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12.0),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.calendar_today,
                                            color: brandcolor,
                                          ),
                                          const SizedBox(width: 10.0),
                                          Text(
                                            _returnDate == null
                                                ? 'Return Date'
                                                : DateFormat('MM/dd/yyyy')
                                                    .format(_returnDate!),
                                            style:
                                                const TextStyle(fontSize: 14.0),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: GestureDetector(
                              onTap: () {
                                searchAvailableCarsOnRange(
                                    _pickuplocationcontroller.text,
                                    _cartypecontroller.text,
                                    _pickupDate!,
                                    _returnDate!);
                              },
                              child: Container(
                                width: double.infinity,
                                color: brandcolor,
                                height: 50.0,
                                child: const Center(
                                  child: Text(
                                    "Search",
                                    style: TextStyle(fontSize: 18.0),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Car hire companies",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 200.0,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: carcompanies.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            final company = carcompanies[index];
                            return Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Container(
                                  width: 140.0,
                                  height: double.infinity,
                                  padding: const EdgeInsets.all(10.0),
                                  decoration: const BoxDecoration(
                                    color: Colors.white10,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15.0),
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Stack(
                                        children: [
                                          CircleAvatar(
                                            radius: 45.0,
                                            backgroundColor: Colors.grey,
                                            backgroundImage:
                                                AssetImage(company['url']!),
                                          ),
                                          if (company["verified"] == "true")
                                            const Positioned(
                                              bottom: 0.0,
                                              right: 0.0,
                                              child: Icon(
                                                Icons.verified,
                                                color: Colors.blue,
                                                size: 30.0,
                                              ),
                                            )
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.0),
                                        child: Text(
                                          company['name']!,
                                          style: const TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      )
                                    ],
                                  ),
                                ));
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                decoration: const BoxDecoration(
                    border: Border(
                  bottom: BorderSide(width: 0.5, color: bordercolor),
                )),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    _carsFromSearch.isEmpty
                        ? "available ${DateFormat('MM/dd/yyyy').format(DateTime.now())}"
                        : "${_carsFromSearch.length} result(s)",
                    style: const TextStyle(fontSize: 18.0, color: brandcolor),
                  ),
                ),
              ),
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("registered_cars_for_hire")
                    .orderBy("dateposted", descending: true)
                    .snapshots(),
                builder: (
                  context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot,
                ) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData) {
                    return const Center(child: Text("No data available."));
                  }

                  final allCarsOnHire = snapshot.data!.docs
                      .map(
                        (doc) => CarHire.fromJson(
                          doc.data(),
                        ),
                      )
                      .toList();

                  allCars = allCarsOnHire;
                  _populateAvailableToday();

                  final List<CarHire> displayedCars = _carsFromSearch.isNotEmpty
                      ? _carsFromSearch
                      : _availableToday;

                  return Skeletonizer(
                    enabled:
                        snapshot.connectionState == ConnectionState.waiting,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: displayedCars.length,
                      itemBuilder: (context, index) {
                        final carHire = displayedCars[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CarOnHireCard(
                            carHire: carHire,
                            pickUpDate: _pickupDate != null
                                ? _pickupDate!
                                : DateTime.now(),
                            returnDate: _returnDate != null
                                ? _returnDate!
                                : DateTime.now(),
                          ),
                        );
                      },
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
