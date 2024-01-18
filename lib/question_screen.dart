import 'package:flutter/material.dart';

import 'model/answer_state.dart';
import 'model/question.dart';

class QuestionScreen extends StatelessWidget {
  final Question question;
  final Function(bool correct) onAnswerSelected;
  const QuestionScreen({
    super.key,
    required this.question,
    required this.onAnswerSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        /// because is a know amount of options, otherwise we should use here a list
        /// or an scrollable widget
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: question.answers
              .map((e) => GestureDetector(
                  onTap: () {
                    onAnswerSelected(e == question.correctAnswer);
                  },
                  child: QuestionOptionItem(
                    option: e,
                    correctAnswer: question.correctAnswer,
                    onAnswerStateChanged: (AnswerState answerState) {
                      onAnswerSelected(answerState == AnswerState.correct);
                    },
                  )))
              .toList(),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.width * 0.20,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                color: Colors.white,
                border: Border.all(
                  color: Colors.orange, // Set the border color to blue
                  width: 4.0, // Set the border width
                ),
              ),
              child: Center(child: Text(question.question))),
        )
      ],
    );
  }
}

class QuestionOptionItem extends StatefulWidget {
  final String option;
  final String correctAnswer;
  final Function(AnswerState answerState) onAnswerStateChanged;
  const QuestionOptionItem(
      {super.key,
      required this.option,
      required this.correctAnswer,
      required this.onAnswerStateChanged});

  @override
  State<QuestionOptionItem> createState() => _QuestionOptionItemState();
}

class _QuestionOptionItemState extends State<QuestionOptionItem> {
  AnswerState answerState = AnswerState.unselected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.option == widget.correctAnswer
              ? answerState = AnswerState.correct
              : answerState = AnswerState.wrong;
        });
        widget.onAnswerStateChanged(answerState);
      },
      child: Center(
        child: Container(
          width: itemWidth(),
          height: itemWidth(),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              color: answerState.color),
          padding: const EdgeInsets.all(12),
          child: Container(
            color: Colors.grey,
            child: Center(
              child: Text(widget.option),
            ),
          ),
        ),
      ),
    );
  }

  double itemWidth() => MediaQuery.of(context).size.width * 0.20;
}
