## 发布桌面端 APP

1. 目前 Fluter SDK 打包桌面端 APP 仅在`master`或`dev`分支下支持。

```dart
flutter channel master
flutter upgrade
```

2. 打开对桌面端的编译支持：

```dart
flutter config --enable-macos-desktop
```

3. 检查是否识别目前设备：

```dart
1 connected device:

macOS • macOS • darwin-x64 • Mac OS X 10.15.4 19E287
```

> 若使用 vscode，此时重启窗口，也可以通过 vscode 扫描出该设备。

3. 将 desktop 编译工程加入到项目中；若打开的是一个成熟的工程，该工程默认仅会添加 Android 与 IOS 的编译支持，此时需要将编译工程加入到项目中，在工程根目录执行：

```dart
flutter create .
```

此时会创建一个对应设备系统的编译文件夹，譬如 macos

> 如桌面端编译开关`enable-macos-desktop`已打开，此时新建项目会默认创建对应系统的编译文件夹。

4. 此时在 vscode 执行 run，即可在该系统上执行调试流程；或者在终端上执行：

```dart
flutter run -d macos
```

亦可以达到相同的目的
