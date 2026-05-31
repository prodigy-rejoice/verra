import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/sui_constants.dart';

enum PlayerRank {
  rookie,
  bronze,
  silver,
  gold,
  legend;

  static PlayerRank fromScore(int score) {
    if (score <= SuiConstants.rankRookieMax) return PlayerRank.rookie;
    if (score <= SuiConstants.rankBronzeMax) return PlayerRank.bronze;
    if (score <= SuiConstants.rankSilverMax) return PlayerRank.silver;
    if (score <= SuiConstants.rankGoldMax) return PlayerRank.gold;
    return PlayerRank.legend;
  }

  String get displayName {
    switch (this) {
      case PlayerRank.rookie:
        return 'Rookie';
      case PlayerRank.bronze:
        return 'Bronze';
      case PlayerRank.silver:
        return 'Silver';
      case PlayerRank.gold:
        return 'Gold';
      case PlayerRank.legend:
        return 'Legend';
    }
  }

  Color get color {
    switch (this) {
      case PlayerRank.rookie:
        return AppColors.rankRookie;
      case PlayerRank.bronze:
        return AppColors.rankBronze;
      case PlayerRank.silver:
        return AppColors.rankSilver;
      case PlayerRank.gold:
        return AppColors.rankGold;
      case PlayerRank.legend:
        return AppColors.rankLegend;
    }
  }
}
