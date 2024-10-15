import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CurrencyConverter extends StatefulWidget {
  @override
  _CurrencyConverterState createState() => _CurrencyConverterState();
}

class _CurrencyConverterState extends State<CurrencyConverter> {
  final TextEditingController _inputController = TextEditingController();
  String _fromCurrency = 'USD';
  String _toCurrency = 'EUR';
  double _result = 0;
  bool _isLoading = false;

  final List<String> _currencies = ['USD', 'EUR', 'INR', 'GBP', 'JPY'];

  void _convertCurrency() async {
    setState(() {
      _isLoading = true;
    });

    try {
      String url =
          'https://api.exchangerate-api.com/v4/latest/$_fromCurrency';
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        double rate = data['rates'][_toCurrency];
        double input = double.tryParse(_inputController.text) ?? 0;
        setState(() {
          _result = input * rate;
        });
      } else {
        print('Error fetching exchange rate: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: _inputController,
            decoration: InputDecoration(labelText: 'Enter amount'),
            keyboardType: TextInputType.number,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            DropdownButton<String>(
              value: _fromCurrency,
              items: _currencies
                  .map((currency) => DropdownMenuItem(
                        value: currency,
                        child: Text(currency),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _fromCurrency = value!;
                });
              },
            ),
            Icon(Icons.arrow_forward),
            DropdownButton<String>(
              value: _toCurrency,
              items: _currencies
                  .map((currency) => DropdownMenuItem(
                        value: currency,
                        child: Text(currency),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _toCurrency = value!;
                });
              },
            ),
          ],
        ),
        ElevatedButton(
          onPressed: _convertCurrency,
          child: _isLoading ? CircularProgressIndicator() : Text('Convert'),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Result: $_result $_toCurrency',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ],
    );
  }
}
