import 'package:flutter/material.dart';
import 'package:quiz_app/features/game/views/multiplayer_game/multiplayer_game_player_intro.dart';
import 'package:quiz_app/generated/l10n.dart';
import 'package:quiz_app/navigation.dart';
import 'package:quiz_app/services.dart';
import 'package:quiz_app/services/game_service.dart';
import 'package:quiz_app/widgets/app_button.dart';
import 'package:quiz_app/widgets/app_input_field.dart';
import 'package:quiz_app/widgets/app_screen.dart';
import 'package:quiz_app/widgets/heading.dart';

class MultiplayerGameSearch extends StatelessWidget {
  final _gameCodeController = TextEditingController();

  MultiplayerGameSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScreen(
      isFractionNeeded: true,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Heading(text: S.of(context).enterGameCode),
          AppInputField(controller: _gameCodeController),
          const SizedBox(height: 8.0),
          AppButton.expanded(
            label: S.of(context).joinGame,
            onPressed: () async {
              try {
                final gameService = Services.of(context).gameService;
                final game = await gameService
                    .joinMultiplayerGame(_gameCodeController.text);
                switchScreen(
                  context,
                  MultiplayerGamePlayerIntro(
                    game: game,
                    gameService: gameService,
                  ),
                );
              } on InvalidGameCodeException catch (ex) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      ex.message.toUpperCase() + '.',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Colors.black),
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
