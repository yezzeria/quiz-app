import 'package:quiz_app/repositories/trivia_repository.dart';
import 'package:quiz_app/secrets.dart';
import 'package:quiz_app/services/auth_service.dart';
import 'package:quiz_app/services/game_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Dependencies {
  final AuthService authService;
  final GameService gameService;

  Dependencies._(this.authService, this.gameService);

  static Future<Dependencies> get init async {
    final supabase = await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseAnonKey,
    );
    final sharedPreferences = await SharedPreferences.getInstance();
    final authService = AuthService(supabase.client.auth, sharedPreferences);
    final gameService =
        GameService(authService, TriviaRepository(), supabase.client);
    // final scores = await supabase.client.rpc('calculate_scores',
    //     params: {'game_id_param': 23}).select<List<Map<String, dynamic>>>();
    // log('Player scores for game 23: ${scores.join(', ')}');
    return Dependencies._(authService, gameService);
  }
}
