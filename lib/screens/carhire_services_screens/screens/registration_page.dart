import 'dart:typed_data';
import 'package:carena/globals/methods/flush_bar.dart';
import 'package:carena/models/user.dart' as model;
import 'package:carena/screens/car_sale_Screens/widgets/car_spec_input_widget.dart';
import 'package:carena/screens/carhire_services_screens/methods/firebase.dart';
import 'package:image_picker/image_picker.dart';
import 'package:carena/providers/user_provider.dart';
import 'package:provider/provider.dart';

import 'package:carena/globals/colors.dart';
import 'package:carena/globals/methods/image_picker.dart';
import 'package:flutter/material.dart';

class CarHireRegistrationPage extends StatefulWidget {
  const CarHireRegistrationPage({super.key});

  @override
  State<CarHireRegistrationPage> createState() =>
      _CarHireRegistrationPageState();
}

class _CarHireRegistrationPageState extends State<CarHireRegistrationPage> {
  final TextEditingController _makeController = TextEditingController();
  final TextEditingController _modelController = TextEditingController();
  final TextEditingController _pricePerDayController = TextEditingController();
  final TextEditingController _vinController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  List<Uint8List> selectedImages = [];
  List<Map<String, dynamic>> carspecifications = [];

  bool isLoading = false;

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
    dynamic value,
  ) {
    Map<String, dynamic> specification = {
      'label': label,
      'value': value,
    };
    return specification;
  }

  @override
  void dispose() {
    _makeController.dispose();
    _modelController.dispose();
    _pricePerDayController.dispose();
    _vinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    model.User user = Provider.of<UserProvider>(context).getUser;
    return GestureDetector(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: darkmodecolor,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 0.2, color: bordercolor),
              ),
            ),
          ),
          title: const Text("Register your car"),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 10.0,
          ),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: InkWell(
                          onTap: selectCarImagesToPost,
                          child: Row(
                            children: [
                              const Icon(
                                Icons.photo,
                                size: 35.0,
                                color: brandcolor,
                              ),
                              const SizedBox(
                                width: 20.0,
                              ),
                              Text(
                                selectedImages.isNotEmpty
                                    ? "${selectedImages.length} Images selected"
                                    : "Select up to 4 images",
                                style: const TextStyle(fontSize: 18.0),
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
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
                        child: Container(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: 0.5,
                                color: bordercolor,
                              ),
                            ),
                          ),
                          child: const Row(
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
                                "Hire Details",
                                style: TextStyle(
                                    fontSize: 20.0,
                                    color: brandcolor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          CarSpecificationsInput(
                            text: 'Make',
                            hintText: 'Toyota',
                            controller: _makeController,
                          ),
                          CarSpecificationsInput(
                            text: 'Model',
                            hintText: 'Premio',
                            controller: _modelController,
                          ),
                          CarSpecificationsInput(
                            text: 'VIN',
                            hintText: 'Reg. number',
                            controller: _vinController,
                          ),
                          CarSpecificationsInput(
                            text: 'Location',
                            hintText: 'location',
                            controller: _locationController,
                          ),
                          CarSpecificationsInput(
                            text: 'Price/Day',
                            hintText: 'ksh',
                            controller: _pricePerDayController,
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Container(
                              height: 50.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40.0),
                                  color: Colors.white),
                              child: const Center(
                                child: Text(
                                  "4500 kes (Registration fee)",
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              setState(() {
                                isLoading = true;
                              });
                              var res = await CarhireFirestoreMethods()
                                  .registerCarforHire(
                                user.username,
                                user.uid,
                                _pricePerDayController.text,
                                _makeController.text,
                                _modelController.text,
                                _locationController.text,
                                _vinController.text,
                                selectedImages,
                              );

                              if (res == "success") {
                                setState(() {
                                  isLoading = false;
                                  selectedImages = [];
                                  _makeController.text = "";
                                  _modelController.text = "";
                                  _vinController.text = "";
                                  _locationController.text = "";
                                  _pricePerDayController.text = "";
                                });
                              }

                              showNotificationBar(
                                context,
                                "registered car successfully",
                                Icons.check,
                                brandcolor,
                              );
                            },
                            child: Container(
                              height: 50.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40.0),
                                color: Colors.white10,
                              ),
                              child: Center(
                                child: isLoading
                                    ? const CircularProgressIndicator(
                                        value: 24.0,
                                        color: Colors.white,
                                      )
                                    : const Text(
                                        "Register your car",
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.white60,
                                            fontWeight: FontWeight.bold),
                                      ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20.0,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
