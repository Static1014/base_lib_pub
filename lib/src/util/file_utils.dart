import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

import '../extension/common_ext.dart';
import '../util/permission_utils.dart';
import 'common_utils.dart';

/// Name: FileUtils.dart
///
/// Created by Static4u
/// Date : 2021/8/4 10:24 下午

/// 应用文件存储根路径
late String myDefaultDirPath;

/// 应用存储根文件夹
Directory? _myDefaultDir;

/// 应用文件根路径
Future<void> initMyDefaultDir() async {
  if (_myDefaultDir == null) {
    if (Platform.isIOS) {
      _myDefaultDir = await getApplicationSupportDirectory();
    } else if (Platform.isAndroid) {
      _myDefaultDir = await getExternalStorageDirectory();
    } else {
      "FileUtils: PLATFORM IS NOT SUPPORTED NOW".logE();
    }
  }
  myDefaultDirPath = "${_myDefaultDir?.path ?? ""}/";

  Directory dir = Directory(myDefaultDirPath);
  if (!dir.existsSync()) {
    /// 创建根目录
    dir.createSync();
  }

  "应用文件存储根路径：$myDefaultDirPath".logW();
}

List getBytes(String path) => File(path).readAsBytesSync();

/// 删除文件夹及其内部文件
void deleteDirOrFile(String path) {
  "deleteDirOrFile, path: $path".logE();

  Directory dir = Directory(path);
  if (dir.existsSync()) {
    List<FileSystemEntity> files = dir.listSync();
    if (files.isNotEmpty) {
      for (var element in files) {
        element.deleteSync();
      }
    }
    dir.deleteSync();
  } else {
    File f = File(path);
    if (f.existsSync()) {
      File(path).deleteSync();
    }
  }
}

/// 创建文件夹
void createDir(String path) {
  Directory dir = Directory(path);
  if (!dir.existsSync()) {
    Directory parentDir = dir.parent;
    if (!parentDir.existsSync()) {
      createDir(parentDir.absolute.path);
    }
    dir.createSync();
    "${dir.path} 文件夹创建完成".logI();
  } else {
    "${dir.path} 文件夹已存在".logI();
  }
}

/// 创建文件
void createFile(String path) {
  File file = File(path);
  if (!file.existsSync()) {
    Directory parent = file.parent;
    if (!parent.existsSync()) {
      createDir(parent.absolute.path);
    }
    file.createSync();
    "${file.path} 文件创建完成".logI();
  } else {
    "${file.path} 文件已存在".logI();
  }
}

/// 从路径中获取文件名
String getNameInPath(String path) {
  List<String> list = path.split("/");
  return list[list.length - 1];
}

/// 从路径中获取文件名
String getLastDirInPath(String path) {
  List<String> list = path.split("/");
  return path.replaceAll(list[list.length - 1], "");
}

/// 获取文件内容
MultipartFile getFileContent(String path) {
  String name = getNameInPath(path);
  // String subType = name.split(".")[1];
  // if (subType == "jpg") {
  //   subType = "jpeg";
  // }
  // String type = "image";
  // switch (subType) {
  //   case "jpeg":
  //   case "png":
  //     type = "image";
  //     break;
  //   case "mp4":
  //     type = "video";
  //     break;
  // }
  // logW(msg: "MediaType: $type - $subType");
  // return MultipartFile.fromFileSync(path, filename: name, contentType: MediaType(type, subType));
  return MultipartFile.fromFileSync(path, filename: name);
  // return MultipartFile.fromBytes(File(path).readAsBytesSync());
}

/// 从文件路径获取文件base64字符串
Future<String> readFileToBase64Str(String path, {String? defaultStr}) async {
  File file = File(path);
  if (!await file.exists()) {
    "文件不存在：$path".logE();
    if (isEmptyOrNull(defaultStr)) {
      throw Exception('文件不存在');
    } else {
      return defaultStr!;
    }
  }
  String res = base64Encode(await file.readAsBytes());
  "$path base64Encode length: ${res.length}".logI();
  return res;
}

/// 从文件路径获取文件内容
Future<String> readFileToStr(String path, {String? defaultStr}) async {
  File file = File(path);
  if (!await file.exists()) {
    "文件不存在：$path".logE();
    if (isEmptyOrNull(defaultStr)) {
      throw Exception('文件不存在');
    } else {
      return defaultStr!;
    }
  }
  String res = await file.readAsString();
  "$path file content length: ${res.length}".logI();
  return res;
}

/// 写入到文件
Future<File> writeToFile(String path, String data, {bool append = false}) async {
  File mFile = File(path);
  if (append) {
    /// 追加
    String res = "";
    if (!mFile.existsSync()) {
      createFile(path);
    } else {
      res = await mFile.readAsString();
    }
    return mFile.writeAsString("$res$data");
  } else {
    if (!mFile.existsSync()) {
      createFile(path);
    }
    return mFile.writeAsString(data);
  }
}

/// 保存数据为本地文件
Future<File?> saveDataToFile(String path, ByteData data) async {
  var ok = await checkStoragePermission();
  if (ok) {
    File f = File(path);
    if (!f.existsSync()) {
      createFile(path);
    }
    f.writeAsBytes(data.buffer.asUint8List());
    return f;
  } else {
    return null;
  }
}

/// 遍历文件夹
Stream<FileSystemEntity> listDir(String dirPath, {bool recursive = false, bool followLinks = true}) {
  var dir = Directory(dirPath);
  if (!dir.existsSync()) {
    return const Stream.empty();
  }

  return dir.list(recursive: recursive, followLinks: followLinks);
}
