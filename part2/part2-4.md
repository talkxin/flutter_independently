## 发布IOS版APP


### 在iTunes Connect上创建应用程序记录


1、打开[iTunes Connect](https://itunesconnect.apple.com/)


2、登陆iTunes Connect并进入`My Apps`页面


3、点击左上角+号，选择New App。


4、填写应用详细信息，在Platforms部分中，确保已选中iOS。由于Flutter目前不支持tvOS，请不要选中该复选框。点击Create。


5、导航到您app的应用程序详细信息，App Information 。


6、在 General Information 部分, 选择您在上一步中注册的软件包ID。


### 查看Xcode项目设置
1、 在项目工程目录，执行`open ios/Runner.xcworkspace`打开Xcode。


2、在左侧项目导航器中选择Runner项目并在弹出的界面中，选择General选项卡:


#### Identity部分：

- `Display Name`:要在主屏幕和其他地方显示的应用程序的名称
- `Bundle Identifier`:您在iTunes Connect上注册的App ID.


#### Signing 部分:
- `Automatically manage signing`:Xcode是否应该自动管理应用程序签名和生成。默认设置为true，对大多数应用程序来说应该足够了。
- `Team`:选择与您注册的Apple Developer帐户关联的团队。如果需要，请选择Add Account…，然后更新此设置


#### Deployment Info 部分:
- `Deployment Target`:您的应用将支持的最低iOS版本。Flutter支持iOS 8.0及更高版本。如果您的应用程序包含使用iOS 8中不可用的API的Objective-C或Swift代码，请适当更新此设置。


### 添加应用图标
1、在左侧项目导航器中选择Runner文件夹进入，并选择`Assets.xcassets`，使用您自己的应用程序图标更换占位图标


2、运行`flutter run`，验证应用图标是否已经被替换。


### 创建构建档案


1、在项目根目录执行`flutter build ios`创建项目的release版本
> `flutter build` 默认为 `--release`



3、在Xcode中，配置应用程序版本并构建：


- 在项目工程目录，执行`open ios/Runner.xcworkspace`打开Xcode。
- 选择`Product > Scheme > Runner`
- 选择`Product > Destination > Generic iOS Device`
- 在Xcode项目导航器中选择 Runner , 然后在设置视图边栏中选择选择 Runner target
- 在Identity部分中，将`Version`更新为您希望发布的面向用户的版本号
- 在Identity部分中，将`Build`标识更新为用于跟踪`iTunes Connect`上的此版本的唯一版本号。每次上传都需要一个唯一的`build`号


4、创建一个构建档案并将其上传到iTunes Connect：


- 选择 `Product > Archive` 以生成构建档案
- 在`Xcode Organizer`窗口的边栏中，选择您的iOS应用程序，然后选择您刚刚生成的build档案
- 点击`Validate… `按钮. 如果报错，请解决它们并生成另一个build。您可以重复使用相同的build ID，直到您上传档案
- 案已成功验证后，单击`Upload to App Store…`，您可以在iTunes Connect的应用详情也的`Activities`选项卡中查看构建状态


5、您应该在30分钟内收到一封电子邮件，通知您您的构建已经过验证，并可以在TestFlight上发布给测试人员。此时，您可以选择是否在TestFlight上发布，或继续并将您的release版发布到App Store。


### 在TestFlight上发布您的应用程序


>可以通过TestFlight，将程序推送给内部或者外部的测试人员。


1、在[iTunes Connect](https://itunesconnect.apple.com/)上导航到应用程序详细信息页面的TestFlight选项卡


2、在侧边栏选择 Internal Testing


3、选择要发布到测试人员的build，然后单击 Save


4、加任何内部测试人员的电子邮件地址。您可以在iTunes Connect的用户和角色页面添加更多的内部用户，可从页面顶部的下拉菜单中获得。


### 将您的应用发布到App Store


1、从iTunes应用程序的应用程序详情页的边栏中选择Pricing and Availability，然后填写所需的信息。


2、从边栏选择状态。如果这是该应用的第一个版本，则其状态将为1.0 Prepare for Submission。完成所有必填字段。


3、击 Submit for Review.


4、Apple会在应用程序审查过程完成时通知您。您的应用将根据您在Version Release部分指定的说明进行发布。


>有关更多详细信息，请参阅将[Submitting Your App to the Store](https://help.apple.com/xcode/mac/current/#/dev067853c94)


## 发布Android版APP


### 检查App Mainfest


1、查看默认Gradle 构建文件`build.gradle`，它位于`<app dir>/android/app/`，验证这些值是否正确，尤其是：
- defaultConfig:
  - applicationId: 指定始终唯一的 (Application Id)appid
  - versionCode & versionName: 指定应用程序版本号和版本号字符串。
  - minSdkVersion & targetSdkVersion: 指定最低的API级别以及应用程序设计运行的API级别。



2、添加启动图标:
- 在`<app dir>/android/app/src/main/res/`目录中，将图标文件放入使用[配置限定符](https://developer.android.com/guide/practices/screens_support.html#qualifiers)命名的文件夹中。默认mipmap-文件夹演示正确的命名约定。
- 在`AndroidManifest.xml`中，将`application`标记的`android:icon`属性更新为引用上一步中的图标。
- 运行`flutter run`，验证应用图标是否已经被替换。


### APP签名


1、创建 keystore：


在命令行中输入一下命令可以创建一个key： 
```
keytool -genkey -v -keystore ~/key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias key
```
> 注意：保持文件私密; 不要将它加入到公共源代码控制中</br>
> 注意: keytool可能不在你的系统路径中。它是Java JDK的一部分，它是作为Android Studio的一部分安装的。有关具体路径，请百度。


2、引用应用程序中的keystore


创建一个名为`<app dir>/android/key.properties`的文件，其中包含对密钥库的引用:


```
storePassword=<password from previous step>
keyPassword=<password from previous step>
keyAlias=key
storeFile=<location of the key store file, e.g. /Users/<user name>/key.jks>
```
> 注意：保持文件私密; 不要将它加入到公共源代码控制中</br>


3、在gradle中配置签名


可以通过编辑`<app dir>/android/app/build.gradle`文件为您的应用配置签名，示例如下：


- 新增key引用：
```
def keystorePropertiesFile = rootProject.file("key.properties")
def keystoreProperties = new Properties()
keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
```
- 关闭debug模式
```
buildTypes {
    release {
        // 目前状态为debug模式，替换该配置
        signingConfig signingConfigs.debug
    }
}
```
- 增加key引用
```
signingConfigs {
    release {
        keyAlias keystoreProperties['keyAlias']
        keyPassword keystoreProperties['keyPassword']
        storeFile file(keystoreProperties['storeFile'])
        storePassword keystoreProperties['storePassword']
    }
}
buildTypes {
    release {
        signingConfig signingConfigs.release
    }
}
```


#### 项目混淆


> 默认情况下 flutter 不会开启 Android 的混淆。


1、创建`/android/app/proguard-rules.pro`文件，并添加以下规则：
```
#Flutter Wrapper
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }
```
> 上述配置只混淆了 Flutter 引擎库，任何其他库（比如 Firebase）需要添加与之对应的规则。


2、开启混淆/压缩
- 打开 `/android/app/build.gradle` 文件，定位到 `buildTypes` 块。
- 在 `release`  配置中将 `minifyEnabled`  和 `useProguard`  设为 `true`，再将混淆文件指向上一步创建的文件。如下：


```
android {
    ...
    buildTypes {
        release {
            signingConfig signingConfigs.release
            minifyEnabled true
            useProguard true
            proguardFiles getDefaultProguardFile('proguard-android.txt'), 'proguard-rules.pro'
        }
    }
}


```


### 构建发行版（release）APK


1、在终端中进入项目中的Android文件夹


2、运行`flutter build apk` (`flutter build` 默认会包含 `--release选项`)


3、打包好的发布APK位于`<app dir>/build/app/outputs/apk/app-release.apk`