/// Name: image_utils.dart
///
/// Created by Static4u
/// Date : 2023/7/11 14:33
import 'dart:io';
import 'dart:ui' as ui;

import 'package:extended_image/extended_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:uri_to_file/uri_to_file.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';

import '../extension/common_ext.dart';
import '../extension/datetime_ext.dart';
import '../translation/lang.dart';
import '../ui/overlay_utils.dart';
import 'common_utils.dart';
import 'file_utils.dart';

void initWechatAssetsPicker() {
  /// 微信资源选择注册
  AssetPicker.registerObserve();
}

String createImgName() {
  return 'img_${DateTime.now().toFormatString(middleSeparator: '_')}_${randomNum(1000)}.png';
}

// 获取指定视图组件的图片数据
Future<ui.Image?> getRenderImage(GlobalKey gk) async {
  BuildContext? buildContext = gk.currentContext;
  if (buildContext != null) {
    RenderRepaintBoundary renderObject = buildContext.findRenderObject() as RenderRepaintBoundary;
    var image = await renderObject.toImage(pixelRatio: View.of(buildContext).devicePixelRatio);
    return Future(() => image);
  }
  return Future(() => null);
}

// 保存图片为指定路径的本地文件
Future<File?> saveImage2File(String path, ui.Image? image) async {
  var data = await image?.toByteData(format: ui.ImageByteFormat.png);
  if (data == null) {
    toast(BaseTrs.imgNull.tr);
    return null;
  } else {
    return saveDataToFile(path, data);
  }
}

Future<Uint8List?> readImageToUnit8List(String imgPath) async {
  var image = await readImageFileToUIImage(imgPath);
  var data = await image.toByteData(format: ui.ImageByteFormat.png);
  return data?.buffer.asUint8List();
}

/// 文件转图片
Future<ui.Image> readImageFileToUIImage(String imgPath) async {
  var bytes = await File(imgPath).readAsBytes();
  var codec = await ui.instantiateImageCodec(bytes);
  return (await codec.getNextFrame()).image;
}

/// 保存图片文件到相册
Future<String> saveImageFile2Gallery(String imgPath, {bool isTransform2FilePath = true}) async {
  var image = await readImageFileToUIImage(imgPath);
  var data = await image.toByteData(format: ui.ImageByteFormat.png);
  return saveImageData2Gallery(data, isTransform2FilePath: isTransform2FilePath);
}

/// 保存图片到相册
Future<String> saveImage2Gallery(ui.Image? image, {bool isTransform2FilePath = true}) async {
  var data = await image?.toByteData(format: ui.ImageByteFormat.png);
  return saveImageData2Gallery(data, isTransform2FilePath: isTransform2FilePath);
}

/// 保存图片数据到相册
Future<String> saveImageData2Gallery(ByteData? data, {bool isTransform2FilePath = true}) async {
  if (data == null) {
    toast(BaseTrs.imgNull.tr);
    return '';
  }
  Map<String, Object> result = Map.castFrom(await ImageGallerySaver.saveImage(data.buffer.asUint8List(), quality: 100));
  if (result['isSuccess'] == true) {
    '图片已保存到相册, filePath: ${result['filePath']}'.logI();
    toast(BaseTrs.imgSaved2Gallery.tr);
    var uri = result['filePath'] as String;
    return isTransform2FilePath ? (await toFile(uri)).absolute.path : uri;
  } else {
    toast(BaseTrs.imgSaved2GalleryFailed.tr);
    return '';
  }
}

/// 选择图片
Future<List<AssetEntity>> pickImage(
  BuildContext context, {
  int maxCount = 1,
  bool enableCamera = true,
  bool enableRecording = false,
  List<AssetEntity>? selectedList,
}) async {
  return await AssetPicker.pickAssets(context,
          pickerConfig: AssetPickerConfig(
            textDelegate: const AssetPickerTextDelegate(),
            maxAssets: maxCount,
            requestType: RequestType.image,
            selectedAssets: selectedList,
            specialPickerType: SpecialPickerType.noPreview,
            specialItemPosition: SpecialItemPosition.prepend,
            specialItemBuilder: enableCamera
                ? (ctx, entity, i) {
                    return GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () async {
                        /// 开始拍摄
                        final AssetEntity? result = await CameraPicker.pickFromCamera(ctx, pickerConfig: CameraPickerConfig(enableRecording: enableRecording));

                        if (result == null) {
                          return;
                        }

                        /// 拍摄获取到照片后，放入列表中
                        final AssetPicker<AssetEntity, AssetPathEntity> picker = ctx.findAncestorWidgetOfExactType()!;
                        final DefaultAssetPickerBuilderDelegate builder = picker.builder as DefaultAssetPickerBuilderDelegate;
                        final DefaultAssetPickerProvider p = builder.provider;
                        await p.switchPath(
                          PathWrapper<AssetPathEntity>(
                            path: await p.currentPath!.path.obtainForNewProperties(),
                          ),
                        );
                        p.selectAsset(result);
                      },
                      child: const Icon(Icons.camera_alt_outlined, size: 42),
                    );
                  }
                : null,
          )) ??
      [];
}

