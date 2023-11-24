class NicknameGenerator {
  final String lang;
  static final _firstRu = ['Разумный', 'Клёвый', 'Лучший', 'Улыбчивый'];
  static final _secondRu = [
    'Король',
    'Компот',
    'Волшебник',
    'Карась',
  ];
  static final _first = ['Trivia', 'Quiz'];
  static final _second = [
    'King',
    'Queen',
    'Titan',
    'Diva',
    'Wizard',
    'Buff',
    'Pro'
  ];

  NicknameGenerator(this.lang);

  String get generateNick {
    if (lang == 'ru') {
      _firstRu.shuffle();
      _secondRu.shuffle();
      return _firstRu.first + ' ' + _secondRu.first;
    } else {
      _first.shuffle();
      _second.shuffle();
      return _first.first + ' ' + _second.first;
    }
  }

  static String get generate {
    _first.shuffle();
    _second.shuffle();
    return _first.first + ' ' + _second.first;
  }
}
