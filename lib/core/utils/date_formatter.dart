import 'package:intl/intl.dart';

/// Utility class for formatting dates and times.
class DateFormatter {
  DateFormatter._();

  // ─── Standard Formats ────────────────────────────────────────────────────

  /// Format: `dd MMM yyyy` (e.g. `25 Feb 2026`)
  static String toReadableDate(DateTime date) =>
      DateFormat('dd MMM yyyy').format(date);

  /// Format: `dd/MM/yyyy` (e.g. `25/02/2026`)
  static String toShortDate(DateTime date) =>
      DateFormat('dd/MM/yyyy').format(date);

  /// Format: `HH:mm` (e.g. `14:30`)
  static String toTime(DateTime date) => DateFormat('HH:mm').format(date);

  /// Format: `HH:mm:ss` (e.g. `14:30:00`)
  static String toTimeWithSeconds(DateTime date) =>
      DateFormat('HH:mm:ss').format(date);

  /// Format: `dd MMM yyyy, HH:mm` (e.g. `25 Feb 2026, 14:30`)
  static String toDateTimeReadable(DateTime date) =>
      DateFormat('dd MMM yyyy, HH:mm').format(date);

  /// Format: ISO 8601 (e.g. `2026-02-25T14:30:00.000`)
  static String toIso8601(DateTime date) => date.toIso8601String();

  // ─── Relative Time ───────────────────────────────────────────────────────

  /// Returns a human-friendly relative time string (e.g. "2 hours ago").
  static String toRelative(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inSeconds < 60) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays == 1) return 'Yesterday';
    if (diff.inDays < 7) return '${diff.inDays} days ago';
    return toReadableDate(date);
  }

  // ─── Parsing ─────────────────────────────────────────────────────────────

  /// Parses an ISO 8601 string and returns a [DateTime], or null on failure.
  static DateTime? fromIso8601(String value) => DateTime.tryParse(value);
}