/// 返回图片获取结果
// void handlePickResult(List<AssetEntity> entity, State state, String saveDir) {
//   if (entity.length == 1 && entity[0] != localSingleImageEntity) {
//     localSingleImageEntity = entity[0];
//     localSingleImageEntity?.file.then((value) {
//       singleImagePath = value?.path ?? "";
//       "pickSingleImage url: $singleImagePath".logI();
//
//       // showPb();
//
//       String from = singleImagePath!;
//       String to = "$saveDir${getNameInPath(singleImagePath!)}";
//
//       /// 压缩图片
//       compressAndGetImageFilePath(imageFilePath: from, targetPath: to).then((value) {
//         // hidePb();
//         if (state.mounted) {
//           state.setState(() {
//             singleImagePath = value;
//           });
//         }
//       });
//     });
//   }
// }

/// 图片最大文件大小为1M
const imgMaxSizeByByte = 1000000;

/// 压缩图片
Future<String> compressAndGetImageFilePath({required String imageFilePath, required String targetPath, int maxSize = imgMaxSizeByByte}) async {
  File? file = await compressAndGetImageFile(imageFile: File(imageFilePath), targetPath: targetPath, maxSize: maxSize);
  return file?.absolute.path ?? "";
}

/// 压缩图片
Future<File?> compressAndGetImageFile({required File imageFile, required String targetPath, int maxSize = imgMaxSizeByByte}) async {
  if (!imageFile.existsSync()) {
    "$imageFile 图片不存在".logE();
    return null;
  }

  File? result;
  int oldSize = imageFile.lengthSync();
  int size = oldSize;
  int quality = 100;
  "开始图片压缩, 原始大小: $oldSize, 目标大小: $maxSize，from ${imageFile.absolute.path} to $targetPath".logI();

  /// 必须先创建文件，才能压缩
  File target = File(targetPath);
  if (!target.existsSync()) {
    createFile(targetPath);
  }

  "图片及文件夹创建完成".logI();

  /// 图片文件小，直接复制
  if (size < maxSize) {
    "图片不需要压缩即满足大小".logI();
    result = imageFile.copySync(targetPath);
    return result;
  }

  do {
    quality -= 8;
    var xFile = await FlutterImageCompress.compressAndGetFile(imageFile.absolute.path, targetPath, quality: quality);
    if (xFile == null) {
      "$imageFile 压缩失败".logI();
      break;
    }
    result = File(xFile.path);
    if (result.lengthSync() == 0) {
      "$imageFile 压缩失败".logI();
      break;
    }
    size = result.lengthSync();
    "压缩进度：质量：$quality, 大小：$size".logI();
  } while (size > maxSize && quality > 10);

  "$imageFile is Compressed from ${imageFile.lengthSync()} to ${result?.lengthSync()}, at $targetPath".logI();
  return result;
}

///save network image to photo
Future<bool> saveNetworkImageToPhoto(String url, {bool useCache = true}) async {
  if (kIsWeb) {
    return false;
  }
  final Uint8List? data = await getNetworkImageData(url, useCache: useCache);
  // var filePath = await ImagePickerSaver.saveFile(fileData: data);
  // return filePath != null && filePath != '';
  final AssetEntity? imageEntity = await PhotoManager.editor.saveImage(data!, title: '保存到相册');

  return imageEntity != null;
}

/// 清除ExtendedImage缓存
Future<bool> clearExtendedImageCache() async {
  clearMemoryImageCache();
  return await clearDiskCachedImages();
}

// Future<AssetEntity?> pickSingleMedia(BuildContext context, List<AssetEntity> selectedAssets, RequestType type) async {
//   List<AssetEntity>? list = await AssetPicker.pickAssets(context,
//       pickerConfig: AssetPickerConfig(maxAssets: 1, selectedAssets: selectedAssets, specialPickerType: SpecialPickerType.noPreview, requestType: type));
//   if (list != null && list.length == 1) {
//     return list[0];
//   } else {
//     return null;
//   }
// }
