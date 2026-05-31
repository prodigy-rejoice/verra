enum ChallengeType {
  chainReflex,
  cryptoTrivia,
  wordStake,
  patternBreaker,
  mathDuel;

  String get displayName {
    switch (this) {
      case ChallengeType.chainReflex:
        return 'Chain Reflex';
      case ChallengeType.cryptoTrivia:
        return 'Crypto Trivia';
      case ChallengeType.wordStake:
        return 'Word Stake';
      case ChallengeType.patternBreaker:
        return 'Pattern Breaker';
      case ChallengeType.mathDuel:
        return 'Math Duel';
    }
  }

  String get key {
    switch (this) {
      case ChallengeType.chainReflex:
        return 'chain_reflex';
      case ChallengeType.cryptoTrivia:
        return 'crypto_trivia';
      case ChallengeType.wordStake:
        return 'word_stake';
      case ChallengeType.patternBreaker:
        return 'pattern_breaker';
      case ChallengeType.mathDuel:
        return 'math_duel';
    }
  }

  static ChallengeType fromKey(String key) {
    return ChallengeType.values.firstWhere(
      (type) => type.key == key,
      orElse: () => ChallengeType.cryptoTrivia,
    );
  }
}
