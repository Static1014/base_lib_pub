import 'package:base_lib_pub/base_lib_pub.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

/// Name: url_launcher_utils.dart
///
/// Created by Static4u
/// Date : 2023/9/16 22:52

/// 通过url启动第三方app
/// platform配置：
/// android：manifest
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
//   <!-- If your app checks for mailto support -->
//   <intent>
//     <action android:name="android.intent.action.VIEW" />
//     <data android:scheme="mailto" />
//   </intent>
// </queries>
/// iOS：info.plist
// <key>LSApplicationQueriesSchemes</key>
// <array>
//   <string>sms</string>
//   <string>tel</string>
//   <string>mailto</string>
// </array>

/// 通过url_launcher启动，如果无法启动，返回false
Future<bool> launchMyUrl(
  String url, {
  LaunchMode mode = LaunchMode.externalApplication,
}) async {
  if (await canLaunchUrlString(url)) {
    return launchUrlString(url, mode: mode);
  }

  return false;
}

/// 发送邮件
Future<bool> mailto({
  required String target, // 收件人邮箱
  String? cc, // 抄送
  String? bcc, // 密送
  String? title, // 标题(部分邮箱可能不支持中文标题或乱码)
  String? body, // 内容
}) async {
  if (target.isEmptyOrNull()) {
    return false;
  }
  Map<String, String> params = {};
  if (!isEmptyOrNull(cc)) {
    params['cc'] = cc!;
  }
  if (!isEmptyOrNull(bcc)) {
    params['bcc'] = bcc!;
  }
  if (!isEmptyOrNull(title)) {
    params['subject'] = title!.encodeUrl();
  }
  if (!isEmptyOrNull(body)) {
    params['body'] = body!.encodeUrl();
  }
  return launchUrl(Uri(
    scheme: 'mailto',
    path: target,
    query: params.entries.map((MapEntry<String, String> e) => '${e.key}=${e.value}').join('&'),
  )..toString().logI(tag: 'url_launcher_utils'));
}

/// 调用拨号页面
Future<bool> tel(String phone) async {
  if (phone.isEmptyOrNull()) {
    return false;
  }
  return 'tel:$phone'.launch();
}
