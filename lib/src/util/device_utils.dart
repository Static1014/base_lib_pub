import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:harmony_plugin/harmony_plugin.dart';

/// Name: device_utils.dart
///
/// Created by Static4u
/// Date : 2023/9/19 12:02

// ignore: non_constant_identifier_names
final DeviceUtils = _DeviceUtilsClass();

class _DeviceUtilsClass {
  static _DeviceUtilsClass? _instance;

  _DeviceUtilsClass._internal() {
    _instance = this;
  }

  factory _DeviceUtilsClass() {
    return _instance ?? _DeviceUtilsClass._internal();
  }

  final DeviceInfoPlugin _plugin = DeviceInfoPlugin();
  final HarmonyPlugin _harmonyPlugin = HarmonyPlugin();

  /// Android设备信息：
  /// harmony 4.0.0：
  // BaseDeviceInfo{
  //   data: {
  //     product: NAM-AL00,
  //     supportedAbis: [arm64-v8a, armeabi-v7a, armeabi],
  //     serialNumber: unknown,
  //     displayMetrics: {
  //       xDpi: 391.885009765625,
  //       widthPx: 1080.0,
  //       heightPx: 2340.0,
  //       yDpi: 391.0260009765625
  //     },
  //     supported32BitAbis: [armeabi-v7a, armeabi],
  //     display: NAM-AL00 4.0.0.115(C00E112R2P4),
  //     type: user,
  //     isPhysicalDevice: true,
  //     version: {
  //       baseOS: ,
  //       securityPatch: 2022-08-01,
  //       sdkInt: 31,
  //       release: 12,
  //       codename: REL,
  //       previewSdkInt: 0,
  //       incremental: 104.0.0.115C00
  //     },
  //     systemFeatures: [android.hardware.sensor.proximity, android.hardware.sensor.accelerometer, android.software.controls, android.hardware.faketouch, android.hardware.usb.accessory, android.hardware.telephony.cdma, android.software.backup, android.hardware.touchscreen, android.hardware.touchscreen.multitouch, android.software.print, com.huawei.emui.api.23, com.huawei.software.features.full, android.software.activities_on_secondary_displays, android.software.voice_recognizers, android.software.picture_in_picture, android.hardware.fingerprint, android.hardware.sensor.gyroscope, android.hardware.audio.low_latency, android.software.vulkan.deqp.level, android.software.cant_save_state, android.hardware.security.model.compatible, android.hardware.opengles.aep, android.hardware.bluetooth, android.hardware.camera.autofocus, android.hardware.telephony.gsm, android.hardware.telephony.ims, android.software.incremental_delivery, android.hardware.se.omapi.ese, android.software.opengles.deqp.level, android.hardware.usb.host, android.hardware.audio.output, android.software.verified_boot, android.hardware.camera.flash, android.hardware.camera.front, android.hardware.se.omapi.uicc, android.hardware.screen.portrait, android.hardware.nfc, com.nxp.mifare, android.hardware.sensor.stepdetector, android.software.home_screen, com.huawei.system.feature, android.hardware.microphone, com.huawei.software.features.huawei, android.software.autofill, android.software.securely_removes_users, android.hardware.bluetooth_le, android.hardware.sensor.compass, android.hardware.touchscreen.multitouch.jazzhand, android.software.app_widgets, android.software.input_methods, android.hardware.sensor.light, android.hardware.vulkan.version, android.software.companion_device_setup, android.software.device_admin, android.hardware.wifi.passpoint, android.hardware.camera, android.hardware.screen.landscape, android.hardware.ram.normal, android.software.managed_users, android.software.webview, android.hardware.sensor.stepcounter, android.hardware.camera.capability.manual_post_processing, android.hardware.camera.any, android.hardware.vulkan.compute, com.huawei.software.features.china, android.software.connectionservice, android.hardware.touchscreen.multitouch.distinct, android.hardware.location.network, android.software.cts, android.hardware.camera.capability.manual_sensor, android.software.app_enumeration, android.hardware.camera.level.full, android.hardware.wifi.direct, android.software.live_wallpaper, android.software.ipsec_tunnels, android.software.freeform_window_management, android.hardware.audio.pro, android.hardware.nfc.hcef, android.hardware.nfc.uicc, android.hardware.location.gps, android.software.midi, android.hardware.nfc.any, android.hardware.nfc.hce, com.huawei.software.features.handset, android.hardware.wifi, android.hardware.location, android.hardware.vulkan.level, android.software.secure_lock_screen, android.hardware.telephony, android.software.file_based_encryption],
  //     manufacturer: HUAWEI,
  //     tags: release-keys,
  //     supported64BitAbis: [arm64-v8a],
  //     bootloader: unknown,
  //     fingerprint: HUAWEI/NAM-AL00/HWNAM:12/HUAWEINAM-AL00/104.0.0.115C00:user/release-keys,
  //     host: cn-central-hcd-2a-bbf955d161693658870200-6bf5ccb47c-95jn5,
  //     model: NAM-AL00,
  //     id: HUAWEINAM-AL00,
  //     brand: HUAWEI,
  //     device: HWNAM,
  //     board: NAM,
  //     hardware: qcom
  //   }
  // }
  /// android 12 模拟器:
  // BaseDeviceInfo{
  //   data: {
  //     product: sdk_gphone64_arm64,
  //     supportedAbis: [arm64-v8a],
  //     serialNumber: unknown,
  //     displayMetrics: {
  //       xDpi: 560.0,
  //       widthPx: 1440.0,
  //       heightPx: 3120.0,
  //       yDpi: 560.0
  //     },
  //     supported32BitAbis: [],
  //     display: sdk_gphone64_arm64-userdebug 12 SE1A.220630.001.A1 9056438 dev-keys,
  //     type: userdebug,
  //     isPhysicalDevice: false,
  //     version: {
  //       baseOS: ,
  //       securityPatch: 2022-08-01,
  //       sdkInt: 31,
  //       release: 12,
  //       codename: REL,
  //       previewSdkInt: 0,
  //       incremental: 9056438
  //     },
  //     systemFeatures: [android.hardware.sensor.proximity, android.software.adoptable_storage, android.hardware.sensor.accelerometer, android.software.controls, android.hardware.faketouch, android.software.backup, android.hardware.touchscreen, android.hardware.touchscreen.multitouch, android.software.print, android.software.activities_on_secondary_displays, android.software.voice_recognizers, android.software.picture_in_picture, android.hardware.fingerprint, android.hardware.sensor.gyroscope, android.software.vulkan.deqp.level, android.software.cant_save_state, android.hardware.security.model.compatible, android.hardware.sensor.relative_humidity, android.hardware.bluetooth, android.hardware.camera.autofocus, com.google.android.feature.GOOGLE_BUILD, android.hardware.telephony.gsm, android.hardware.telephony.ims, android.software.incremental_delivery, android.software.opengles.deqp.level, android.hardware.camera.concurrent, android.hardware.audio.output, android.software.verified_boot, android.hardware.camera.flash, android.hardware.camera.front, android.hardware.screen.portrait, android.hardware.sensor.ambient_temperature, android.software.home_screen, android.hardware.microphone, android.software.autofill, android.software.securely_removes_users, android.hardware.bluetooth_le, android.hardware.sensor.compass, android.hardware.touchscreen.multitouch.jazzhand, android.hardware.sensor.barometer, android.software.app_widgets, android.software.input_methods, android.hardware.sensor.light, android.hardware.vulkan.version, android.software.companion_device_setup, android.software.device_admin, com.google.android.feature.WELLBEING, android.hardware.wifi.passpoint, android.hardware.camera, android.hardware.screen.landscape, android.hardware.ram.normal, android.hardware.sensor.hinge_angle, android.software.managed_users, android.software.webview, android.hardware.camera.capability.manual_post_processing, android.hardware.camera.any, android.hardware.camera.capability.raw, android.hardware.vulkan.compute, android.software.connectionservice, android.hardware.touchscreen.multitouch.distinct, android.hardware.location.network, android.hardware.camera.ar, android.software.cts, android.hardware.camera.capability.manual_sensor, android.software.app_enumeration, com.google.android.apps.dialer.SUPPORTED, android.hardware.camera.level.full, android.hardware.identity_credential, android.hardware.wifi.direct, android.software.live_wallpaper, com.google.android.feature.GOOGLE_EXPERIENCE, android.software.ipsec_tunnels, com.google.android.feature.EXCHANGE_6_2, android.hardware.location.gps, android.software.midi, android.hardware.hardware_keystore, android.hardware.wifi, android.hardware.location, android.hardware.vulkan.level, android.software.secure_lock_screen, android.hardware.telephony, android.software.file_based_encryption],
  //     manufacturer: Google,
  //     tags: dev-keys,
  //     supported64BitAbis: [arm64-v8a],
  //     bootloader: unknown,
  //     fingerprint: google/sdk_gphone64_arm64/emulator64_arm64:12/SE1A.220630.001.A1/9056438:userdebug/dev-keys,
  //     host: abfarm769,
  //     model: sdk_gphone64_arm64,
  //     id: SE1A.220630.001.A1,
  //     brand: google,
  //     device: emulator64_arm64,
  //     board: goldfish_arm64,
  //     hardware: ranchu}}
  /// redme note 8
  // BaseDeviceInfo{
  //   data: {
  //     product: ginkgo,
  //     supportedAbis: [arm64-v8a, armeabi-v7a, armeabi],
  //     serialNumber: unknown,
  //     displayMetrics: {
  //       xDpi: 409.4320068359375,
  //       widthPx: 1080.0,
  //       heightPx: 2340.0,
  //       yDpi: 409.90301513671875
  //     },
  //     supported32BitAbis: [armeabi-v7a, armeabi],
  //     display: RKQ1.201004.002 test-keys,
  //     type: user,
  //     isPhysicalDevice: true,
  //     version: {
  //       baseOS: ,
  //       securityPatch: 2021-10-01,
  //       sdkInt: 30,
  //       release: 11,
  //       codename: REL,
  //       previewSdkInt: 0,
  //       incremental: V12.5.4.0.RCOCNXM
  //     },
  //     systemFeatures: [android.hardware.sensor.proximity, android.hardware.sensor.accelerometer, android.software.controls, android.hardware.faketouch, android.hardware.usb.accessory, android.hardware.telephony.cdma, android.software.backup, android.hardware.touchscreen, android.hardware.touchscreen.multitouch, android.software.print, android.hardware.consumerir, android.hardware.ethernet, android.software.activities_on_secondary_displays, android.software.voice_recognizers, android.software.picture_in_picture, android.hardware.fingerprint, android.hardware.sensor.gyroscope, android.hardware.audio.low_latency, android.software.vulkan.deqp.level, android.software.cant_save_state, android.hardware.opengles.aep, android.hardware.bluetooth, android.hardware.camera.autofocus, android.hardware.telephony.gsm, android.hardware.telephony.ims, android.software.incremental_delivery, android.software.sip.voip, android.hardware.usb.host, android.hardware.audio.output, android.software.verified_boot, android.hardware.camera.flash, android.hardware.camera.front, android.hardware.screen.portrait, android.hardware.sensor.stepdetector, android.software.home_screen, android.hardware.microphone, android.software.autofill, android.software.securely_removes_users, android.hardware.bluetooth_le, android.hardware.sensor.compass, android.hardware.touchscreen.multitouch.jazzhand, android.software.app_widgets, android.software.input_methods, android.hardware.sensor.light, android.hardware.vulkan.version, android.software.companion_device_setup, android.software.device_admin, android.hardware.wifi.passpoint, android.hardware.camera, android.hardware.screen.landscape, android.hardware.ram.normal, android.software.managed_users, android.software.webview, android.hardware.sensor.stepcounter, android.hardware.camera.capability.manual_post_processing, android.hardware.camera.any, android.hardware.camera.capability.raw, android.hardware.vulkan.compute, android.software.connectionservice, android.hardware.touchscreen.multitouch.distinct, android.hardware.location.network, android.software.cts, android.software.sip, android.hardware.camera.capability.manual_sensor, android.software.app_enumeration, android.hardware.camera.level.full, android.hardware.wifi.direct, android.software.live_wallpaper, android.software.ipsec_tunnels, android.hardware.audio.pro, android.hardware.location.gps, android.software.midi, android.hardware.wifi, android.hardware.location, android.hardware.vulkan.level, android.software.secure_lock_screen, android.hardware.telephony, android.software.file_based_encryption],
  //     manufacturer: Xiaomi,
  //     tags: release-keys,
  //     supported64BitAbis: [arm64-v8a],
  //     bootloader: unknown,
  //     fingerprint: xiaomi/ginkgo/ginkgo:11/RKQ1.201004.002/V12.5.4.0.RCOCNXM:user/release-keys,
  //     host: m1-xm-ota-bd196.bj.idc.xiaomi.com,
  //     model: Redmi Note 8,
  //     id: RKQ1.201004.002,
  //     brand: xiaomi,
  //     device: ginkgo,
  //     board: ginkgo,
  //     hardware: qcom
  //   }
  // }
  Future<AndroidDeviceInfo?> get androidInfo async => GetPlatform.isAndroid ? _plugin.androidInfo : null;

