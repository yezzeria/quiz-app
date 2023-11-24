import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/features/game/views/solo_game/solo_game_answer_selection.dart';
import 'package:quiz_app/navigation.dart';
import 'package:quiz_app/repositories/models/solo_game.dart';
import 'package:quiz_app/repositories/models/trivia_questions.dart';
import 'package:quiz_app/features/game/views/solo_game/solo_game_score.dart';

@RoutePage()
class SoloGameView extends StatefulWidget {
  final SoloGame game;

  const SoloGameView({Key? key, required this.game}) : super(key: key);

  @override
  State<SoloGameView> createState() => _SoloGameViewState();
}

class _SoloGameViewState extends State<SoloGameView> {
  TriviaQuestion? question;
  String? selectedAnswer;

  @override
  Widget build(BuildContext context) {
    question = question ?? widget.game.nextQuestion!;
    return SoloGameAnswerSelection(
      question: question!,
      selected: selectedAnswer,
      onAnswerSelected: (answer) async {
        setState(() {
          selectedAnswer = answer;
        });
        await Future.delayed(Duration(seconds: 2));
        widget.game.validateAnswer(answer, question!);
        next();
      },
    );
  }

  void next() {
    setState(() {
      final nextQuestion = widget.game.nextQuestion;
      if (nextQuestion != null) {
        setState(() {
          question = nextQuestion;
          selectedAnswer = null;
        });
      } else {
        switchScreen(
          context,
          SoloGameScore(
            correctAnswers: widget.game.correctAnswers,
            totalQuestions: widget.game.totalQuestions,
          ),
        );
      }
    });
  }
}
