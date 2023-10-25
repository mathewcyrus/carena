import 'package:carena/models/driver.dart';
import 'package:carena/screens/drivers_screens/methods/firebase.dart';
import 'package:carena/screens/drivers_screens/widgets/driver_card.dart';
import 'package:carena/globals/colors.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class DriverForHirePage extends StatefulWidget {
  const DriverForHirePage({Key? key}) : super(key: key);

  @override
  State<DriverForHirePage> createState() => _DriverForHirePageState();
}

class _DriverForHirePageState extends State<DriverForHirePage> {
  Future<List<Driver>> _fetchDrivers() async {
    return await DriversFirestoreMethods().getAllDrivers();
  }

  final TextEditingController _searchController = TextEditingController();
  List<Driver> _drivers = [];
  List<Driver> _filteredDrivers = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    final searchQuery = _searchController.text.toLowerCase();
    setState(() {
      _filteredDrivers = _drivers.where((driver) {
        return driver.driverusername.toLowerCase().contains(searchQuery);
      }).toList();
    });
  }

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
              SizedBox(
                width: double.infinity,
                child: TextField(
                  controller: _searchController,
                  cursorColor: brandcolor,
                  onChanged: (value) {
                    _onSearchChanged();
                  },
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: brandcolor, width: borderwidth),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 0.5),
                    ),
                    hintText: "search  drivers",
                    hintStyle: TextStyle(fontSize: 18.0),
                    prefixIcon: Icon(
                      Icons.search,
                      color: brandcolor,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: _searchController.text.isNotEmpty
                    ? RichText(
                        textScaleFactor: 1.5,
                        text: TextSpan(children: [
                          const TextSpan(text: "search results for: "),
                          TextSpan(
                              text: _searchController.text,
                              style: const TextStyle(color: brandcolor))
                        ]),
                      )
                    : const Text(
                        "Based on your location",
                        style: TextStyle(fontSize: 20.0),
                      ),
              ),
              if (_filteredDrivers.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: SizedBox(
                    height: 360.0,
                    width: double.infinity,
                    child: FutureBuilder<List<Driver>>(
                      future: Future.value(
                          _filteredDrivers), // Use _filteredDrivers as the data source
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else if (snapshot.hasData) {
                          final drivers = snapshot.data;
                          return SizedBox(
                            height: 360.0,
                            child: Skeletonizer(
                              enabled: snapshot.connectionState ==
                                  ConnectionState.waiting,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: drivers!.length,
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
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(
                              value: 40.0,
                              color: Colors.white,
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ),
              if (_filteredDrivers.isEmpty && _searchController.text.isNotEmpty)
                const SizedBox(
                  width: double.infinity,
                  height: 250.0,
                  child: Center(
                    child: Text("No results found!"),
                  ),
                ),
              if (_searchController.text.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: SizedBox(
                    height: 360.0,
                    width: double.infinity,
                    child: FutureBuilder<List<Driver>>(
                      future: DriversFirestoreMethods().getAllDrivers(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else if (snapshot.hasData) {
                          _drivers = snapshot.data!;

                          final drivers = snapshot.data;
                          return SizedBox(
                            height: 360.0,
                            child: Skeletonizer(
                              enabled: snapshot.connectionState ==
                                  ConnectionState.waiting,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: drivers!.length,
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
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(
                              value: 40.0,
                              color: Colors.white,
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ),
              if (_searchController.text.isEmpty)
                const Text(
                  "Available",
                  style: TextStyle(fontSize: 20.0),
                ),
              if (_searchController.text.isEmpty)
                FutureBuilder<List<Driver>>(
                  future: _fetchDrivers(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      final drivers = snapshot.data;
                      return SizedBox(
                        width: double.infinity,
                        height: 360.0,
                        child: Skeletonizer(
                          enabled: snapshot.connectionState ==
                              ConnectionState.waiting,
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: drivers!.length,
                            itemBuilder: (context, index) {
                              final driver = drivers[index];
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DriverCard(
                                  driver: driver,
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(
                          value: 40.0,
                          color: Colors.white,
                        ),
                      );
                    }
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
