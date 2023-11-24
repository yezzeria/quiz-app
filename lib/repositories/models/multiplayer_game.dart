class MultiplayerGame {
  final int id;
  final String code;
  final String channel;
  final Duration timePerQuestion;
  final String? hostId;

  MultiplayerGame(
      this.id, this.code, this.channel, this.timePerQuestion, this.hostId);
}
