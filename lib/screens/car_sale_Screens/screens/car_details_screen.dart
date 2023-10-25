import 'package:carena/globals/colors.dart';
import 'package:flutter/material.dart';

class CarDetailsPage extends StatelessWidget {
  final List<Map<String, dynamic>> carSpecifications;

  const CarDetailsPage({Key? key, required this.carSpecifications})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String model = ''; // Initialize an empty string for the model label
    for (var spec in carSpecifications) {
      if (spec['label'] == 'Model') {
        model = spec['value'];
        break; // Stop searching once the model label is found
      }
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(model),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              border:
                  Border(bottom: BorderSide(width: 0.2, color: bordercolor))),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Table(
            columnWidths: const {0: IntrinsicColumnWidth()},
            children: List<TableRow>.generate(
              carSpecifications.length,
              (index) {
                final spec = carSpecifications[index];
                return TableRow(
                  children: [
                    TableCell(
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          border: Border.all(), // Add borders to the cell
                        ),
                        child: Text(
                          spec['label'] ?? '',
                          style: const TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment:
                            Alignment.centerLeft, // Align content to the left
                        decoration: BoxDecoration(
                          border: Border.all(), // Add borders to the cell
                        ),
                        child: spec['value'] is bool && spec['value']
                            ? const Icon(Icons.check, color: Colors.green)
                            : Text(spec['value'].toString(),
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  color: bordercolor,
                                )),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
