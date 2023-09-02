import 'package:encrypt/encrypt.dart';

import '../../extension/common_ext.dart';

/// Name: aes_utils.dart
///
/// Created by Static4u
/// Date : 2023/8/16 15:22
class AESUtils {
  static const String _globalIV = '4128736450938751';
  static const String _globalPwd = 'f12bg73g0hoa68fh';
  static const AESMode _globalMode = AESMode.cbc;
  static const String _globalPadding = 'PKCS7';

  /// aes加密
  static Future<String> encrypt(
    String res, {
    String pwd = _globalPwd,
    String iv = _globalIV,
    AESMode mode = _globalMode,
    String padding = _globalPadding,
    String defaultResult = '',
  }) async {
    try {
      if (res.isEmpty) {
        return res;
      }
      final Key key = Key.fromUtf8(pwd);
      final IV ivObj = IV.fromUtf8(iv);
      final encrypt = Encrypter(AES(key, mode: mode, padding: padding));

      return encrypt.encrypt(res, iv: ivObj).base64;
    } catch (e, s) {
      e.logE(tag: 'Exception msg');
      s.logE(tag: 'Exception trace');
      return defaultResult;
    }
  }

  /// aes解密
  static Future<String> decrypt(
    String base64En, {
    String pwd = _globalPwd,
    String iv = _globalIV,
    AESMode mode = _globalMode,
    String padding = _globalPadding,
    String defaultResult = '',
  }) async {
    try {
      if (base64En.isEmpty) {
        return base64En;
      }

      final Key key = Key.fromUtf8(pwd);
      final IV ivObj = IV.fromUtf8(iv);
      final encrypt = Encrypter(AES(key, mode: mode, padding: padding));

      return encrypt.decrypt(Encrypted.fromBase64(base64En), iv: ivObj);
    } catch (e, s) {
      e.logE(tag: 'Exception msg');
      s.logE(tag: 'Exception trace');
      return defaultResult;
    }
  }
}
