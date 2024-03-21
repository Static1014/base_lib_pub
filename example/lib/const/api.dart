import '../trans/translation.dart';

/// Name: api.dart
///
/// Created by Static4u
/// Date : 2023/9/5 14:39
class Api {
  // todo 请求base地址
  static const baseUrl = 'https://pc.homedot.space/';

  // 系统参数
  static const pathSetting = 'data/setting.pmd';

  // 分组图库
  static const pathGallery = 'data/gallery/';

  // 分组
  static const pathGroup = 'data/gallery/group.pmd';

  // 主页/下载链接
  static String pathDownload = '${baseUrl}index.html?lang=${MyTrans.isEn ? 'en' : 'zh'}';

  // 主页/下载链接二维码
  static String pathQrcode = '${baseUrl}qrcode.png';

  // 隐私政策
  static String pathPrivacy = '${baseUrl}privacy/index.html?lang=${MyTrans.isEn ? 'en' : 'zh'}';
}
