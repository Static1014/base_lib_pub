import 'package:base_lib_pub/src/extension/common_ext.dart';
import 'package:vibration/vibration.dart';

/// Name: vibrate_utils.dart
///
/// Created by Static4u
/// Date : 2024/3/21 11:00

class Shake {
  const Shake();

  static void error() {
    vibrate(pattern: [0, 50, 50, 50]);
  }

  static void tap() {
    vibrate(duration: 50);
  }

  static void notify() {
    vibrate(pattern: [0, 200, 50, 200, 50, 500, 50, 800, 50, 200, 50, 200, 50, 500, 50, 800]);
  }
}

/// 振动
void vibrate({
  // 单次振动持续时间，单位ms
  int duration = 500,
  // 振动强度 [1, 255]
  int amplitude = -1,
  // 无法振动回调
  Function? onFailedCallback,
  // 重复次数
  int repeat = 0,
  int repeatInterval = 50,
  // 自定义振动 如：[100, 500, 500, 1000] 表示：停100，振500，停500，振1000(单位ms)
  List<int>? pattern,
  // 自定义振幅区间 [1, 255]
  List<int>? intensities,
}) async {
  try {
    if (!(await Vibration.hasVibrator() ?? false)) {
      // 无法振动
      'No vibrator on this device.'.logW();
      onFailedCallback?.call();
      return;
    }

    if (!(await Vibration.hasAmplitudeControl() ?? false)) {
      //   无法控制强度
      'The vibration amplitude cannot be controlled'.logW();
      amplitude = -1;
    }
    if (!(await Vibration.hasCustomVibrationsSupport() ?? false)) {
      // 无法控制单次振动时长
      'Cannot control the single vibration duration'.logW();
      duration = 500;
    }
    if (pattern == null) {
      if (repeat > 0) {
        List<int> pattern = [0];
        for (int i = 0; i < repeat; i++) {
          pattern.add(duration);
          pattern.add(repeatInterval);
        }
        Vibration.vibrate(pattern: pattern, amplitude: amplitude);
      } else {
        Vibration.vibrate(duration: duration, amplitude: amplitude, repeat: repeat);
      }
    } else {
      Vibration.vibrate(pattern: pattern, intensities: intensities ?? []);
    }
  } catch (e, s) {
    e.logE(tag: 'Exception msg');
    s.logE(tag: 'Exception trace');
    onFailedCallback?.call();
  }
}

/// 停止振动
void stopVibrate() {
  Vibration.cancel();
}

// void _vibrate() {
//   SystemChannels.platform.invokeMethod('HapticFeedback.vibrate');
// }
//
// // 振动
// Timer? vibrate({
//   int times = 1,
//   Duration interval = const Duration(milliseconds: 100),
// }) {
//   // 需要权限
//   // <uses-permission android:name="android.permission.VIBRATE"/>
//   if (times > 1) {
//     // 多次
//     int count = 0;
//     return doInterval(interval, callOnStart: true, (timer) {
//       if (count >= times) {
//         timer?.cancel();
//       }
//       _vibrate();
//       count++;
//     });
//   } else {
//     _vibrate();
//     return null;
//   }
// }
