<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

This is a baseLib pub based on getx.

## Features

1. common extensions;
2. common pages;
3. common utils;
4. common translations;
5. common ui;
6. ...

## Getting started

1. This lib is just tested on Android。
2. kotlin version: 1.8.0;
3. gradle 7.4.2 on distributions/gradle-7.5-all.zip;


## Usage

TODO: Include short and useful examples for package users. Add longer examples
to `/example` folder.

```dart
import 'package:pic_maker/_baseLib/base_main.dart';

// ...

void main() {
  initBaseApp(
    enableLog: MyConst.isDebug || MyConst.isForceLog,
    unPopRoutes: [Routes.init, Routes.home],
    initWeChat: true,
  );

  runApp(const MyApp());
}
```

## Additional information

We are happy to share this pub.
