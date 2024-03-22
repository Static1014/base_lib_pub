import '../trans/translation.dart';

/// Name: api.dart
///
/// Created by Static4u
/// Date : 2023/9/5 14:39
class Api {
  // todo 请求base地址
  static const baseUrl = 'https://pc.homedot.space/';

  // 主页/下载链接
  static String pathDownload = '${baseUrl}index.html?lang=${MyTrans.isEn ? 'en' : 'zh'}';

  // 隐私政策
  static String pathPrivacy = '${baseUrl}privacy/index.html?lang=${MyTrans.isEn ? 'en' : 'zh'}';
}
