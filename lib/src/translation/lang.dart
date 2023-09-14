/// Name: lang.dart
///
/// Created by Static4u
/// Date : 2023/7/14 10:07
class MyBaseTrs {
  const MyBaseTrs();

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
}

const baseTrs = MyBaseTrs();

final baseEnUS = {
  /// base
  baseTrs.noMore: 'No more',
  baseTrs.loading: 'Loading...',
  baseTrs.warn: 'Warn',
  baseTrs.save: 'Save',
  baseTrs.confirm: 'OK',
  baseTrs.deleteTip: 'Are you sure to delete it?',
  baseTrs.saveToGallery: 'Send to gallery',
  baseTrs.cancel: 'Cancel',
  baseTrs.share: 'Share',
  baseTrs.delete: 'Delete',
  baseTrs.leftDelete: '<< Sliding left to delete',
  baseTrs.leaveOne: 'It can\'t be less',
  baseTrs.setting: 'Setting',
  baseTrs.about: 'About',
  baseTrs.privacy: 'Privacy Policy',
  baseTrs.testTitle: 'Test Page',
  baseTrs.goTest: 'go Test Page',
  baseTrs.exitOnDoubleClick: 'Double click to exit',
  baseTrs.crash: 'Something Wrong',
  baseTrs.permissionTipStorage: 'Please authorize the use of storage permissions first',
  baseTrs.imgNull: 'Image Data is wrong',
  baseTrs.imgSaved2Gallery: 'Image has been saved to Gallery',
  baseTrs.imgSaved2GalleryFailed: 'There\'s something wrong to save image',
  baseTrs.shareEmpty: 'You need to choose something to share',
  baseTrs.shareNoFile: 'The file you choose is not existed, please try another one',
  baseTrs.retry: 'Retry',
};

final baseZhCN = {
  /// base
  baseTrs.noMore: '没有更多了',
  baseTrs.loading: '加载中...',
  baseTrs.warn: '警告',
  baseTrs.save: '保存',
  baseTrs.confirm: '确定',
  baseTrs.deleteTip: '确定要删除吗？',
  baseTrs.saveToGallery: '保存至相册',
  baseTrs.share: '分享',
  baseTrs.cancel: '取消',
  baseTrs.delete: '删除',
  baseTrs.leftDelete: '<< 左滑删除',
  baseTrs.leaveOne: '不能再删啦',
  baseTrs.setting: '设置',
  baseTrs.about: '关于',
  baseTrs.privacy: '隐私政策',
  baseTrs.testTitle: '测试页',
  baseTrs.goTest: '打开测试页',
  baseTrs.exitOnDoubleClick: '双击退出',
  baseTrs.crash: '好像哪里出错了',
  baseTrs.permissionTipStorage: '请先授权使用存储权限',
  baseTrs.imgNull: '图片资源有误',
  baseTrs.imgSaved2Gallery: '图片已保存到相册',
  baseTrs.imgSaved2GalleryFailed: '图片保存失败',
  baseTrs.shareEmpty: '分享内容不能为空',
  baseTrs.shareNoFile: '你选择的文件不存在，换一个吧',
  baseTrs.retry: '重试',
};
