import 'package:flutter/material.dart';

class ChoicesBtn extends StatelessWidget {
  const ChoicesBtn(this.choice, this.onClick, {super.key});
  final String choice;
  final void Function() onClick;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          )),
      onPressed: onClick,
      child: Text(
        choice,
        textAlign: TextAlign.center,
      ),
    );
  }
}
