import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String _input = ""; // Stores the input
  String _result = "0"; // Stores the result
  String _operator = ""; // Stores the current operator
  double? _firstOperand; // First operand

  void _onButtonPressed(String value) {
    setState(() {
      if (value == "AC") {
        _input = "";
        _result = "0";
        _operator = "";
        _firstOperand = null;
      } else if (value == "\u232B") {
        // Backspace
        if (_input.isNotEmpty) {
          _input = _input.substring(0, _input.length - 1);
        }
      } else if (value == "=") {
        if (_firstOperand != null && _operator.isNotEmpty) {
          double secondOperand = double.tryParse(_input) ?? 0;
          switch (_operator) {
            case "+":
              _result = (_firstOperand! + secondOperand).toString();
              break;
            case "-":
              _result = (_firstOperand! - secondOperand).toString();
              break;
            case "x":
              _result = (_firstOperand! * secondOperand).toString();
              break;
            case "\u00F7":
              if (secondOperand != 0) {
                _result = (_firstOperand! / secondOperand).toString();
              } else {
                _result = "Error";
              }
              break;
          }
          _input = "";
          _operator = "";
          _firstOperand = null;
        }
      } else if (["+", "-", "x", "\u00F7"].contains(value)) {
        if (_input.isNotEmpty) {
          _firstOperand = double.tryParse(_input);
          _operator = value;
          _input = "";
        }
      } else {
        // Append numbers or symbols
        _input += value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculator"),
      ),
      body: Column(
        children: [
          // Display Area
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.all(20),
              alignment: Alignment.bottomRight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    _input,
                    style: const TextStyle(fontSize: 30, color: Colors.black54),
                  ),
                  Text(
                    _result,
                    style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          // Buttons Area
          Expanded(
            flex: 5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ...[
                  ["AC", "\u232B", "+/-", "\u00F7"],
                  ["7", "8", "9", "x"],
                  ["4", "5", "6", "-"],
                  ["1", "2", "3", "+"],
                  ["%", "0", ".", "="],
                ].map(
                      (row) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: row.map((btn) {
                      bool isOperator = ["AC", "\u232B", "+/-", "\u00F7", "x", "-", "+", "="].contains(btn);
                      return GestureDetector(
                        onTap: () => _onButtonPressed(btn),
                        child: Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            color: isOperator ? Colors.blue : Colors.grey[200],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: btn == "\u232B"
                                ? const Icon(Icons.backspace, color: Colors.white)
                                : Text(
                              btn,
                              style: TextStyle(
                                fontSize: 30,
                                color: isOperator ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
