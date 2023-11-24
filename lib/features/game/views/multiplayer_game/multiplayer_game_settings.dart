import 'package:flutter/material.dart';
import 'package:quiz_app/features/game/views/multiplayer_game/multiplayer_game_host_intro.dart';
import 'package:quiz_app/generated/l10n.dart';
import 'package:quiz_app/navigation.dart';
import 'package:quiz_app/services.dart';
import 'package:quiz_app/widgets/app_button.dart';
import 'package:quiz_app/widgets/app_input_field.dart';
import 'package:quiz_app/widgets/app_screen.dart';
import 'package:quiz_app/widgets/heading.dart';
import 'package:quiz_app/widgets/screen_loader.dart';

class MultiplayerGameSettings extends StatelessWidget {
  final numOfQuestionsController = TextEditingController(text: '5');
  final secondsPerQuestionController = TextEditingController(text: '8');

  MultiplayerGameSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScreen(
      isFractionNeeded: true,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Heading(text: S.of(context).numberOfQuestions),
          AppInputField.number(
            controller: numOfQuestionsController,
          ),
          const SizedBox(height: 8.0),
          Heading(text: S.of(context).secondsToAnswer),
          AppInputField.number(
            controller: secondsPerQuestionController,
          ),
          const SizedBox(height: 8.0),
          AppButton.expanded(
            label: S.of(context).createGame,
            onPressed: () async {
              final numOfQuestions =
                  int.tryParse(numOfQuestionsController.text) ?? 5;
              final secondsToAnswer =
                  int.tryParse(secondsPerQuestionController.text) ?? 8;

              switchScreen(
                context,
                ScreenLoader(
                  future: Services.of(context)
                      .gameService
                      .newMultiplayerGame(numOfQuestions, secondsToAnswer),
                  builder: (context, game) =>
                      MultiplayerGameHostIntro(game: game),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
