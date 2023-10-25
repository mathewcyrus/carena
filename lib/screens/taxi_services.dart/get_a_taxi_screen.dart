import 'package:flutter/material.dart';

class TaxiPage extends StatefulWidget {
  const TaxiPage({super.key});

  @override
  State<TaxiPage> createState() => _TaxiPageState();
}

class _TaxiPageState extends State<TaxiPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Taxi"),
      ),
    );
  }
}
