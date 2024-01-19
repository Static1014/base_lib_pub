/// Name: lang.dart
///
/// Created by Static4u
/// Date : 2023/7/14 10:07

// ignore: non_constant_identifier_names
final BaseTrs = BaseTrsClass();

class BaseTrsClass {
  /// ************************************************ base ************************************************
  // 双击退出
  final exitOnDoubleClick = "exitOnDoubleClick";
  final crash = "crash";
  final delete = "delete";
  final deleteTip = "deleteTip";
  final leftDelete = "leftDelete";
  final leaveOne = "leaveOne";
  final cancel = "cancel";
  final share = "share";
  final saveToGallery = "saveToGallery";
  final save = "save";
  final confirm = "confirm";
  final warn = "warn";
  final noMore = "noMore";
  final loading = "loading";
  final retry = "retry";

  // imgUtils
  final imgNull = "imgNull";
  final imgSaved2Gallery = "imgSaved2Gallery";
  final imgSaved2GalleryFailed = "imgSaved2GalleryFailed";
  final permissionTipStorage = "permissionTipStorage";
  final permissionTipCamera = "permissionTipCamera";
  final permissionTipDefault = "permissionTipDefault";
  final permissionTipFailed = "permissionTipFailed";
  final startAuthPermission = "startAuthPermission";
  final manuallyAuthPermission = "manuallyAuthPermission";

  // share
  final shareEmpty = "shareEmpty";
  final shareNoFile = "shareNoFile";

  // setting
  final setting = "setting";
  final about = "about";
  final privacy = "privacy";

  // 测试页
  final testTitle = "testTitle";
  final goTest = "goTest";

  final closePageConfirmTip = "closePageConfirmTip";
  final notSingleTopError = "notSingleTopError";
  final previewListEmpty = "previewListEmpty";
}

final baseEnUS = {
  /// base
  BaseTrs.noMore: 'No more',
  BaseTrs.loading: 'Loading...',
  BaseTrs.warn: 'Warn',
  BaseTrs.save: 'Save',
  BaseTrs.confirm: 'OK',
  BaseTrs.deleteTip: 'Are you sure to delete it?',
  BaseTrs.saveToGallery: 'Send to gallery',
  BaseTrs.cancel: 'Cancel',
  BaseTrs.share: 'Share',
  BaseTrs.delete: 'Delete',
  BaseTrs.leftDelete: '<< Sliding left to delete',
  BaseTrs.leaveOne: 'It can\'t be less',
  BaseTrs.setting: 'Setting',
  BaseTrs.about: 'About',
  BaseTrs.privacy: 'Privacy Policy',
  BaseTrs.testTitle: 'Test Page',
  BaseTrs.goTest: 'go Test Page',
  BaseTrs.exitOnDoubleClick: 'Double click to exit',
  BaseTrs.crash: 'Something Wrong',
  // 权限
  BaseTrs.permissionTipCamera: 'This function requires take shoot with camera, please grant before using.',
  BaseTrs.permissionTipStorage: 'This function requires reading photos, media content and files from the memory card, please grant before using.',
  BaseTrs.permissionTipDefault: 'Grant permission to the application before using it.',
  BaseTrs.startAuthPermission: 'Grant',
  BaseTrs.permissionTipFailed: 'Grant failure. Please grant permissions manually on app settings page.',
  BaseTrs.manuallyAuthPermission: 'Grant manually',
  // 图片处理
  BaseTrs.imgNull: 'Image Data is wrong',
  BaseTrs.imgSaved2Gallery: 'Image has been saved to Gallery',
  BaseTrs.imgSaved2GalleryFailed: 'There\'s something wrong to save image',
  BaseTrs.shareEmpty: 'You need to choose something to share',
  BaseTrs.shareNoFile: 'The file you choose is not existed, please try another one',
  BaseTrs.retry: 'Retry',
  BaseTrs.closePageConfirmTip: 'Are you sure to close current page?',
  BaseTrs.notSingleTopError: 'A unique tag must be passed in non-SingleTOP mode',
  BaseTrs.previewListEmpty: 'There are no items to preview.',
};

final baseZhCN = {
  /// base
  BaseTrs.noMore: '没有更多了',
  BaseTrs.loading: '加载中...',
  BaseTrs.warn: '警告',
  BaseTrs.save: '保存',
  BaseTrs.confirm: '确定',
  BaseTrs.deleteTip: '确定要删除吗？',
  BaseTrs.saveToGallery: '保存至相册',
  BaseTrs.share: '分享',
  BaseTrs.cancel: '取消',
  BaseTrs.delete: '删除',
  BaseTrs.leftDelete: '<< 左滑删除',
  BaseTrs.leaveOne: '不能再删啦',
  BaseTrs.setting: '设置',
  BaseTrs.about: '关于',
  BaseTrs.privacy: '隐私政策',
  BaseTrs.testTitle: '测试页',
  BaseTrs.goTest: '打开测试页',
  BaseTrs.exitOnDoubleClick: '双击退出',
  BaseTrs.crash: '好像哪里出错了',
  // 权限
  BaseTrs.permissionTipStorage: '该功能需要读取存储卡中的照片、媒体内容和文件，请授权后再使用。',
  BaseTrs.permissionTipCamera: '该功能需要使用设备相机进行拍摄，请授权后再使用。',
  BaseTrs.permissionTipDefault: '请授予应用相应权限后再使用。',
  BaseTrs.permissionTipFailed: '授权失败，请前往应用设置页手动授权。',
  BaseTrs.startAuthPermission: '开始授权',
  BaseTrs.manuallyAuthPermission: '手动授权',
  // 图片处理
  BaseTrs.imgNull: '图片资源有误',
  BaseTrs.imgSaved2Gallery: '图片已保存到相册',
  BaseTrs.imgSaved2GalleryFailed: '图片保存失败',
  BaseTrs.shareEmpty: '分享内容不能为空',
  BaseTrs.shareNoFile: '你选择的文件不存在，换一个吧',
  BaseTrs.retry: '重试',
  BaseTrs.closePageConfirmTip: '你确定要关闭当前页面吗？',
  BaseTrs.notSingleTopError: '非SingleTop模式下必须传入唯一tag',
  BaseTrs.previewListEmpty: '没有可预览的项目。',
};
