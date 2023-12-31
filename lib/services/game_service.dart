import 'dart:developer';

import 'package:hashids2/hashids2.dart';
import 'package:intl/intl.dart';
import 'package:quiz_app/repositories/models/game_question.dart';
import 'package:quiz_app/repositories/models/game_status.dart';
import 'package:quiz_app/repositories/models/multiplayer_game.dart';
import 'package:quiz_app/repositories/models/player_score.dart';
import 'package:quiz_app/repositories/models/solo_game.dart';
import 'package:quiz_app/repositories/models/trivia_questions.dart';
import 'package:quiz_app/repositories/models/trivia_questions_rus.dart';
import 'package:quiz_app/repositories/trivia_repository.dart';
import 'package:quiz_app/services/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class GameService {
  final AuthService _authService;
  final TriviaRepository _triviaRepository;
  final SupabaseClient _supabaseClient;
  final HashIds _hashIds;

  GameService(this._authService, this._triviaRepository, this._supabaseClient)
      : _hashIds = _initHashIds;

  Future<SoloGame> newSoloGame(int numOfQuestions) async {
    dynamic questions;
    if (Intl.getCurrentLocale() == 'en') {
      questions = await _triviaRepository.getQuestions(numOfQuestions);
    } else {
      final game = await _supabaseClient
          .from('games')
          .insert({
            'host_id': _authService.userUid,
            'seconds_per_question': 8,
          })
          .select()
          .single();
      final gameId = game['id'];
      await getRusQuestions(gameId, numOfQuestions);
    }
    return SoloGame(questions);
  }

  Future<MultiplayerGame> newMultiplayerGame(
      int numOfQuestions, int secondsPerQuestion) async {
    final game = await _supabaseClient
        .from('games')
        .insert({
          'host_id': _authService.userUid,
          'seconds_per_question': secondsPerQuestion,
        })
        .select()
        .single();
    final gameId = game['id'];
    final gameCode = _toGameCode(gameId);
    final channel = game['channel'] as String;
    final questions;
    if (Intl.getCurrentLocale() == 'en') {
      questions = await _triviaRepository.getQuestions(numOfQuestions);
      await _insertGameQuestions(gameId, questions);
    } else {
      await getRusQuestions(gameId, numOfQuestions);
    }
    final hostId = _authService.userUid;
    log('Created game with code $gameCode (ID $gameId) and channel $channel');
    await _joinGame(gameId);
    return MultiplayerGame(gameId, gameCode, channel,
        Duration(seconds: secondsPerQuestion), hostId);
  }

  Future<void> getRusQuestions(int gameId, int numOfQuestions) async {
    final response = await _supabaseClient
        .from('random_difficult_questions')
        .select('*')
        .limit(numOfQuestions);
    final result = response
        .map((q) => TriviaQuestionRus.fromJson(q as Map<String, dynamic>))
        .toList();
    final values = result.map((q) {
      return {
        'game_id': gameId,
        'question': q.question,
        'correct_answer': q.correctAnswer,
        'wrong_answer_1': q.wrongAnswer1,
        'wrong_answer_2': q.wrongAnswer2,
        'wrong_answer_3': q.wrongAnswer3,
      };
    }).toList();
    await _supabaseClient.from('questions').insert(values);
  }

  Future<void> _insertGameQuestions(
      int gameId, List<TriviaQuestion> questions) async {
    final List<Map<String, dynamic>> values = questions.map((q) {
      return {
        'game_id': gameId,
        'question': q.question,
        'correct_answer': q.correctAnswer,
        'wrong_answer_1': q.incorrectAnswers[0],
        'wrong_answer_2': q.incorrectAnswers[1],
        'wrong_answer_3': q.incorrectAnswers[2],
      };
    }).toList();
    await _supabaseClient.from('questions').insert(values);
  }

  Future<void> _insertGameQuestionsRus(
      int gameId, List<TriviaQuestionRus> questions) async {
    final List<Map<String, dynamic>> values = questions.map((q) {
      return {
        'game_id': gameId,
        'question': q.question,
        'correct_answer': q.correctAnswer,
        'wrong_answer_1': q.wrongAnswer1,
        'wrong_answer_2': q.wrongAnswer2,
        'wrong_answer_3': q.wrongAnswer3,
      };
    }).toList();
    await _supabaseClient.from('questions').insert(values);
  }

  Future<MultiplayerGame> joinMultiplayerGame(String gameCode) async {
    final gameId = _toGameId(gameCode);
    log('Searching for game with code $gameCode (ID $gameId)');
    if (gameId == null) {
      throw InvalidGameCodeException('Invalid code');
    }
    final game = await _supabaseClient
        .from('games')
        .select('status,channel,seconds_per_question,host_id')
        .eq('id', gameId)
        .maybeSingle();
    if (game == null) {
      throw InvalidGameCodeException('Invalid code');
    }
    final status = game['status'];
    log('Found game with status $status');
    if (status != 'pending') {
      throw InvalidGameCodeException('Game has already started');
    }
    await _joinGame(gameId);
    return MultiplayerGame(
      gameId,
      gameCode,
      game['channel'],
      Duration(
        seconds: game['seconds_per_question'],
      ),
      _authService.userUid,
    );
  }

  Future updateGameStatus(int gameId, GameStatus status) async {
    await _supabaseClient
        .from('games')
        .update({'status': status.name}).eq('id', gameId);
  }

  Stream<GameStatus> getGameStatus(int gameId) {
    return _supabaseClient
        .from('games')
        .stream(primaryKey: ['id'])
        .eq('id', gameId)
        .map((e) => GameStatus.fromString(e.first['status']));
  }

  Future<List<GameQuestion>> getQuestions(int gameId) async {
    final questions = await _supabaseClient
        .from('questions')
        .select<List<Map<String, dynamic>>>()
        .eq('game_id', gameId);
    return questions.map((q) {
      final incorrectAnswers = <String>[
        q['wrong_answer_1'],
        q['wrong_answer_2'],
        q['wrong_answer_3'],
      ];
      return GameQuestion(
          q['id'], q['question'], q['correct_answer'], incorrectAnswers);
    }).toList();
  }

  Future<void> answerQuestion(int gameId, int questionId, String answer) async {
    await _supabaseClient.from('answers').insert({
      'game_id': gameId,
      'question_id': questionId,
      'answer': answer,
      'user_id': _authService.userUid,
    });
  }

  Stream<List<String>> getCurrentPlayers(int gameId) {
    return _supabaseClient
        .from('players')
        .stream(primaryKey: ['id'])
        .eq('game_id', gameId)
        .map((event) {
          return event.map((e) => e['nickname'] as String).toList();
        });
  }

  Future<List<PlayerScore>> getScores(int gameId) async {
    await Future.delayed(const Duration(seconds: 2));
    final scores = await _supabaseClient.rpc('calculate_scores',
        params: {'game_id_param': gameId}).select<List<Map<String, dynamic>>>();
    log('Player scores for game $gameId: ${scores.join(', ')}');
    return scores.map(PlayerScore.fromJson).toList();
  }

  Future<void> _joinGame(int gameId) async {
    final nickname = _authService.nickname;
    log('Adding $nickname as player in game $gameId');
    await _supabaseClient.from('players').upsert(
      {
        'nickname': nickname,
        'game_id': gameId,
        'user_id': _authService.userUid
      },
      onConflict: 'game_id,user_id',
    );
  }

  String _toGameCode(int gameId) {
    return _hashIds.encode(gameId).padLeft(4, 'a');
  }

  int? _toGameId(String gameCode) {
    final decoded =
        _hashIds.decode(gameCode.replaceAll('O', '0').replaceAll('l', '1'));
    return decoded.isNotEmpty ? decoded.first : null;
  }

  /// Setup an instance of `HashIds`. Removes 'O' and 'l' from the alphabet
  /// as they look too similar to 0 and 1 respectively.
  static HashIds get _initHashIds {
    return HashIds(
      minHashLength: 4,
      alphabet: HashIds.DEFAULT_ALPHABET.replaceAll(RegExp('[Ol]'), ''),
    );
  }
}

class InvalidGameCodeException implements Exception {
  final String message;

  InvalidGameCodeException(this.message);
}
