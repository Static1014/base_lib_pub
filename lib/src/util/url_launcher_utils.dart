import 'package:url_launcher/url_launcher_string.dart';

/// Name: url_launcher_utils.dart
///
/// Created by Static4u
/// Date : 2023/9/16 22:52

/// 通过url启动第三方app
/// platform配置：
/// android：
// <!-- Provide required visibility configuration for API level 30 and above -->
// <queries>
//   <!-- If your app checks for SMS support -->
//   <intent>
//     <action android:name="android.intent.action.VIEW" />
//     <data android:scheme="sms" />
//   </intent>
//   <!-- If your app checks for call support -->
//   <intent>
//     <action android:name="android.intent.action.VIEW" />
//     <data android:scheme="tel" />
//   </intent>
// </queries>
/// iOS：
// <key>LSApplicationQueriesSchemes</key>
// <array>
//   <string>sms</string>
//   <string>tel</string>
// </array>

extension StringUrlExt on String {
  /// 是否是schemeUrl，需要通过url_launcher打开第三方app
  bool get isSchemeUrl => !startsWith('http://') && !startsWith('https://');

  /// 通过url_launcher启动，如果无法启动，返回false
  Future<bool> launch() async {
    if (await canLaunchUrlString(this)) {
      return launchUrlString(this, mode: LaunchMode.externalApplication);
    }

    return false;
  }

  /// 在浏览器中打开
  Future<bool> launchInBrowser() {
    return launchUrlString(this, mode: LaunchMode.externalApplication);
  }
}
