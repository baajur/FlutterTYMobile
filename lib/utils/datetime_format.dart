import 'package:intl/intl.dart';

final DateFormat _datetimeFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
final DateFormat _dateFormat = DateFormat("yyyy-MM-dd");
final DateFormat _dateStartFormat = DateFormat("yyyy-MM-dd 00:00:00");
final DateFormat _dateEndFormat = DateFormat("yyyy-MM-dd 23:59:59");

/// Get [DateTime.now] as String
String getDateTime() => DateTime.now().toDatetimeString;

bool checkDateRange(String start, String end) {
  if (start == null || start.isEmpty || end == null || end.isEmpty)
    return false;
  try {
    DateTime now = DateTime.now();
    DateTime startTime = start.toDatetime();
    DateTime endTime = end.toDatetime();
    return startTime.isBefore(now) &&
        endTime.isBefore(now) &&
        startTime.isBefore(endTime);
  } on Exception {
    return false;
  }
}

extension DateTimeStringExtensions on String {
  /// Format [date] string back to [DateTime]
  DateTime toDatetime() {
    if (contains('.'))
      return _datetimeFormat.parse(this);
    else
      return _datetimeFormat.parse('$this 00:00:00');
  }
}

extension DateTimeExtensions on DateTime {
  /// Format [DateTime] to [String]
  String get toDatetimeString => _datetimeFormat.format(this);

  String get toDateString => _dateFormat.format(this);

  String get toDateStartString => _dateStartFormat.format(this);

  String get toDateEndString => _dateEndFormat.format(this);

  /// check if the [DateTime] has at least passed [hours] and the time is before [DateTime.now]
  /// Usage example:
  /// data updated on 02-01 20:00:00
  /// now is 02-02 00:00:00
  /// the update required interval is 3 hrs
  /// so, the time now is 4 hours after old date + 3 hr, which will return true.
  bool isAfterHours(int hours) =>
      DateTime.now().isAfter(this.add(Duration(hours: hours)));

  bool isDayPassed() => this.day < DateTime.now().day;

  int countHoursPassed() => DateTime.now().difference(this).inHours;
}
