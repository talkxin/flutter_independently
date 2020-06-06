## 在 mac 上进行运行 flutter 项目

### 连接 Android 模拟器/模拟器

1. flutter 可以使用 Android 默认模拟器，或者 genymotion 模拟器。
2. vscode 中启动调试，选择 Android 设备，IDE 会自动查找可连接设备，并在模拟器或真机中运行。
   > Android 真机设备需要在设置中打开`开发者选项`中的`USB 调试`选项
   > `download.flutter.io`在下载时需要切一下 vpn，这个地址已经被墙

具体模拟器 AVD 模拟器的详细，可以参考[Managing AVDs](https://developer.android.com/studio/run/managing-avds.html)官方文档。

### 连接 ios 模拟器

1. 在 vscode 中启动调试，选择 IOS 设备，若没有连接真机，IDE 会自动打开 xcode，启动模拟器。
2. IOS 模拟器运行 flutter 项目需要运行在 iPhone 5s 或更高版本。

### 连接 IOS 真机

1. 遵循 xcode 签名流程配置项目

- 在 vscode 中打开终端，执行`open ios/Runner.xcworkspace`，打开 xcode
- 打开 Xcode，打开右上角`Xcode`，选择`Preferences`
- 选择`Accounts`，点击左下角+号，添加`Apple ID`。
- 选择`Download Manual Profiles`，下载好以后，选择`Manage Cerificates`，就可以查询到当前登陆 AppleID 的 Mac 电脑
- 返回 Xcode，选择`Runner`标签，进入`Signing & Capabilities`，配置之前的开发 team，即可进行真机调试
  > 如果出现`Failed to register bundle identifier.`错误，需要根据提示修改，譬如`The app identifier "com.example.helloWorld" cannot be registered to your development team. Change your bundle identifier to a unique string to try again.`，则需要修改`Bundel ldentifier`为合法包名即可

* 在真机中选择`通用`，`设备管理`，`信任应用`即可开始进行真机的 debug 调试工作

## vscode 中常用 Flutter 命令简介：

打开命令面板，输入`Flutter:`，会列出 Flutter 相关命令，这里简单介绍几个我们常用的命令：

```shell
    # 创建项目
    Flutter:New Project
    # 打开/创建模拟器
    Flutter:Launch Emulator
    # 切换运行设备
    Flutter:Select Device
    # 切换SDK
    Flutter:Change SDK
    # 更新SDK
    Flutter:Run Flutter Upgrade
    # 清理项目
    Flutter:Clean Project
```
