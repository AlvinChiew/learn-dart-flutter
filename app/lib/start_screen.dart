import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  const StartScreen(this.switchScreen, {super.key});
  final void Function() switchScreen;

  @override
  Widget build(context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/quiz-logo.png',
            width: 300,
            color: const Color.fromARGB(100, 255, 255, 255),
          ),
          const SizedBox(height: 80),
          const Text(
            'Have fun taking Flutter challenge!',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 80),
          OutlinedButton.icon(
            onPressed: switchScreen,
            style: OutlinedButton.styleFrom(foregroundColor: Colors.white),
            label: const Text('Start Quiz'),
            icon: const Icon(Icons.arrow_right_alt),
          )
        ],
      ),
    );
  }
}
