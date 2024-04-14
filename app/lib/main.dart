import 'package:flutter/material.dart';
import 'package:app/gradient_container.dart';

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
          backgroundColor: Colors.cyan,
          body: GradientContainer(
              colorTopLeft: Colors.blue, colorBtmRight: Colors.green)),
    ),
  );
}
