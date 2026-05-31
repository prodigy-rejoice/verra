import '../core/enums/player_rank.dart';
import '../core/constants/sui_constants.dart';

class PlayerProfile {
  const PlayerProfile({
    required this.walletAddress,
    required this.repScore,
    required this.wins,
    required this.losses,
    required this.challengesCompleted,
    this.displayName,
    this.avatarUrl,
  });

  final String walletAddress;
  final int repScore;
  final int wins;
  final int losses;
  final int challengesCompleted;
  final String? displayName;
  final String? avatarUrl;

  PlayerRank get rank => PlayerRank.fromScore(repScore);

  int get maxStake => (repScore * SuiConstants.maxStakePercent) ~/ 100;

  int get totalMatches => wins + losses;

  double get winRate {
    if (totalMatches == 0) return 0;
    return wins / totalMatches;
  }

  PlayerProfile copyWith({
    String? walletAddress,
    int? repScore,
    int? wins,
    int? losses,
    int? challengesCompleted,
    String? displayName,
    String? avatarUrl,
  }) {
    return PlayerProfile(
      walletAddress: walletAddress ?? this.walletAddress,
      repScore: repScore ?? this.repScore,
      wins: wins ?? this.wins,
      losses: losses ?? this.losses,
      challengesCompleted: challengesCompleted ?? this.challengesCompleted,
      displayName: displayName ?? this.displayName,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }

  factory PlayerProfile.fromJson(Map<String, dynamic> json) {
    return PlayerProfile(
      walletAddress: json['wallet_address'] as String,
      repScore: json['rep_score'] as int,
      wins: json['wins'] as int,
      losses: json['losses'] as int,
      challengesCompleted: json['challenges_completed'] as int,
      displayName: json['display_name'] as String?,
      avatarUrl: json['avatar_url'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'wallet_address': walletAddress,
      'rep_score': repScore,
      'wins': wins,
      'losses': losses,
      'challenges_completed': challengesCompleted,
      if (displayName != null) 'display_name': displayName,
      if (avatarUrl != null) 'avatar_url': avatarUrl,
    };
  }
}
