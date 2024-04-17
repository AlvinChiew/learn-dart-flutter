import 'package:flutter/material.dart';
import 'package:app/components/result_review.dart';
import 'package:app/data/questions.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen(
      {super.key,
      required this.selectedChoices,
      required this.switchToQuestionScreen});
  final List<String> selectedChoices;
  final void Function() switchToQuestionScreen;

  List<Map<String, Object>> get markedAnswers {
    List<Map<String, Object>> result = [];
    for (int i = 0; i < selectedChoices.length; i++) {
      result.add({
        'index': i,
        'question': questions[i].question,
        'answer': questions[i].choices[0],
        'userChoice': selectedChoices[i]
      });
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    int totalAnswers = questions.length;
    int correctAnswers =
        markedAnswers.where((i) => i['answer'] == i['userChoice']).length;

    return SizedBox(
      // alternative to Center
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                'You answered $correctAnswers out of $totalAnswers questions correctly!'),
            const SizedBox(height: 30),
            ResultReview(markedAnswers),
            const SizedBox(height: 30),
            TextButton(
                onPressed: switchToQuestionScreen,
                child: const Text('Restart Quiz'))
          ],
        ),
      ),
    );
  }
}
