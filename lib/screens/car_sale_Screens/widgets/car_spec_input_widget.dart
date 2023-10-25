import 'package:carena/globals/colors.dart';
import 'package:flutter/material.dart';

class CarSpecificationsInput extends StatelessWidget {
  final TextEditingController? controller;
  final String text;
  final String? hintText;
  final bool isSelect;
  final List<String>? selectOptions;
  final dynamic selectedValue;
  final ValueChanged<dynamic>? onChanged; // Update the type here
  final bool isCheckbox; // Add this property

  const CarSpecificationsInput({
    Key? key,
    this.controller,
    required this.text,
    this.hintText,
    this.isSelect = false,
    this.selectOptions,
    this.selectedValue,
    this.onChanged,
    this.isCheckbox = false, // Initialize the property
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 50.0,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: SizedBox(
                width: isCheckbox ? 250.0 : 120.0,
                child: Text(
                  text,
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 25.0),
              child: Text(
                ":",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: isCheckbox
                  ? Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 25.0),
                        child: Transform.scale(
                          scale: 1.7,
                          child: Checkbox(
                            value: selectedValue,
                            checkColor: brandcolor,
                            onChanged: onChanged,
                            visualDensity: VisualDensity.comfortable,

                            // Convert to the correct type
                          ),
                        ),
                      ),
                    )
                  : (isSelect
                      ? DropdownButtonFormField<String>(
                          dropdownColor: brandcolor,
                          value: selectedValue,
                          style: const TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                          decoration: const InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: brandcolor))),
                          items: selectOptions!
                              .map((option) => DropdownMenuItem<String>(
                                    value: option,
                                    child: Text(option),
                                  ))
                              .toList(),
                          onChanged: onChanged, // Convert to the correct type
                        )
                      : TextField(
                          controller: controller,
                          onChanged:
                              onChanged, // Pass the onChanged callback directly
                          decoration: InputDecoration(
                            hintText: hintText,
                            focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: brandcolor)),
                            hintStyle: const TextStyle(fontSize: 18.0),
                            contentPadding: const EdgeInsets.only(left: 10.0),
                          ),
                        )),
            ),
          ],
        ),
      ),
    );
  }
}
