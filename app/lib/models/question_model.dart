class QuestionModel {
  QuestionModel(this.question, this.choices) {
    shuffledChoices = shuffleChoices();
  }

  final String question;
  final List<String> choices;
  late List<String> shuffledChoices;

  List<String> shuffleChoices() {
    final newChoices = List.of(choices);
    newChoices.shuffle();
    return newChoices;
  }
}
