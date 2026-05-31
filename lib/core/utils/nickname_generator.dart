import 'dart:math';

class NicknameGenerator {
  NicknameGenerator._();

  static const List<String> _adjectives = [
    'Bold', 'Quick', 'Silent', 'Sharp', 'Wild', 'Calm', 'Brave', 'Swift',
    'Iron', 'Neon', 'Cosmic', 'Vivid', 'Lucky', 'Royal', 'Mystic', 'Stark',
    'Noble', 'Frost', 'Solar', 'Lunar', 'Crimson', 'Onyx', 'Jade', 'Amber',
  ];

  static const List<String> _nouns = [
    'Falcon', 'Wolf', 'Shadow', 'Comet', 'Tiger', 'Raven', 'Lynx', 'Phoenix',
    'Drake', 'Otter', 'Hawk', 'Panther', 'Ronin', 'Specter', 'Storm', 'Saber',
    'Kraken', 'Sentinel', 'Nomad', 'Vector', 'Glyph', 'Cipher', 'Echo', 'Vanguard',
  ];

  static String fromAddress(String address) {
    final seed = _seedFromAddress(address);
    final random = Random(seed);
    final adjective = _adjectives[random.nextInt(_adjectives.length)];
    final noun = _nouns[random.nextInt(_nouns.length)];
    final number = random.nextInt(99) + 1;
    return '$adjective$noun$number';
  }

  static int _seedFromAddress(String address) {
    var hash = 0;
    for (final unit in address.codeUnits) {
      hash = (hash * 31 + unit) & 0x7fffffff;
    }
    return hash;
  }
}
