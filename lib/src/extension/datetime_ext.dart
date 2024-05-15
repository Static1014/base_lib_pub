import '../util/common_utils.dart';

/// Name: datetime_ext.dart
///
/// Created by Static4u
/// Date : 2021/8/7 10:05 下午
extension DateTimeFormat on DateTime {
  /// 格式化，默认yyyy-mm-dd HH:nn:ss
  String toFormatString({
    List<String>? format,
    String daySeparator = '-',
    String middleSeparator = ' ',
    String timeSeparator = ':',
    String milliSeparator = '-',
    bool milliSecond = false,
  }) {
    return mFormatDate(
      time: this,
      format: format,
      daySeparator: daySeparator,
      middleSeparator: middleSeparator,
      timeSeparator: timeSeparator,
      milliSeparator: milliSeparator,
      milliSecond: milliSecond,
    );
  }

  /// 时间戳
  String get toStampString {
    return "$millisecondsSinceEpoch";
  }

  /// 显示英文月份
  String monthInEN({bool isShort = true}) {
    switch (month) {
      case 1:
        return isShort ? "Jan" : "January";
      case 2:
        return isShort ? "Feb" : "February";
      case 3:
        return isShort ? "Mar" : "March";
      case 4:
        return isShort ? "Apr" : "April";
      case 5:
        return isShort ? "May" : "May";
      case 6:
        return isShort ? "Jun" : "June";
      case 7:
        return isShort ? "Jul" : "July";
      case 8:
        return isShort ? "Aug" : "August";
      case 9:
        return isShort ? "Sep" : "September";
      case 10:
        return isShort ? "Oct" : "October";
      case 11:
        return isShort ? "Nov" : "November";
      case 12:
        return isShort ? "Dec" : "December";
      default:
        return "";
    }
  }

  /// 显示中文周几
  String get weekInChinese {
    switch (weekday) {
      case 1:
        return "周一";
      case 2:
        return "周二";
      case 3:
        return "周三";
      case 4:
        return "周四";
      case 5:
        return "周五";
      case 6:
        return "周六";
      case 7:
      default:
        return "周日";
    }
  }

  /// 显示英文周几
  String weekInEnglish({bool isShort = true}) {
    switch (weekday) {
      case 1:
        return isShort ? "Mon" : "Monday";
      case 2:
        return isShort ? "Tue" : "Tuesday";
      case 3:
        return isShort ? "Wed" : "Wednesday";
      case 4:
        return isShort ? "Thu" : "Thursday";
      case 5:
        return isShort ? "Fri" : "Friday";
      case 6:
        return isShort ? "Sat" : "Saturday";
      case 7:
      default:
        return isShort ? "Sun" : "Sunday";
    }
  }

  /// 显示美国日期(美国： Jan 1, 2000)
  String toDateStringInUS({bool isShortMonth = true, bool year = true}) {
    return '${monthInEN(isShort: isShortMonth)} $day${year ? ', $year' : ''}';
  }

  /// 显示英国日期(英国： 4 July 2023)
  String toDateStringInUK({bool isShortMonth = true, bool year = true}) {
    return '$day ${monthInEN(isShort: isShortMonth)}${year ? ' $year' : ''}';
  }
}
