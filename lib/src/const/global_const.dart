/// Name: global_const.dart
///
/// Created by Static4u
/// Date : 2023/4/12 15:17
class GlobalConst {
  // 依赖项目中Image.asset()必须传package，子项目引用依赖中的资源也需要；
  static const String packageName = "base_lib_pub";
  static const String baseAssetsPrefix = "assets/base_lib_pub/";

  // 默认头像、placeholder、error图片
  static const String defaultAvatarImg = "assets/base_lib_pub/images/avatar.png";
  static const String defaultPlaceholderImg = "assets/base_lib_pub/images/pic.png";
  static const String defaultErrorImg = "assets/base_lib_pub/images/pic_failed.png";

  /// 数字正则
  static const String regexpStrNumber = "[0-9]";
  static const String regexpStrChar = "[a-zA-Z]";
  static const String regexpStrEmail = "^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*\$";
}
