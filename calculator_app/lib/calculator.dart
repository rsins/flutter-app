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
  var userInput = '';
  var answer = '';

  bool isOperatorButton(String buttonStr) {
    if (ButtonConstants.buttonOperatorItems.contains(buttonStr)) {
      return true;
    }
    return false;
  }

// function to calculate the input operation
  void equalButtonPressed() {
    String finaluserinput = userInput;
    finaluserinput = userInput.replaceAll(ButtonConstants.multiply, '*');

    Parser p = Parser();
    Expression exp = p.parse(finaluserinput);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    answer = eval.toString();
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
                  padding: const EdgeInsets.all(20),
                  alignment: Alignment.centerRight,
                  child: Text(
                    userInput,
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(15),
                  alignment: Alignment.centerRight,
                  child: Text(
                    answer,
                    style: const TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ]),
        ),
        Expanded(
          flex: 3,
          child: GridView.builder(
              itemCount: ButtonConstants.buttonItems.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4),
              itemBuilder: (BuildContext context, int index) {
                final String buttonText = ButtonConstants.buttonItems[index];

                // Handle Clear Button
                if (buttonText == ButtonConstants.clear) {
                  return CalculatorButton(
                    buttonTapped: () {
                      setState(() {
                        userInput = '';
                        answer = '0';
                      });
                    },
                    buttonText: buttonText,
                    bgColor: Colors.blue[50],
                    fgColor: Colors.black,
                  );
                }
                // Handle +/- Button
                else if (buttonText == ButtonConstants.reverseSign) {
                  return CalculatorButton(
                    buttonTapped: () {},
                    buttonText: buttonText,
                    bgColor: Colors.blue[50],
                    fgColor: Colors.black,
                  );
                }
                // Handle % Button
                else if (buttonText == ButtonConstants.percent) {
                  return CalculatorButton(
                    buttonTapped: () {
                      setState(() {
                        userInput += buttonText;
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
                        userInput =
                            userInput.substring(0, userInput.length - 1);
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
                        userInput += buttonText;
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
