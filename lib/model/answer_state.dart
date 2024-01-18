import 'package:flutter/material.dart';

enum AnswerState { unselected, wrong, correct }

extension AnswerStateExtension on AnswerState {
  Color get color {
    switch (this) {
      case AnswerState.unselected:
        return Colors.white;
      case AnswerState.wrong:
        return Colors.red;
      case AnswerState.correct:
        return Colors.green;
    }
  }
}
