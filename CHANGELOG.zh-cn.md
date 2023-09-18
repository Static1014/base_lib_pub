## 2.0.3

1. 丰富mAppBar、Header的入参；
2. 修改默认appBar高度为56；
3. 修改example默认路由调整动画；

## 2.0.2

1. 新增DataUtils，支持本地数据存储；
2. 修改README，去除项目依赖部分；

## 2.0.1

1. 修改BaseRoutes及example中Routes的继承方法getPages来汇集routes；

## 2.0.0

1. 调整部分基础类与其对应扩展的实现方式；
2. 新增非singleTop方式启动页面，并通过tag获取相同页面不同实例的controller；
3. 新增CommonWebView，支持打开url、html文本、本地html文件和html asset；
4. 新增Header组件；
5. 新增url_launcher pub及使用；
6. 新增mOverSizeScrollView支持view超过指定尺寸可滚动；

## 1.4.0

1. 将TestPage移动到example项目中；
2. 新增CommonWebViewPage，支持快速打开远程html页面;

## 1.3.1

1. 导出ListFooter、新增MySalomonBottomBar；

## 1.3.0

1. 新增ListFooter组件，可用于分页加载；
2. 新增MySalomonBottomBar，由salomonBottomBar修改而来，增加了双击回调，自定义高度；

## 1.2.4

1. 添加静态ImagePreviewLogic；

## 1.2.3

1. 私有化ImagePreviewLogic不必须暴露的属性和方法，只暴露需要暴露的；
2. 通过library、part、part of管理一组类及文件，可通过对类(_ClassName)私有化类并通过part对同组成员可见；

## 1.2.2

1. 修正example中预览下标值；
2. ScrollControllerExt新增toggleScroll方法：如果在顶部，滚动到底部；否则滚动到顶部；

## 1.2.1

1. 修复ImagePreviewPage切换page index后，bottomView和actionView中无法更新相应index状态的bug;
2. ImagePreviewPage新增onPreviewIndexChanged回调；

## 1.2.0

1. ImagePreviewPage新增支持添加右上角的actionView;
2. README修改；

## 1.1.1

1. common_utils新增vibrate震动方法；
2. pub更新;

## 1.1.0

1. pub更新;
2. 基于flutter 3.13.3;

## 0.0.1

* 初始化版本；

## 0.0.2

* 基础调整

1. pub精简；
2. 部分util统一管理，子项目无需引用；
    1. toast；
3. 启动调整；

## 0.0.3

* export调整，一次导入；

## 0.0.4

* 目录调整；

## 0.0.5

* file_utils 日志调整；

## 0.0.6

* aes_utils调整；

## 0.0.7

* 自动发布；

## 0.0.8

* 精简log；

## 0.0.9

* 测试自动发布；

## 0.1.0

* 新增network_utils；

## 0.1.1

* 导出network_utils；

## 0.1.2

1. network_utils新增get、post通用请求方法；
2. 简化log格式；

## 0.1.3

1. 网络请求日志格式调整；

## 0.1.4

1. 更新Trs；
2. 网络请求实例初始化不自动发起；

## 0.1.5

1. 新增通用转圈；

## 0.1.6

1. 调整通用转圈样式；

## 0.1.7

1. 调整通用转圈样式；

## 0.1.8

1. 切换日志输出模式，由Get.log()输出，去除前缀“I/flutter (29368):”；

## 0.1.9

1. 调整日志格式；
2. 依赖项目中Image.asset()必须传package，子项目引用依赖中的资源也需要；
3. 调整assets目录；

## 0.2.0

1. 新增example项目，方便lib自身测试；
2. 调整BaseDimens.dStatusBarHeight值的获取方式；
3. 调整ImagePreview样式；
4. 调整log样式；

## 0.2.1

1. 调整ImagePreview支持显示文字；

## 0.2.2

1. 调整ImagePreview支持显示文字，支持修改文字及背景颜色；
2. 新增mFadeInView，动画显示View；

## 0.2.3

1. 调整ImagePreview支持显示文字，参数调整；

## 1.0.0

1. 完善README，新增英文版本（机器翻译）；
2. 去掉部分警告；

## 1.0.1

1. 修改README;

## 1.0.2

1. 修改 README;
2. 升级 pub 'permission_handler';
3. 修改license；

## 1.0.3

1. 修复mFadeInView不显示的bug;
2. 调整ImagePreview页面中底部ui布局;

## 1.0.4

1. 更新日志格式;

## 1.0.5

1. 修复ImagePreviewPage hero中image显示动画闪动的问题;
2. 修改mLoadImageView加载成功动画仅在异步加载成功时显示；

## 1.0.6

1. 删除ImagePreviewPage中无用参数;
2. 默认开启mLoadImageView加载成功动画；

## 1.0.7

1. mLoadImageView支持添加背景颜色;
2. mLoadImageView支持设置网络图片超时时间;

## 1.0.8

1. 修改dio默认连接超时时间;
2. common_utils新增doDelayOn、doInterval方法；

## 1.0.9

1. mLoadImageView默认无背景颜色;
2. 修复api日志格式错误；

## 1.0.10

1. 新增KeepAliveWrapper，保持TabBarView、ViewPager状态；
2. 新增GetTicker，支持创建TabController；

## 1.0.11

1. 导出；