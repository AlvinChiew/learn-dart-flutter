import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app/components/choices_btn.dart';
import 'package:app/data/questions.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen(this.storeChoice, {super.key});

  final void Function(String choice) storeChoice;

  @override
  State<QuestionScreen> createState() {
    return _QuestionScreen();
  }
}

class _QuestionScreen extends State<QuestionScreen> {
  int currQuestionIdx = 0;
  void clickChoice(String selectedChoice) {
    widget.storeChoice(selectedChoice);
    setState(() {
      currQuestionIdx++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = questions[currQuestionIdx];

    return SizedBox(
      // alternative to Center
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              currentQuestion.question,
              style: GoogleFonts.lato(
                color: const Color.fromARGB(234, 154, 204, 246),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            ...currentQuestion.shuffledChoices.map((i) {
              return ChoicesBtn(i, () {
                clickChoice(i);
              });
            })
          ],
        ),
      ),
    );
  }
}
