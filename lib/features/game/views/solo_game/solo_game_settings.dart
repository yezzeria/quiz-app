import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/features/game/views/solo_game/solo_game_view.dart';
import 'package:quiz_app/generated/l10n.dart';
import 'package:quiz_app/navigation.dart';
import 'package:quiz_app/repositories/models/solo_game.dart';
import 'package:quiz_app/services.dart';
import 'package:quiz_app/widgets/app_button.dart';
import 'package:quiz_app/widgets/app_input_field.dart';
import 'package:quiz_app/widgets/app_screen.dart';
import 'package:quiz_app/widgets/heading.dart';
import 'package:quiz_app/widgets/screen_loader.dart';

@RoutePage()
class SoloGameSettings extends StatelessWidget {
  final numOfQuestionsController = TextEditingController(text: '5');

  SoloGameSettings({Key? key}) : super(key: key);

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
          AppButton.expanded(
            label: S.of(context).startGame,
            onPressed: () async {
              final numOfQuestions =
                  int.tryParse(numOfQuestionsController.text) ?? 5;
              switchScreen(
                context,
                ScreenLoader<SoloGame>(
                  future: Services.of(context)
                      .gameService
                      .newSoloGame(numOfQuestions),
                  builder: (context, game) {
                    return SoloGameView(game: game);
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
