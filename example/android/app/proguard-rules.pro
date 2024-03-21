# Add project specific ProGuard rules here.
# By default, the flags in this file are appended to flags specified
# in /Users/xiongjian/Documents/android-sdk-macosx/tools/proguard/proguard-android.txt
# You can edit the include path and order by changing the proguardFiles
# directive in build.gradle.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

# Add any project specific keep options here:
# ==========================================
# 通用设置
# ==========================================
# 压缩优化算法
#-optimizations !code/simplification/arithmetic,!field/*,!class/merging/*
# 迭代优化次数
-optimizationpasses 5
# 混合时不使用大小写混合，混合后的类名为小写
-dontusemixedcaseclassnames
# 禁止优化
-dontoptimize
# 禁止缩减代码
-dontshrink
## 不做预校验，preverify是proguard的四个步骤之一，Android不需要preverify 能够加快混淆速度。
-dontpreverify
# 输出详细LOG， 使我们的项目混淆后产生映射文件包含有类名->混淆后类名的映射关系
#-verbose
## 指定不去忽略非公共库的类
#-dontskipnonpubliclibraryclasses
## 指定不去忽略非公共库的类成员
#-dontskipnonpubliclibraryclassmembers
## 屏蔽警告
-ignorewarnings
# 保留Annotation不混淆
-keepattributes *Annotation*
# 避免混淆泛型
-keepattributes Signature
# 抛出异常时保留代码行号
-keepattributes SourceFile,LineNumberTable

## 使用printmapping指定映射文件的名称
#-printmapping proguardMapping.txt
#
-keep class io.flutter.app.** { *; }

-keep class io.flutter.plugin.** { *; }

-keep class io.flutter.util.** { *; }

-keep class io.flutter.view.** { *; }

-keep class io.flutter.** { *; }

-keep class io.flutter.plugins.** { *; }

-keep class org.xmlpull.v1.** { *; }
