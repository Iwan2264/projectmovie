import 'package:intl/intl.dart';

String formatDate(String rawDate) {
  try {
    final date = DateTime.parse(rawDate);
    return DateFormat('MMM yyyy').format(date);
  } catch (_) {
    return '';
  }
}
