import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/features/game/views/multiplayer_game/multiplayer_game_search.dart';
import 'package:quiz_app/features/game/views/multiplayer_game/multiplayer_game_settings.dart';
import 'package:quiz_app/generated/l10n.dart';
import 'package:quiz_app/theme/theme.dart';
import 'package:quiz_app/widgets/app_button.dart';
import 'package:intl/intl.dart';
import 'package:quiz_app/widgets/app_screen.dart';
import 'package:quiz_app/widgets/fraction.dart';

@RoutePage()
class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  void _updateLanguage() {
    setState(() {
      if (Intl.getCurrentLocale() == 'en') {
        S.load(const Locale('ru'));
      } else {
        S.load(const Locale('en'));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppScreen(
      isFractionNeeded: false,
      child: Scaffold(
        body: Fraction(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 32),
                child: Text(
                  S.of(context).quiz,
                  style: TextStyle(
                    fontSize: 40,
                  ),
                ),
              ),
              AppButton.expanded(
                label: S.of(context).joinGame,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => MultiplayerGameSearch(),
                    ),
                  );
                },
              ),
              AppButton.expanded(
                label: S.of(context).hostGame,
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => MultiplayerGameSettings(),
                    ),
                  );
                },
              ),
              // AppButton.expanded(
              //   label: S.of(context).practice,
              //   onPressed: () async {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (_) => SoloGameSettings(),
              //       ),
              //     );
              //   },
              // ),
            ],
          ),
        ),
        floatingActionButton: ElevatedButton(
          onPressed: () {
            _updateLanguage();
            log(Intl.getCurrentLocale());
          },
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(10),
            side: const BorderSide(color: buttonWhite, width: 2),
          ),
          child: const Icon(
            Icons.language,
            size: 30,
          ),
        ),
      ),
    );
  }
}
