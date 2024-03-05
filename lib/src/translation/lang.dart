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
  final initSettingFailed = "initSettingFailed";
  final initUserFailed = "initUserFailed";
  final selected = "selected";
  final favorite = "favorite";
  final selectNone = "selectNone";
  final feedbackTitle = "feedbackTitle";
  final feedback = "feedback";
  final feedbackFailed = "feedbackFailed";
  final clearCache = "clearCache";
  final clearCacheSuc = "clearCacheSuc";
  final checkUpdate = "checkUpdate";
  final checkUpdateLoading = "checkUpdateLoading";
  final checkUpdateNo = "checkUpdateNo";
  final checkUpdateYes = "checkUpdateYes";
  final checkUpdateFailed = "checkUpdateFailed";
  final curVersionPrefix = "curVersionPrefix";
  final appVersion = "appVersion";
  final curDevicePrefix = "curDevicePrefix";
  final clear = "clear";
  final labelAppInfo = "labelAppInfo";
  final labelAppName = "labelAppName";
  final labelAuthorInfo = "labelAuthorInfo";
  final labelAuthor = "labelAuthor";
  final labelContact = "labelContact";
  final labelAuthorSite = "labelAuthorSite";
  final homeSite = "homeSite";
  final tip = "tip";
  final tipPolicy1 = "tipPolicy1";
  final tipPolicy2 = "tipPolicy2";
  final tipPolicy3 = "tipPolicy3";
  final agree = "agree";
  final introFirstTip = "introFirstTip";
  final qrcode = "qrcode";
  final updateNow = "updateNow";
  final updateNext = "updateNext";

  // app
  final doRandom = "doRandom";
  final pause = "pause";
  final start = "start";
  final continues = "continues";
  final reset = "reset";
  final leaderboard = "leaderboard";
  final close = "close";
  final sortNo = "sortNo";
  final timeCount = "timeCount";
  final timeAt = "timeAt";
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
  BaseTrs.close: '关闭',
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
  // 系统参数
  BaseTrs.initSettingFailed: 'Init setting failed, try again later.',
  BaseTrs.initUserFailed: 'Init user data failed, try again later.',
  BaseTrs.selected: 'selected',
  BaseTrs.favorite: 'Favorite',
  // 设置
  BaseTrs.introFirstTip: 'Show introduce soon on first start',
  BaseTrs.feedbackTitle: 'Feedback',
  BaseTrs.feedback: 'Feedback',
  BaseTrs.clearCache: 'Clear cache',
  BaseTrs.clearCacheSuc: 'cache cleared',
  BaseTrs.clear: 'Clear',
  // 更新
  BaseTrs.checkUpdate: 'Check Update',
  BaseTrs.checkUpdateLoading: 'Checking Update...',
  BaseTrs.feedbackFailed: 'Open mail failed, you can send me a mail by yourself.',
  BaseTrs.checkUpdateNo: 'It\'s the latest version now.',
  BaseTrs.checkUpdateYes: 'The latest version (##) is detected. Do you want to update it immediately?',
  BaseTrs.checkUpdateFailed: 'Update check failed, try again later.',
  BaseTrs.curVersionPrefix: 'now',
  BaseTrs.updateNow: 'Update Now',
  BaseTrs.updateNext: 'Not now',
  BaseTrs.appVersion: 'Version',
  // 关于
  BaseTrs.qrcode: 'Download QRCode',
  BaseTrs.curDevicePrefix: 'Device info',
  BaseTrs.labelAppInfo: 'App Information',
  BaseTrs.labelAppName: 'Name',
  BaseTrs.labelAuthorInfo: 'Author Information',
  BaseTrs.labelAuthor: 'Author',
  BaseTrs.labelContact: 'Contact',
  BaseTrs.labelAuthorSite: 'Website',
  BaseTrs.homeSite: 'Home site',
  // 隐私政策
  BaseTrs.tip: 'Tip',
  BaseTrs.tipPolicy1:
      '\t\t\t\t\t\t\tFor better application security and experience, you will apply for the required permissions when using specific functions in the app. Please authorize the application at that time. We promise not to obtain and illegally use users\' private information, please read ',
  BaseTrs.tipPolicy2: 'Privacy Policy',
  BaseTrs.tipPolicy3: 'carefully to get details。\n\n\t\t\t\t\t\t\tClick "Cancel" to exit the application; Click "Agree" to start using.',
  BaseTrs.agree: 'Agree',
  // 其他
  BaseTrs.doRandom: 'Loading',
  BaseTrs.pause: 'Pause',
  BaseTrs.start: 'Start',
  BaseTrs.continues: 'Continue',
  BaseTrs.reset: 'Reset',
  BaseTrs.leaderboard: 'Leaderboard',
  BaseTrs.sortNo: 'No.',
  BaseTrs.timeCount: 'Time spent',
  BaseTrs.timeAt: 'Time point',
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
  BaseTrs.close: '关闭',
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
  // 系统参数
  BaseTrs.initSettingFailed: '初始化配置失败，请稍后再试。',
  BaseTrs.initUserFailed: '获取用户信息失败，请稍后再试。',
  BaseTrs.selected: '已选择',
  BaseTrs.favorite: '收藏',
  // 设置
  BaseTrs.introFirstTip: '首次启动，即将展示介绍内容',
  BaseTrs.feedbackTitle: '意见反馈',
  BaseTrs.feedback: '意见反馈',
  BaseTrs.clearCache: '清理缓存',
  BaseTrs.clearCacheSuc: '缓存清理完成',
  BaseTrs.clear: '清空',
  // 更新
  BaseTrs.checkUpdate: '检查更新',
  BaseTrs.checkUpdateLoading: '正在检查更新...',
  BaseTrs.feedbackFailed: '邮箱启动失败，你可以手动发送邮件给我哟。',
  BaseTrs.checkUpdateNo: '当前已经是最新版本。',
  BaseTrs.checkUpdateYes: '检测到有最新版本(##)，是否立即进行更新？',
  BaseTrs.checkUpdateFailed: '更新检查失败，过一会儿再试吧。',
  BaseTrs.curVersionPrefix: '当前版本',
  BaseTrs.updateNow: '立即更新',
  BaseTrs.updateNext: '下次再说',
  BaseTrs.appVersion: '应用版本',
  // 关于
  BaseTrs.qrcode: '下载二维码',
  BaseTrs.curDevicePrefix: '设备信息',
  BaseTrs.labelAppInfo: '应用信息',
  BaseTrs.labelAppName: '应用名称',
  BaseTrs.labelAuthorInfo: '作者信息',
  BaseTrs.labelAuthor: '作者',
  BaseTrs.labelContact: '联系方式',
  BaseTrs.labelAuthorSite: '个人网站',
  BaseTrs.homeSite: '主页',
  // 隐私政策
  BaseTrs.tip: '提示',
  BaseTrs.tipPolicy1: '\t\t\t\t\t\t\t为了更好的应用安全和体验，在使用应用内特定功能时将申请相应所需权限，届时请授权申请。我们承诺不会私自获取和非法使用用户隐私信息，请仔细阅读',
  BaseTrs.tipPolicy2: '《隐私政策》',
  BaseTrs.tipPolicy3: '了解详细信息。\n\n\t\t\t\t\t\t\t点击“取消”退出应用；点击“同意”开始使用。',
  BaseTrs.agree: '同意',
  // 其他
  BaseTrs.doRandom: '准备中',
  BaseTrs.pause: '暂停',
  BaseTrs.start: '开始',
  BaseTrs.continues: '继续',
  BaseTrs.reset: '重置',
  BaseTrs.leaderboard: '排行榜',
  BaseTrs.sortNo: '排名',
  BaseTrs.timeCount: '用时',
  BaseTrs.timeAt: '时间',
};
