class Question {
  final String question;
  final List<String> answers;
  final String correctAnswer;

  Question(
      {required this.question,
      required this.answers,
      required this.correctAnswer});
}

class Team {
  final String name;
  late int points;

  Team({
    required this.name,
    required this.points,
  });
}

/// this should go to the correct place depending of the
/// repositories arch used
List<Question> generateQuestions() {
  return [
    Question(
        question: 'Who has fur?',
        answers: ['dog', 'frog', 'fish', 'snake'],
        correctAnswer: 'dog'),
    Question(
        question: 'Where can you find a fish?',
        answers: ['mountain', 'river', 'tree', 'desert'],
        correctAnswer: 'river'),
    Question(
        question: 'Do they fly?',
        answers: ['dog', 'frog', 'bird', 'snake'],
        correctAnswer: 'bird'),
    Question(
        question: 'Do they have fluffy tail?',
        answers: ['bird', 'frog', 'fish', 'cat'],
        correctAnswer: 'cat'),
  ];
}
