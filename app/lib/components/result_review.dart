import 'package:flutter/material.dart';

class ResultReview extends StatelessWidget {
  const ResultReview(this.result, {super.key});
  final List<Map<String, Object>> result;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: SingleChildScrollView(
        child: Column(
          children: result.map((i) {
            return Row(
              children: [
                Text(((i['index'] as int) + 1).toString()),
                Expanded(
                  child: Column(
                    children: [
                      Text(i['question'] as String),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(i['answer'] as String),
                      Text(i['userChoice'] as String),
                    ],
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
