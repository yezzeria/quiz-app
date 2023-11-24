// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Quiz app`
  String get quizApp {
    return Intl.message(
      'Quiz app',
      name: 'quizApp',
      desc: '',
      args: [],
    );
  }

  /// `Join game`
  String get joinGame {
    return Intl.message(
      'Join game',
      name: 'joinGame',
      desc: '',
      args: [],
    );
  }

  /// `Host game`
  String get hostGame {
    return Intl.message(
      'Host game',
      name: 'hostGame',
      desc: '',
      args: [],
    );
  }

  /// `Practice`
  String get practice {
    return Intl.message(
      'Practice',
      name: 'practice',
      desc: '',
      args: [],
    );
  }

  /// `Choose nickname`
  String get chooseNickname {
    return Intl.message(
      'Choose nickname',
      name: 'chooseNickname',
      desc: '',
      args: [],
    );
  }

  /// `Play`
  String get play {
    return Intl.message(
      'Play',
      name: 'play',
      desc: '',
      args: [],
    );
  }

  /// `Quiz`
  String get quiz {
    return Intl.message(
      'Quiz',
      name: 'quiz',
      desc: '',
      args: [],
    );
  }

  /// `Number of questions`
  String get numberOfQuestions {
    return Intl.message(
      'Number of questions',
      name: 'numberOfQuestions',
      desc: '',
      args: [],
    );
  }

  /// `Start game`
  String get startGame {
    return Intl.message(
      'Start game',
      name: 'startGame',
      desc: '',
      args: [],
    );
  }

  /// `QUIZ COMPLETED`
  String get quizCompleted {
    return Intl.message(
      'QUIZ COMPLETED',
      name: 'quizCompleted',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get back {
    return Intl.message(
      'Back',
      name: 'back',
      desc: '',
      args: [],
    );
  }

  /// `Seconds to answer`
  String get secondsToAnswer {
    return Intl.message(
      'Seconds to answer',
      name: 'secondsToAnswer',
      desc: '',
      args: [],
    );
  }

  /// `Create game`
  String get createGame {
    return Intl.message(
      'Create game',
      name: 'createGame',
      desc: '',
      args: [],
    );
  }

  /// `Calculating...`
  String get calculating {
    return Intl.message(
      'Calculating...',
      name: 'calculating',
      desc: '',
      args: [],
    );
  }

  /// `Enter game code`
  String get enterGameCode {
    return Intl.message(
      'Enter game code',
      name: 'enterGameCode',
      desc: '',
      args: [],
    );
  }

  /// `Results`
  String get results {
    return Intl.message(
      'Results',
      name: 'results',
      desc: '',
      args: [],
    );
  }

  /// `Waiting for host to start the game...`
  String get waitingForHostToStartTheGame {
    return Intl.message(
      'Waiting for host to start the game...',
      name: 'waitingForHostToStartTheGame',
      desc: '',
      args: [],
    );
  }

  /// `GAME CODE`
  String get gameCode {
    return Intl.message(
      'GAME CODE',
      name: 'gameCode',
      desc: '',
      args: [],
    );
  }

  /// `Players`
  String get players {
    return Intl.message(
      'Players',
      name: 'players',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ru'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
