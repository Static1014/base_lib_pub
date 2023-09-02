import '../util/common_utils.dart';

/// Name: datetime_ext.dart
///
/// Created by Static4u
/// Date : 2021/8/7 10:05 下午
extension DateTimeFormat on DateTime {
  /// 格式化，默认yyyy-mm-dd HH:nn:ss
  String toFormatString({List<String>? format, String daySeparator = '-', String middleSeparator = ' ', String timeSeparator = ':'}) {
    return mFormatDate(time: this, format: format, daySeparator: daySeparator, middleSeparator: middleSeparator, timeSeparator: timeSeparator);
  }

  /// 时间戳
  String get toStampString {
    return "$millisecondsSinceEpoch";
  }

  /// 显示中文周几
  get weekInChinese {
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
}
