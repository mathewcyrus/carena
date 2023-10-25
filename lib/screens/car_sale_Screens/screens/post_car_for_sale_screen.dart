import 'package:carena/globals/colors.dart';
import 'package:carena/globals/methods/flush_bar.dart';
import 'package:carena/globals/methods/image_picker.dart';
import 'package:carena/providers/user_provider.dart';
import 'package:carena/screens/car_sale_Screens/methods/firestore_methods.dart';
import 'dart:typed_data';
import 'package:carena/models/user.dart' as model;

import 'package:image_picker/image_picker.dart';
import 'package:carena/screens/car_sale_Screens/widgets/car_spec_input_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostPage extends StatefulWidget {
  const PostPage({Key? key}) : super(key: key);

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final TextEditingController _captionController = TextEditingController();
  final TextEditingController _makeController = TextEditingController();
  final TextEditingController _modelController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _colorController = TextEditingController();
  final TextEditingController _torqueController = TextEditingController();
  final TextEditingController _vinController = TextEditingController();
  final TextEditingController _engineSizeController = TextEditingController();
  final TextEditingController _horsePowerController = TextEditingController();
  final TextEditingController _efficiencyController = TextEditingController();
  final TextEditingController _perfomanceController = TextEditingController();
  String selectedColor = '';
  String selectedCondition = 'new';
  String selectedFuelType = 'Diesel';
  int selectedYear = DateTime.now().year;
  bool hasAirBags = false;
  bool hasABS = false;
  bool hasESC = false;
  bool hasLDW = false;
  bool hasFCW = false;
  bool hasTouchScreenDisplay = false;
  bool hasBluetooth = false;
  bool hasNavigationSystems = false;
  bool hasUsbPorts = false;
  bool postProcessing = false;

  List<int> yearsList =
      List.generate(100, (index) => DateTime.now().year - index);

  List<Uint8List> selectedImages = [];
  List<Map<String, dynamic>> carspecifications = [];

  Future<void> selectCarImagesToPost() async {
    int maxImages = 4;
    // Calculate the number of images the user can still select
    int remainingImages = maxImages - selectedImages.length;
    // Show the image picker for the remaining number of images
    for (int i = 0; i < remainingImages; i++) {
      Uint8List? image =
          await imagePicker(ImageSource.gallery, isRegister: false);
      if (image != null) {
        selectedImages.add(image);
      } else {
        // Break the loop if the user cancels the image picker
        break;
      }
    }
    setState(() {});
  }

  Map<String, dynamic> buildCarSpecification(
    String label,
    dynamic value, {
    bool isCheckbox = false,
  }) {
    Map<String, dynamic> specification = {
      'label': label,
      'value': isCheckbox ? (value as bool) : value,
    };
    return specification;
  }

  @override
  void dispose() {
    _captionController.dispose();
    _makeController.dispose();
    _modelController.dispose();
    _priceController.dispose();
    _torqueController.dispose();
    _colorController.dispose();
    _vinController.dispose();
    _engineSizeController.dispose();
    _horsePowerController.dispose();
    _efficiencyController.dispose();
    _perfomanceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    model.User user = Provider.of<UserProvider>(context).getUser;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.close,
              size: 35.0,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text("Add a post"),
          backgroundColor: darkmodecolor,
        ),
        body: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: InkWell(
                          onTap: selectCarImagesToPost,
                          child: const Row(
                            children: [
                              Icon(
                                Icons.photo,
                                size: 35.0,
                                color: brandcolor,
                              ),
                              SizedBox(
                                width: 20.0,
                              ),
                              Text(
                                "select up to 4 images",
                                style: TextStyle(fontSize: 18.0),
                              )
                            ],
                          ),
                        ),
                      ),
                      if (selectedImages.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: SizedBox(
                            height: 200.0,
                            width: double.infinity,
                            child: ListView.builder(
                              itemCount: selectedImages.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                final image = selectedImages[index];
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
                                  child: Stack(
                                    children: [
                                      Image(
                                        image: MemoryImage(image),
                                        width: 200.0,
                                        height: 200.0,
                                        fit: BoxFit.cover,
                                      ),
                                      Positioned(
                                        right: 5.0,
                                        child: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              selectedImages.removeAt(index);
                                            });
                                          },
                                          icon: const Icon(
                                            Icons.cancel,
                                            size: 35.0,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      TextField(
                        maxLines: 5,
                        controller: _captionController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: borderwidth, color: bordercolor)),
                            hintText: "Say something about this car ...",
                            hintStyle: TextStyle(fontSize: 18.0)),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 40.0, bottom: 10.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.settings,
                              size: 35.0,
                              color: brandcolor,
                            ),
                            SizedBox(
                              width: 20.0,
                            ),
                            Text(
                              "Car Specifications",
                              style: TextStyle(
                                  fontSize: 20.0,
                                  color: brandcolor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        width: double.infinity,
                        height: 60.0,
                        decoration: const BoxDecoration(
                          color: brandcolor,
                          border: Border(
                            bottom: BorderSide(
                                width: borderwidth, color: bordercolor),
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            "Basic Information",
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      CarSpecificationsInput(
                        text: 'Make',
                        hintText: 'Toyota',
                        controller: _makeController,
                      ),
                      CarSpecificationsInput(
                        text: 'Model',
                        hintText: 'lexus',
                        controller: _modelController,
                      ),
                      CarSpecificationsInput(
                        text: 'Price',
                        hintText: 'price',
                        controller: _priceController,
                      ),
                      CarSpecificationsInput(
                        text: 'color',
                        hintText: 'input color',
                        controller: _colorController,
                      ),
                      CarSpecificationsInput(
                        text: 'condition',
                        isSelect: true,
                        selectOptions: const ['new', 'refurbished'],
                        selectedValue: selectedCondition,
                        onChanged: (value) {
                          setState(() {
                            selectedCondition =
                                value ?? ''; // Update the selected value
                          });
                        },
                      ),
                      CarSpecificationsInput(
                        text: 'Year',
                        isSelect: true,
                        selectOptions:
                            yearsList.map((year) => year.toString()).toList(),
                        selectedValue:
                            selectedYear.toString(), // Convert int to String
                        onChanged: (value) {
                          setState(() {
                            selectedYear =
                                int.parse(value!); // Parse String to int
                          });
                        },
                      ),
                      if (selectedCondition == 'refurbished')
                        CarSpecificationsInput(
                          text: 'VIN',
                          hintText: "Vehicle Indentification Number ",
                          controller: _vinController,
                        ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      Container(
                        width: double.infinity,
                        height: 60.0,
                        decoration: const BoxDecoration(
                          color: brandcolor,
                          border: Border(
                            bottom: BorderSide(
                                width: borderwidth, color: bordercolor),
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            "Engine Specifications",
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      CarSpecificationsInput(
                        text: 'Engine size',
                        hintText: "cc ",
                        controller: _engineSizeController,
                      ),
                      CarSpecificationsInput(
                        text: 'Horsepower',
                        hintText: "HP",
                        controller: _horsePowerController,
                      ),
                      CarSpecificationsInput(
                        text: 'Torque',
                        hintText: "lb-ft",
                        controller: _torqueController,
                      ),
                      CarSpecificationsInput(
                        text: 'Fuel',
                        isSelect: true,
                        selectOptions: const [
                          'Gasoline',
                          'Diesel',
                          'Electricity',
                          'CVT'
                        ],
                        selectedValue: selectedFuelType,
                        onChanged: (value) {
                          setState(() {
                            selectedFuelType =
                                value ?? ''; // Update the selected value
                          });
                        },
                      ),
                      CarSpecificationsInput(
                        text: 'Efficiency',
                        hintText: "MPG or L/100km",
                        controller: _efficiencyController,
                      ),
                      CarSpecificationsInput(
                        text: 'Perfomance',
                        hintText: "0-60 mph or 0-100km/h",
                        controller: _perfomanceController,
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      Container(
                        width: double.infinity,
                        height: 60.0,
                        decoration: const BoxDecoration(
                          color: brandcolor,
                          border: Border(
                            bottom: BorderSide(
                                width: borderwidth, color: bordercolor),
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            "Safety Features",
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      CarSpecificationsInput(
                        text: "Airbags",
                        isCheckbox: true,
                        selectedValue: hasAirBags,
                        onChanged: (value) {
                          setState(() {
                            hasAirBags = value as bool;
                          });
                        },
                      ),
                      CarSpecificationsInput(
                        text: "Anti-lock Braking System",
                        isCheckbox: true,
                        selectedValue: hasABS,
                        onChanged: (value) {
                          setState(() {
                            hasABS = value as bool;
                          });
                        },
                      ),
                      CarSpecificationsInput(
                        text: "Electronic Stability Control",
                        isCheckbox: true,
                        selectedValue: hasESC,
                        onChanged: (value) {
                          setState(() {
                            hasESC = value as bool;
                          });
                        },
                      ),
                      CarSpecificationsInput(
                        text: "Lane Departure Warning",
                        isCheckbox: true,
                        selectedValue: hasLDW,
                        onChanged: (value) {
                          setState(() {
                            hasLDW = value as bool;
                          });
                        },
                      ),
                      CarSpecificationsInput(
                        text: "Forward Collision Warning",
                        isCheckbox: true,
                        selectedValue: hasFCW,
                        onChanged: (value) {
                          setState(() {
                            hasFCW = value as bool;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      Container(
                        width: double.infinity,
                        height: 60.0,
                        decoration: const BoxDecoration(
                          color: brandcolor,
                          border: Border(
                            bottom: BorderSide(
                                width: borderwidth, color: bordercolor),
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            "Infotainment and Connectivity",
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      CarSpecificationsInput(
                        text: "Touchscreen Display ",
                        isCheckbox: true,
                        selectedValue: hasTouchScreenDisplay,
                        onChanged: (value) {
                          setState(() {
                            hasTouchScreenDisplay = value as bool;
                          });
                        },
                      ),
                      CarSpecificationsInput(
                        text: "Bluetooth Connectivity",
                        isCheckbox: true,
                        selectedValue: hasBluetooth,
                        onChanged: (value) {
                          setState(() {
                            hasBluetooth = value as bool;
                          });
                        },
                      ),
                      CarSpecificationsInput(
                        text: "Navigation System",
                        isCheckbox: true,
                        selectedValue: hasNavigationSystems,
                        onChanged: (value) {
                          setState(() {
                            hasNavigationSystems = value as bool;
                          });
                        },
                      ),
                      CarSpecificationsInput(
                        text: "USB Ports",
                        isCheckbox: true,
                        selectedValue: hasUsbPorts,
                        onChanged: (value) {
                          setState(() {
                            hasUsbPorts = value as bool;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 20.0,
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  setState(() {
                    postProcessing = true;
                  });
                  carspecifications = [
                    buildCarSpecification('Make', _makeController.text),
                    buildCarSpecification('Model', _modelController.text),
                    buildCarSpecification('Price', _priceController.text),
                    buildCarSpecification('Color', _colorController.text),
                    buildCarSpecification('Condition', selectedCondition),
                    buildCarSpecification('Year', selectedYear),
                    if (selectedCondition == 'refurbished')
                      buildCarSpecification('VIN', _vinController.text),
                    buildCarSpecification(
                        'Engine size', "${_engineSizeController.text} cc"),
                    buildCarSpecification(
                        'Horsepower', "${_horsePowerController.text} hp"),
                    buildCarSpecification(
                        'Torque', "${_torqueController.text} lb-ft"),
                    buildCarSpecification('Fuel', selectedFuelType),
                    buildCarSpecification(
                        'Efficiency', "${_efficiencyController.text} mpg"),
                    buildCarSpecification(
                        'Perfomance', "${_perfomanceController.text} sec"),
                    buildCarSpecification('Airbags', hasAirBags,
                        isCheckbox: true),
                    buildCarSpecification('Anti-lock Braking System', hasABS,
                        isCheckbox: true),
                    buildCarSpecification(
                        'Electronic Stability Control', hasESC,
                        isCheckbox: true),
                    buildCarSpecification('Lane Departure Warning', hasLDW,
                        isCheckbox: true),
                    buildCarSpecification('Forward Collision Warning', hasFCW,
                        isCheckbox: true),
                    buildCarSpecification(
                        'Touchscreen Display', hasTouchScreenDisplay,
                        isCheckbox: true),
                    buildCarSpecification(
                        'Bluetooth Connectivity', hasBluetooth,
                        isCheckbox: true),
                    buildCarSpecification(
                        'Navigation System', hasNavigationSystems,
                        isCheckbox: true),
                    buildCarSpecification('USB Ports', hasUsbPorts,
                        isCheckbox: true),
                  ];

                  var res = await FirestoreMethods().uploadAPost(
                    user.username,
                    user.profilephoto,
                    user.uid,
                    _captionController.text,
                    selectedImages,
                    carspecifications,
                  );
                  if (res == 'success') {
                    showNotificationBar(
                        context, "posted!", Icons.check, brandcolor);

                    // Set the state back to empty
                    setState(() {
                      _captionController.text = "";
                      _makeController.text = "";
                      _modelController.text = "";
                      _priceController.text = "";
                      _colorController.text = "";
                      _vinController.text = "";
                      _torqueController.text = "";
                      _engineSizeController.text = "";
                      _horsePowerController.text = "";
                      _efficiencyController.text = "";
                      _perfomanceController.text = "";

                      hasAirBags = false;
                      hasABS = false;
                      hasESC = false;
                      hasLDW = false;
                      hasFCW = false;
                      hasTouchScreenDisplay = false;
                      hasBluetooth = false;
                      hasNavigationSystems = false;
                      hasUsbPorts = false;
                      selectedImages = [];

                      postProcessing = false;
                    });
                  } else {
                    showNotificationBar(context, res, Icons.error, Colors.red);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Container(
                    width: double.infinity,
                    height: 60.0,
                    decoration: const BoxDecoration(
                      color: brandcolor,
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          postProcessing
                              ? const Center(
                                  child: CircularProgressIndicator(
                                    backgroundColor: Colors.white,
                                  ),
                                )
                              : const Row(
                                  children: [
                                    Icon(
                                      Icons.upload,
                                      size: 35.0,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 15.0,
                                    ),
                                    Text(
                                      "Post",
                                      style: TextStyle(fontSize: 24.0),
                                    )
                                  ],
                                )
                        ]),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
