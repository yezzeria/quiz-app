import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:quiz_app/features/game/views/multiplayer_game/multiplayer_game_view.dart';
import 'package:quiz_app/generated/l10n.dart';
import 'package:quiz_app/navigation.dart';
import 'package:quiz_app/repositories/models/game_status.dart';
import 'package:quiz_app/repositories/models/multiplayer_game.dart';
import 'package:quiz_app/services.dart';
import 'package:quiz_app/theme/theme.dart';
import 'package:quiz_app/widgets/app_button.dart';
import 'package:quiz_app/widgets/players_in_game.dart';

class MultiplayerGameHostIntro extends StatelessWidget {
  final MultiplayerGame game;

  const MultiplayerGameHostIntro({Key? key, required this.game})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            S.of(context).gameCode,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            game.code,
            style: Theme.of(context)
                .textTheme
                .displayLarge
                ?.copyWith(color: buttonWhite),
          ),
        ),
        PlayersInGame(gameId: game.id),
        const SizedBox(height: 24.0),
        AppButton.expanded(
          label: S.of(context).startGame,
          onPressed: () async {
            final gameService = Services.of(context).gameService;
            await gameService.updateGameStatus(game.id, GameStatus.started);
            log('Game ${game.id} started');
            final questions = await gameService.getQuestions(game.id);
            switchScreen(
              context,
              MultiplayerGameView(game: game, questions: questions),
            );
          },
        ),
      ],
    );
  }
}
