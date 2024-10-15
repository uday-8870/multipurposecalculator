import 'package:flutter/material.dart';

class MeasurementConverter extends StatefulWidget {
  @override
  _MeasurementConverterState createState() => _MeasurementConverterState();
}

class _MeasurementConverterState extends State<MeasurementConverter> {
  final TextEditingController _inputController = TextEditingController();
  String _fromUnit = 'Meters';
  String _toUnit = 'Kilometers';
  double _result = 0;

  final Map<String, double> _conversionRates = {
    'Meters': 1.0,
    'Kilometers': 0.001,
    'Miles': 0.000621371,
    'Centimeters': 100.0,
  };

  void _convert() {
    double input = double.tryParse(_inputController.text) ?? 0;
    double fromRate = _conversionRates[_fromUnit]!;
    double toRate = _conversionRates[_toUnit]!;
    setState(() {
      _result = input * (toRate / fromRate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: _inputController,
            decoration: InputDecoration(labelText: 'Enter value to convert'),
            keyboardType: TextInputType.number,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            DropdownButton<String>(
              value: _fromUnit,
              items: _conversionRates.keys
                  .map((unit) => DropdownMenuItem(value: unit, child: Text(unit)))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _fromUnit = value!;
                });
              },
            ),
            Icon(Icons.arrow_forward),
            DropdownButton<String>(
              value: _toUnit,
              items: _conversionRates.keys
                  .map((unit) => DropdownMenuItem(value: unit, child: Text(unit)))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _toUnit = value!;
                });
              },
            ),
          ],
        ),
        ElevatedButton(
          onPressed: _convert,
          child: Text('Convert'),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Result: $_result $_toUnit',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ],
    );
  }
}
