import 'dart:js';

import 'package:flutter/material.dart';

import './calculator.dart';
import './constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: const Text("About this app"),
          content: const Text("Created by @rsins"),
          actions: <Widget>[
            TextButton(
              child: const Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _handleAppMenuClick(BuildContext context, String value) {
    switch (value) {
      case Constants.menuAbout:
        _showAboutDialog(context);
        break;
    }
  }

  PopupMenuButton<String> _buildAppMenu(BuildContext context) {
    return PopupMenuButton<String>(
      itemBuilder: (context) {
        return Constants.menuItems.map((String choice) {
          return PopupMenuItem<String>(
            value: choice,
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _handleAppMenuClick(context, choice);
              },
              child: Text(choice),
            ),
          );
        }).toList();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Calculator'),
          actions: <Widget>[
            _buildAppMenu(context),
          ],
        ),
        body: const Calculator(),
      ),
    );
  }
}
