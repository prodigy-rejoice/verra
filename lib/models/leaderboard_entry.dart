import '../core/enums/player_rank.dart';

class LeaderboardEntry {
  const LeaderboardEntry({
    required this.rankPosition,
    required this.walletAddress,
    required this.repScore,
    required this.wins,
    required this.losses,
    this.displayName,
    this.avatarUrl,
  });

  final int rankPosition;
  final String walletAddress;
  final int repScore;
  final int wins;
  final int losses;
  final String? displayName;
  final String? avatarUrl;

  PlayerRank get tier => PlayerRank.fromScore(repScore);

  LeaderboardEntry copyWith({
    int? rankPosition,
    String? walletAddress,
    int? repScore,
    int? wins,
    int? losses,
    String? displayName,
    String? avatarUrl,
  }) {
    return LeaderboardEntry(
      rankPosition: rankPosition ?? this.rankPosition,
      walletAddress: walletAddress ?? this.walletAddress,
      repScore: repScore ?? this.repScore,
      wins: wins ?? this.wins,
      losses: losses ?? this.losses,
      displayName: displayName ?? this.displayName,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }

  factory LeaderboardEntry.fromJson(Map<String, dynamic> json) {
    return LeaderboardEntry(
      rankPosition: json['rank_position'] as int,
      walletAddress: json['wallet_address'] as String,
      repScore: json['rep_score'] as int,
      wins: json['wins'] as int,
      losses: json['losses'] as int,
      displayName: json['display_name'] as String?,
      avatarUrl: json['avatar_url'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rank_position': rankPosition,
      'wallet_address': walletAddress,
      'rep_score': repScore,
      'wins': wins,
      'losses': losses,
      if (displayName != null) 'display_name': displayName,
      if (avatarUrl != null) 'avatar_url': avatarUrl,
    };
  }
}
