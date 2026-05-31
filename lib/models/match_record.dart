import '../core/enums/challenge_type.dart';

class MatchRecord {
  const MatchRecord({
    required this.id,
    required this.winner,
    required this.loser,
    required this.repTransferred,
    required this.gameType,
    required this.timestamp,
  });

  final String id;
  final String winner;
  final String loser;
  final int repTransferred;
  final ChallengeType gameType;
  final DateTime timestamp;

  bool didPlayerWin(String walletAddress) => winner == walletAddress;

  MatchRecord copyWith({
    String? id,
    String? winner,
    String? loser,
    int? repTransferred,
    ChallengeType? gameType,
    DateTime? timestamp,
  }) {
    return MatchRecord(
      id: id ?? this.id,
      winner: winner ?? this.winner,
      loser: loser ?? this.loser,
      repTransferred: repTransferred ?? this.repTransferred,
      gameType: gameType ?? this.gameType,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  factory MatchRecord.fromJson(Map<String, dynamic> json) {
    return MatchRecord(
      id: json['id'] as String,
      winner: json['winner'] as String,
      loser: json['loser'] as String,
      repTransferred: json['rep_transferred'] as int,
      gameType: ChallengeType.fromKey(json['game_type'] as String),
      timestamp: DateTime.fromMillisecondsSinceEpoch(json['timestamp'] as int),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'winner': winner,
      'loser': loser,
      'rep_transferred': repTransferred,
      'game_type': gameType.key,
      'timestamp': timestamp.millisecondsSinceEpoch,
    };
  }
}
