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
  var userCalcInput = '';
  var calcOutput = '0';

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
  void equalButtonPressed() {
    if (userCalcInput.isNotEmpty) {
      String finaluserinput = userCalcInput;
      finaluserinput = userCalcInput.replaceAll(ButtonConstants.multiply, '*');

      Parser p = Parser();
      Expression exp = p.parse(finaluserinput);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);
      calcOutput = eval.toString();
    } else {
      calcOutput = '0';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(8),
                  alignment: Alignment.centerRight,
                  child: Text(
                    userCalcInput,
                    style: const TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(2),
                  alignment: Alignment.centerRight,
                  child: Text(
                    calcOutput,
                    style: const TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ]),
        ),
        Expanded(
          flex: 4,
          child: GridView.builder(
              itemCount: ButtonConstants.buttonItems.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
              ),
              itemBuilder: (BuildContext context, int index) {
                final String buttonText = ButtonConstants.buttonItems[index];

                // Handle Clear Button
                if (buttonText == ButtonConstants.clear) {
                  return CalculatorButton(
                    buttonTapped: () {
                      setState(() {
                        userCalcInput = '';
                        calcOutput = '0';
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
                        userCalcInput += buttonText;
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
                        userCalcInput += buttonText;
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
                        userCalcInput = (userCalcInput.isNotEmpty)
                            ? userCalcInput.substring(
                                0, userCalcInput.length - 1)
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
                        equalButtonPressed();
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
                        userCalcInput += buttonText;
                      });
                    },
                    buttonText: buttonText,
                    bgColor: isOperatorButton(buttonText)
                        ? Colors.blueAccent
                        : Colors.white,
                    fgColor: isOperatorButton(buttonText)
                        ? Colors.white
                        : Colors.black,
                  );
                }
              }),
        ),
      ],
    );
  }
}