  /// ios设备信息：
  // BaseDevicelnfo{
  //   data:{
  //     systemName:iOS,
  //     isPhysicalDevice:false,
  //     utsname:{
  //        release:22.6.0,
  //        sysname:Darwin,
  //        nodename:xiongjiandeMacBook-Pro.local,
  //        machine:iPhone15,3,
  //        version:Darwin Kernel Version 22.6.0:Wed Jul 5 22:22:05 PDT 2023;
  //        root:xnu-8796.141.3~6/RELEASE_ARM64_T6000
  //     },
  //     model: iPhone,
  //     localizedModel:iPhone,
  //     systemVersion:16.4,
  //     name:iPhone 14 Pro Max,
  //     identifierForVendor: AA6789AD-8643-4981-BA97-EA54A0595EB3
  //   }
  // }
  Future<IosDeviceInfo?> get iosInfo async => GetPlatform.isIOS ? _plugin.iosInfo : null;

  Future<WebBrowserInfo?> get webBrowserInfo async => GetPlatform.isWeb ? _plugin.webBrowserInfo : null;

  Future<bool> get isHarmonyOS => _harmonyPlugin.isHarmonyOS();

  Future<String> get harmonyVersion => _harmonyPlugin.getHarmonyVersion();

  Future<bool> get isHarmonyPureMode => _harmonyPlugin.isHarmonyPureMode();

  /// 设备名称
  Future<String> getPhoneDisplayName() async {
    if (GetPlatform.isAndroid) {
      AndroidDeviceInfo info = (await androidInfo)!;
      // HUAWEI NAM-AL00 on Harmony 4.0.0.115
      return '${info.brand} ${info.model} on ${(await isHarmonyOS) ? 'Harmony ${await harmonyVersion}' : 'Android ${info.version.release}'}';
    } else if (GetPlatform.isIOS) {
      IosDeviceInfo info = (await iosInfo)!;
      // iPhone 14 Pro Max on iOS 16.4
      return '${info.name} on ${info.systemName} ${info.systemVersion}';
    }
    return '';
  }
}
