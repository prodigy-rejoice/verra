extension StringExtensions on String {
  String get shortAddress {
    if (length < 10) return this;
    return '${substring(0, 6)}...${substring(length - 4)}';
  }
}
