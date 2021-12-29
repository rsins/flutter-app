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
          child: Container(
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
        ),
        Expanded(
          flex: 3,
          child: Container(
            child: GridView.builder(
                itemCount: ButtonConstants.buttonItems.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
                itemBuilder: (BuildContext context, int index) {
                  // Clear Button
                  if (index == 0) {
                    return CalculatorButton(
                      buttonTapped: () {
                        setState(() {
                          userInput = '';
                          answer = '0';
                        });
                      },
                      buttonText: ButtonConstants.buttonItems[index],
                      bgColor: Colors.blue[50],
                      fgColor: Colors.black,
                    );
                  }

                  // +/- button
                  else if (index == 1) {
                    return CalculatorButton(
                      buttonTapped: () {},
                      buttonText: ButtonConstants.buttonItems[index],
                      bgColor: Colors.blue[50],
                      fgColor: Colors.black,
                    );
                  }
                  // % Button
                  else if (index == 2) {
                    return CalculatorButton(
                      buttonTapped: () {
                        setState(() {
                          userInput += ButtonConstants.buttonItems[index];
                        });
                      },
                      buttonText: ButtonConstants.buttonItems[index],
                      bgColor: Colors.blue[50],
                      fgColor: Colors.black,
                    );
                  }
                  // Delete Button
                  else if (index == 3) {
                    return CalculatorButton(
                      buttonTapped: () {
                        setState(() {
                          userInput =
                              userInput.substring(0, userInput.length - 1);
                        });
                      },
                      buttonText: ButtonConstants.buttonItems[index],
                      bgColor: Colors.blue[50],
                      fgColor: Colors.black,
                    );
                  }
                  // Equal_to Button
                  else if (index == 18) {
                    return CalculatorButton(
                      buttonTapped: () {
                        setState(() {
                          equalButtonPressed();
                        });
                      },
                      buttonText: ButtonConstants.buttonItems[index],
                      bgColor: Colors.orange[700],
                      fgColor: Colors.white,
                    );
                  }

                  // other buttons
                  else {
                    return CalculatorButton(
                      buttonTapped: () {
                        setState(() {
                          userInput += ButtonConstants.buttonItems[index];
                        });
                      },
                      buttonText: ButtonConstants.buttonItems[index],
                      bgColor:
                          isOperatorButton(ButtonConstants.buttonItems[index])
                              ? Colors.blueAccent
                              : Colors.white,
                      fgColor:
                          isOperatorButton(ButtonConstants.buttonItems[index])
                              ? Colors.white
                              : Colors.black,
                    );
                  }
                }),
          ),
        ),
      ],
    );
  }
}
