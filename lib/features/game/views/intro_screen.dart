import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quiz_app/features/game/views/game_screen.dart';
import 'package:quiz_app/generated/l10n.dart';
import 'package:quiz_app/navigation.dart';
import 'package:quiz_app/services.dart';
import 'package:quiz_app/services/nickname_generator.dart';
import 'package:quiz_app/theme/theme.dart';
import 'package:quiz_app/widgets/app_button.dart';
import 'package:quiz_app/widgets/app_input_field.dart';
import 'package:quiz_app/widgets/app_screen.dart';
import 'package:quiz_app/widgets/fraction.dart';
import 'package:quiz_app/widgets/heading.dart';

@RoutePage()
class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
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
    final nick_generator = NicknameGenerator(Intl.getCurrentLocale());
    final nick = nick_generator.generateNick;
    final _nicknameController = TextEditingController(text: nick);
    return AppScreen(
      isFractionNeeded: false,
      child: Scaffold(
        body: Fraction(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Heading(text: S.of(context).chooseNickname),
              AppInputField(controller: _nicknameController),
              Row(
                children: [
                  Expanded(
                    child: AppButton(
                      label: S.of(context).play,
                      onPressed: () async {
                        await Services.of(context)
                            .authService
                            .signIn(_nicknameController.text);
                        switchScreen(context, const GameScreen(),
                            isFractionNeeded: false);
                      },
                    ),
                  ),
                ],
              ),
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
