import 'package:carena/screens/car_sale_Screens/widgets/market_page_tab_widget.dart';
import 'package:carena/screens/carhire_services_screens/screens/car_hire_screen.dart';
import 'package:flutter/material.dart';

class MarketPage extends StatefulWidget {
  const MarketPage({Key? key}) : super(key: key);

  @override
  State<MarketPage> createState() => _MarketPageState();
}

class _MarketPageState extends State<MarketPage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: const TabBarView(
        children: [
          MarketPageTabWidget(),
          CarHireScreen(),
        ],
      ),
    );
  }
}
