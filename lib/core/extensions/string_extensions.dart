/// Extension on [String] for common utility operations.
extension StringExtensions on String {
  // ─── Formatting ──────────────────────────────────────────────────────────

  /// Returns the string with the first letter uppercased.
  String get capitalize {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  /// Returns the string with every word capitalized.
  String get titleCase {
    return split(' ').map((word) => word.capitalize).join(' ');
  }

  /// Returns a truncated string with an ellipsis if longer than [maxLength].
  String truncate(int maxLength, {String ellipsis = '...'}) {
    if (length <= maxLength) return this;
    return '${substring(0, maxLength)}$ellipsis';
  }

  // ─── Validation ──────────────────────────────────────────────────────────

  /// Returns true if the string is a valid email address.
  bool get isValidEmail {
    return RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    ).hasMatch(this);
  }

  /// Returns true if the string is a valid URL.
  bool get isValidUrl {
    return RegExp(r'^(https?|ftp):\/\/[^\s/$.?#].[^\s]*$').hasMatch(this);
  }

  /// Returns true if the string contains only numeric digits.
  bool get isNumeric => RegExp(r'^[0-9]+$').hasMatch(this);

  /// Returns true if the string is not empty and not only whitespace.
  bool get isNotBlank => trim().isNotEmpty;

  // ─── Parsing ─────────────────────────────────────────────────────────────

  /// Converts to int or returns null if parsing fails.
  int? get toIntOrNull => int.tryParse(this);

  /// Converts to double or returns null if parsing fails.
  double? get toDoubleOrNull => double.tryParse(this);
}

/// Extension on nullable [String].
extension NullableStringExtensions on String? {
  /// Returns true if the string is null or empty.
  bool get isNullOrEmpty => this == null || this!.isEmpty;

  /// Returns the string or an empty string if null.
  String get orEmpty => this ?? '';
}
