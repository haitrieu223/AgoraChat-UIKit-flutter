import 'package:intl/intl.dart';

enum TimeType { today, month, year }

class TimeTool {
  static TimeType _timeType(int ms) {
    DateTime now = DateTime.now();
    DateTime dateToCheck = DateTime.fromMillisecondsSinceEpoch(ms);
    if (now.year == dateToCheck.year) {
      if (now.month == dateToCheck.month && now.day == dateToCheck.day) {
        return TimeType.today;
      }
      return TimeType.month;
    } else {
      return TimeType.year;
    }
  }

  static String timeStrByMs(int ms, {bool showTime = false}) {
    // 根据传入时间判断是否是今天、本月、本年,
    // 今天，返回 HH:mm
    // 本月，返回 MM/dd HH:mm
    // 本年，返回 yyyy/MM/dd HH:mm

    TimeType type = _timeType(ms);
    DateTime date = DateTime.fromMillisecondsSinceEpoch(ms);
    String ret = "";
    switch (type) {
      case TimeType.today:
        ret = DateFormat('h:mma').format(date);
        break;
      case TimeType.month:
        ret = DateFormat('MM/dd h:mma').format(date);
        break;
      case TimeType.year:
        ret = DateFormat('yyyy/MM/dd h:mma').format(date);
        break;
    }
    return ret;
  }

  static String durationStr(int duration) {
    if (duration <= 60) {
      return "${duration.toInt()}\"";
    } else if (duration > 60 && duration < 3600) {
      return "${(duration / 60).truncate().toInt()}'${(duration % 60).toInt()}\"";
    } else {
      return "${(duration / 3600).truncate().toInt()}h${(duration % 3600 / 60).truncate().toInt()}'${(duration % 3600 % 60).truncate().toInt()}\"";
    }
  }
}
