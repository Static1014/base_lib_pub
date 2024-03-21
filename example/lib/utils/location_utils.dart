// import 'dart:io';
//
// import 'package:base_lib_pub/base_lib_pub.dart';
// import 'package:geolocator/geolocator.dart';
//
// /// Name: location_utils.dart
// ///
// /// Created by Static4u
// /// Date : 2024/3/19 10:02
// /// Determine the current position of the device.
// ///
// /// When the location services are not enabled or permissions
// /// are denied the `Future` will return an error.
// Future<Position> getLocation() async {
//   bool serviceEnabled;
//   LocationPermission permission;
//
//   // Test if location services are enabled.
//   serviceEnabled = await Geolocator.isLocationServiceEnabled();
//   if (!serviceEnabled) {
//     // Location services are not enabled don't continue
//     // accessing the position and request users of the
//     // App to enable the location services.
//     Geolocator.openLocationSettings();
//     return Future.error('Location services are disabled.');
//   }
//
//   permission = await Geolocator.checkPermission();
//   if (permission == LocationPermission.denied) {
//     permission = await Geolocator.requestPermission();
//     if (permission == LocationPermission.denied) {
//       // Permissions are denied, next time you could try
//       // requesting permissions again (this is also where
//       // Android's shouldShowRequestPermissionRationale
//       // returned true. According to Android guidelines
//       // your App should show an explanatory UI now.
//       Geolocator.requestPermission();
//       return Future.error('Location permissions are denied');
//     }
//   }
//
//   if (permission == LocationPermission.deniedForever) {
//     // Permissions are denied forever, handle appropriately.
//     Geolocator.openAppSettings();
//     return Future.error('Location permissions are permanently denied, we cannot request permissions.');
//   }
//
//   // When we reach here, permissions are granted and we can
//   // continue accessing the position of the device.
//   // return await Geolocator.getCurrentPosition();
//   return await Geolocator.getCurrentPosition();
// }
//
// /// 腾讯地图调用
// Future<bool> openTencentMap(double longitude, double latitude, {String address = '', bool showErr = true}) async {
//   String url =
//       'qqmap://map/routeplan?type=drive&fromcoord=CurrentLocation&tocoord=$latitude,$longitude&referer=FN4BZ-6E33P-LFTDB-VRZ4C-NTP3Z-RVFFK&debug=true&to=$address';
//   if (Platform.isIOS) {
//     url = Uri.encodeFull(url);
//   }
//   try {
//     await url.launch();
//   } on Exception {
//     if (showErr) {
//       toast('无法调起腾讯地图');
//     }
//     return false;
//   }
//   return true;
// }
//
// /// 高德地图调用
// Future<bool> openAmap(double longitude, double latitude, {String address = '', bool showErr = true}) async {
//   String url = '${Platform.isAndroid ? 'android' : 'ios'}amap://navi?sourceApplication=amap&lat=$latitude&lon=$longitude&dev=0&style=2&poiname=$address';
//   if (Platform.isIOS) {
//     url = Uri.encodeFull(url);
//   }
//   try {
//     await url.launch();
//   } on Exception {
//     if (showErr) {
//       toast('无法调起高德地图');
//     }
//     return false;
//   }
//   return true;
// }
//
// /// 百度地图
// Future<bool> openBaiduMap(double longitude, double latitude, {String address = '', bool showErr = true}) async {
//   String url = 'baidumap://map/direction?destination=name:$address|latlng:$latitude,$longitude&coord_type=bd09ll&mode=driving';
//   if (Platform.isIOS) {
//     url = Uri.encodeFull(url);
//   }
//   try {
//     await url.launch();
//   } on Exception {
//     if (showErr) {
//       toast('无法调起高德地图');
//     }
//     return false;
//   }
//   return true;
// }
//
// /// 苹果地图
// Future<bool> openAppleMap(longitude, latitude, {String address = '', bool showErr = true}) async {
//   String url = 'http://maps.apple.com/?daddr=$latitude,$longitude&address=$address';
//   if (Platform.isIOS) {
//     url = Uri.encodeFull(url);
//   }
//   try {
//     await url.launch();
//     // await launchUrlString(url);
//   } on Exception {
//     if (showErr) {
//       toast('无法调起高德地图');
//     }
//     return false;
//   }
//   return true;
// }
//
// Future<bool> openMap(longitude, latitude, {String address = '', bool showErr = false}) async {
//   bool flag = true;
//   if (!await openAmap(longitude, latitude, address: address, showErr: showErr)) {
//     if (!await openBaiduMap(longitude, latitude, address: address, showErr: showErr)) {
//       if (!await openTencentMap(longitude, latitude, address: address, showErr: showErr)) {
//         // if (!await openAppleMap(longitude, latitude, address: address, showErr: showErr)) {
//         flag = false;
//         toast('无法调用地图应用，请安装高德，百度，腾讯任意一种地图应用');
//         // }
//       }
//     }
//   }
//   return flag;
// }
