import '../core/enums/challenge_type.dart';

class Challenge {
  const Challenge({
    required this.id,
    required this.question,
    required this.options,
    required this.correctAnswer,
    required this.challengeType,
  });

  final String id;
  final String question;
  final List<String> options;
  final int correctAnswer;
  final ChallengeType challengeType;

  bool isCorrect(int selectedIndex) => selectedIndex == correctAnswer;

  Challenge copyWith({
    String? id,
    String? question,
    List<String>? options,
    int? correctAnswer,
    ChallengeType? challengeType,
  }) {
    return Challenge(
      id: id ?? this.id,
      question: question ?? this.question,
      options: options ?? this.options,
      correctAnswer: correctAnswer ?? this.correctAnswer,
      challengeType: challengeType ?? this.challengeType,
    );
  }

  factory Challenge.fromJson(Map<String, dynamic> json) {
    return Challenge(
      id: json['id'] as String,
      question: json['question'] as String,
      options: (json['options'] as List<dynamic>).cast<String>(),
      correctAnswer: json['correct_answer'] as int,
      challengeType: ChallengeType.fromKey(json['challenge_type'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question': question,
      'options': options,
      'correct_answer': correctAnswer,
      'challenge_type': challengeType.key,
    };
  }
}
