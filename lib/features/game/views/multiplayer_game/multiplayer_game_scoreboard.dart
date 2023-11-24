import 'package:flutter/material.dart';
import 'package:quiz_app/generated/l10n.dart';
import 'package:quiz_app/repositories/models/player_score.dart';
import 'package:quiz_app/theme/theme.dart';

class MultiplayerGameScoreboard extends StatelessWidget {
  final List<PlayerScore> scores;
  final String userId;

  const MultiplayerGameScoreboard({
    Key? key,
    required this.scores,
    required this.userId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int currentScore = -1;
    int rank = 0;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(S.of(context).results,
              style: Theme.of(context).textTheme.headlineMedium),
        ),
        ...scores.map(
          (score) {
            final lineStyle =
                TextStyle(color: score.userId == userId ? buttonWhite : null);
            if (score.score != currentScore) {
              currentScore = score.score;
              rank++;
            }
            return ListTile(
              title: Text(
                '$rank. ${score.nickname}',
                style: lineStyle,
              ),
              trailing: Text(score.score.toString(), style: lineStyle),
            );
          },
        ),
      ],
    );
  }
}
