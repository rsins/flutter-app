import 'package:calculator_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

import './calc_button.dart';

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CalculatorState();
  }
}

class _CalculatorState extends State<Calculator> {
  var _userCalcInput = '';
  var _calcOutput = '0';

  bool isOperatorButton(String buttonStr) {
    return ButtonConstants.buttonOperatorItems.contains(buttonStr);
  }

  // function to handle +/- button
  // void reverseSignButtonPressed() {
  //   if (userCalcInput.isNotEmpty) {
  //     if (userCalcInput.startsWith('-(') && userCalcInput.endsWith(')')) {
  //       userCalcInput = userCalcInput.substring(2, userCalcInput.length - 1);
  //     } else {
  //       userCalcInput = '-(' + userCalcInput + ')';
  //     }
  //     equalButtonPressed();
  //   }
  // }

  // function to calculate the input operation
  void _equalButtonPressed() {
    if (_userCalcInput.isNotEmpty) {
      String finaluserinput = _userCalcInput;
      finaluserinput = _userCalcInput.replaceAll(ButtonConstants.multiply, '*');

      try {
        Parser p = Parser();
        Expression exp = p.parse(finaluserinput);
        ContextModel cm = ContextModel();
        double eval = exp.evaluate(EvaluationType.REAL, cm);
        _calcOutput = eval.toString();
      } catch (ex) {
        _calcOutput = 'Error !';
      }
    } else {
      _calcOutput = '0';
    }
  }

  List<Widget> _buildCalculatorButtons(BuildContext context) {
    return ButtonConstants.buttonItems.map((buttonText) {
      // Handle Clear Button
      if (buttonText == ButtonConstants.clear) {
        return CalculatorButton(
          buttonTapped: () {
            setState(() {
              _userCalcInput = '';
              _calcOutput = '0';
            });
          },
          buttonText: buttonText,
          bgColor: Colors.blue[50],
          fgColor: Colors.black,
        );
      }
      // Handle ( Button
      else if (buttonText == ButtonConstants.startBracket) {
        return CalculatorButton(
          buttonTapped: () {
            setState(() {
              _userCalcInput += buttonText;
            });
          },
          buttonText: buttonText,
          bgColor: Colors.blue[50],
          fgColor: Colors.black,
        );
      }
      // Handle ) Button
      else if (buttonText == ButtonConstants.closeBracket) {
        return CalculatorButton(
          buttonTapped: () {
            setState(() {
              _userCalcInput += buttonText;
            });
          },
          buttonText: buttonText,
          bgColor: Colors.blue[50],
          fgColor: Colors.black,
        );
      }
      // Handle Delete Button
      else if (buttonText == ButtonConstants.delete) {
        return CalculatorButton(
          buttonTapped: () {
            setState(() {
              _userCalcInput = (_userCalcInput.isNotEmpty)
                  ? _userCalcInput.substring(0, _userCalcInput.length - 1)
                  : '';
            });
          },
          buttonText: buttonText,
          bgColor: Colors.blue[50],
          fgColor: Colors.black,
        );
      }
      // Handle Equal Button
      else if (buttonText == ButtonConstants.equal) {
        return CalculatorButton(
          buttonTapped: () {
            setState(() {
              _equalButtonPressed();
            });
          },
          buttonText: buttonText,
          bgColor: Colors.orange[700],
          fgColor: Colors.white,
        );
      }
      // Handle Other Buttons
      else {
        return CalculatorButton(
          buttonTapped: () {
            setState(() {
              _userCalcInput += buttonText;
            });
          },
          buttonText: buttonText,
          bgColor:
              isOperatorButton(buttonText) ? Colors.blueAccent : Colors.white,
          fgColor: isOperatorButton(buttonText) ? Colors.white : Colors.black,
        );
      }
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Container(
            color: const Color(0xAA000000),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(8),
                    alignment: Alignment.centerRight,
                    child: Text(
                      _userCalcInput,
                      style: const TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(2),
                    alignment: Alignment.centerRight,
                    child: Text(
                      _calcOutput,
                      style: const TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ]),
          ),
        ),
        Expanded(
          flex: 4,
          child: GridView.count(
            crossAxisCount: 4,
            shrinkWrap: true,
            children: _buildCalculatorButtons(context),
            childAspectRatio: (MediaQuery.of(context).size.width * 1.25) /
                (MediaQuery.of(context).size.height - 265),
          ),
        ),
      ],
    );
  }
}
