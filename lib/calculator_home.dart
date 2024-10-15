import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorHome extends StatefulWidget {
  @override
  _CalculatorHomeState createState() => _CalculatorHomeState();
}

class _CalculatorHomeState extends State<CalculatorHome> {
  String _expression = '';
  String _result = '';

  void _onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        _expression = '';
        _result = '';
      } else if (buttonText == '⌫') {
        _expression = _expression.isNotEmpty
            ? _expression.substring(0, _expression.length - 1)
            : '';
      } else if (buttonText == '=') {
        try {
          _result = _calculateExpression(_expression);
        } catch (e) {
          _result = 'Error';
        }
      } else {
        _expression += buttonText;
      }
    });
  }

  String _calculateExpression(String expression) {
    try {
      expression = expression.replaceAll('√', 'sqrt');
      // Further handling for '!' can be added here if using a custom factorial function.
      Parser parser = Parser();
      Expression exp = parser.parse(expression);
      ContextModel contextModel = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, contextModel);
      return eval.toString();
    } catch (e) {
      return 'Error';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(20),
          alignment: Alignment.centerRight,
          child: Text(
            _expression,
            style: TextStyle(fontSize: 24),
          ),
        ),
        Container(
          padding: EdgeInsets.all(20),
          alignment: Alignment.centerRight,
          child: Text(
            _result,
            style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: ['7', '8', '9', '/', '^'].map(_buildButton).toList(),
                ),
                Row(
                  children: ['4', '5', '6', '*', '√'].map(_buildButton).toList(),
                ),
                Row(
                  children: ['1', '2', '3', '-', '!'].map(_buildButton).toList(),
                ),
                Row(
                  children: ['C', '0', '.', '+', '='].map(_buildButton).toList(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildButton(String text) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: ElevatedButton(
          onPressed: () => _onButtonPressed(text),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(15),
          ),
          child: Text(
            text,
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
