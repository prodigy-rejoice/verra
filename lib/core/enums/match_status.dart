enum MatchStatus {
  searching,
  pairing,
  inProgress,
  submitting,
  completed,
  cancelled,
  failed;

  String get displayName {
    switch (this) {
      case MatchStatus.searching:
        return 'Searching';
      case MatchStatus.pairing:
        return 'Pairing';
      case MatchStatus.inProgress:
        return 'In Progress';
      case MatchStatus.submitting:
        return 'Submitting';
      case MatchStatus.completed:
        return 'Completed';
      case MatchStatus.cancelled:
        return 'Cancelled';
      case MatchStatus.failed:
        return 'Failed';
    }
  }

  String get key {
    switch (this) {
      case MatchStatus.searching:
        return 'searching';
      case MatchStatus.pairing:
        return 'pairing';
      case MatchStatus.inProgress:
        return 'in_progress';
      case MatchStatus.submitting:
        return 'submitting';
      case MatchStatus.completed:
        return 'completed';
      case MatchStatus.cancelled:
        return 'cancelled';
      case MatchStatus.failed:
        return 'failed';
    }
  }

  static MatchStatus fromKey(String key) {
    return MatchStatus.values.firstWhere(
      (status) => status.key == key,
      orElse: () => MatchStatus.failed,
    );
  }
}
