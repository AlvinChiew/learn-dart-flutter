// import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:app/screens/question_screen.dart';
import 'package:app/screens/start_screen.dart';
import 'package:app/screens/result_screen.dart';
import 'package:app/data/questions.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() {
    return _Quiz();
  }
}

class _Quiz extends State<Quiz> {
  Widget? activeScreen;
  List<String> _selectedChoices = [];

  @override
  void initState() {
    activeScreen = StartScreen(switchToQuestionScreen);
    super.initState();
  }

  void switchToResultScreen(choice) {
    _selectedChoices.add(choice);
    if (_selectedChoices.length == questions.length) {
      setState(() {
        activeScreen = ResultScreen(
            selectedChoices: _selectedChoices,
            switchToQuestionScreen: switchToQuestionScreen);
      });
    }
  }

  void switchToQuestionScreen() {
    setState(() {
      _selectedChoices = [];
      activeScreen = QuestionScreen(switchToResultScreen);
    });
  }

  @override
  Widget build(content) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 5, 83, 146),
                Color.fromARGB(255, 0, 79, 89),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: activeScreen,
        ),
      ),
    );
  }
}
