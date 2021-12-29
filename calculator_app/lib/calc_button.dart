import 'package:flutter/material.dart';

// Customized stateless Widget for buttons
class CalculatorButton extends StatelessWidget {
  // declaring variables
  final Color? bgColor;
  final Color? fgColor;
  final String buttonText;
  final void Function() buttonTapped;

  //Constructor
  const CalculatorButton(
      {Key? key,
      required this.bgColor,
      required this.fgColor,
      required this.buttonText,
      required this.buttonTapped})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.4),
      child: Container(
        color: bgColor,
        child: TextButton(
          onPressed: buttonTapped,
          child: Center(
            child: Text(
              buttonText,
              style: TextStyle(
                color: fgColor,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
