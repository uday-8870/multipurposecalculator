import 'package:flutter/material.dart';
import 'calculator_home.dart';
import 'measurement_converter.dart';
import 'currency_converter.dart';

void main() {
  runApp(MultiToolCalculator());
}

class MultiToolCalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'scical',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
      ),
      home: MultiToolHome(),
    );
  }
}

class MultiToolHome extends StatefulWidget {
  @override
  _MultiToolHomeState createState() => _MultiToolHomeState();
}

class _MultiToolHomeState extends State<MultiToolHome> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    CalculatorHome(),
    MeasurementConverter(),
    CurrencyConverter(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('scical'),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate),
            label: 'Calculator',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.straighten),
            label: 'Measurement Converter',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sync),
            label: 'Currency Converter',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
