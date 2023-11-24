import 'package:flutter/material.dart';
import 'package:quiz_app/generated/l10n.dart';
import 'package:quiz_app/services.dart';
import 'package:quiz_app/widgets/heading.dart';

class PlayersInGame extends StatelessWidget {
  final int gameId;

  const PlayersInGame({Key? key, required this.gameId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<String>>(
      stream: Services.of(context).gameService.getCurrentPlayers(gameId),
      initialData: const [],
      builder: (context, snapshot) {
        final players = snapshot.data ?? [];
        return Column(
          children: [
            const SizedBox(height: 12.0),
            Heading(text: S.of(context).players),
            const SizedBox(height: 12.0),
            ...players.map((nickname) => Text(
                  nickname,
                  style: Theme.of(context).textTheme.bodySmall,
                )),
            Text(
              '...?',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        );
      },
    );
  }
}
