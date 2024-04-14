import 'package:flutter/material.dart';
import 'package:app/styled_text.dart';

class GradientContainer extends StatelessWidget {
  const GradientContainer(
      {super.key, required this.colorTopLeft, required this.colorBtmRight});
  final Color colorTopLeft;
  final Color colorBtmRight;

  @override
  Widget build(context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [colorTopLeft, colorBtmRight],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight),
      ),
      child: const Center(
        child: StyledText('Hello World!'),
      ),
    );
  }
}
