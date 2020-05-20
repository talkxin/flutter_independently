## 在mac上进行运行flutter项目
### 连接Android模拟器/模拟器
1. flutter可以使用Android默认模拟器，或者genymotion模拟器。
2. vscode中启动调试，选择Android设备，IDE会自动查找可连接设备，并在模拟器或真机中运行。
> Android真机设备需要在设置中打开`开发者选项`中的`USB 调试`选项
> `download.flutter.io`在下载时需要切一下vpn，这个地址已经被墙


具体模拟器AVD模拟器的详细，可以参考[Managing AVDs](https://developer.android.com/studio/run/managing-avds.html)官方文档。
### 连接ios模拟器
1. 在vscode中启动调试，选择IOS设备，若没有连接真机，IDE会自动打开xcode，启动模拟器。
2. IOS模拟器运行flutter项目需要运行在iPhone 5s或更高版本。


### 连接IOS真机
1. 遵循xcode签名流程配置项目


- 在vscode中打开终端，执行`open ios/Runner.xcworkspace`，打开xcode
- 打开Xcode，打开右上角`Xcode`，选择`Preferences`
- 选择`Accounts`，点击左下角+号，添加`Apple ID`。
- 选择`Download Manual Profiles`，下载好以后，选择`Manage Cerificates`，就可以查询到当前登陆AppleID的Mac电脑
- 返回Xcode，选择`Runner`标签，进入`Signing & Capabilities`，配置之前的开发team，即可进行真机调试
> 如果出现`Failed to register bundle identifier.`错误，需要根据提示修改，譬如`The app identifier "com.example.helloWorld" cannot be registered to your development team. Change your bundle identifier to a unique string to try again.`，则需要修改`Bundel ldentifier`为合法包名即可


- 在真机中选择`通用`，`设备管理`，`信任应用`即可开始进行真机的debug调试工作