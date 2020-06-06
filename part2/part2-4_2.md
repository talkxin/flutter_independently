## 发布 Android 版 APP

### 检查 App Mainfest

1、查看默认 Gradle 构建文件`build.gradle`，它位于`<app dir>/android/app/`，验证这些值是否正确，尤其是：

- defaultConfig:
  - applicationId: 指定始终唯一的 (Application Id)appid
  - versionCode & versionName: 指定应用程序版本号和版本号字符串。
  - minSdkVersion & targetSdkVersion: 指定最低的 API 级别以及应用程序设计运行的 API 级别。

2、添加启动图标:

- 在`<app dir>/android/app/src/main/res/`目录中，将图标文件放入使用[配置限定符](https://developer.android.com/guide/practices/screens_support.html#qualifiers)命名的文件夹中。默认 mipmap-文件夹演示正确的命名约定。
- 在`AndroidManifest.xml`中，将`application`标记的`android:icon`属性更新为引用上一步中的图标。
- 运行`flutter run`，验证应用图标是否已经被替换。

### APP 签名

1、创建 keystore：

在命令行中输入一下命令可以创建一个 key：

```
keytool -genkey -v -keystore ~/key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias key
```

> 注意：保持文件私密; 不要将它加入到公共源代码控制中</br>
> 注意: keytool 可能不在你的系统路径中。它是 Java JDK 的一部分，它是作为 Android Studio 的一部分安装的。有关具体路径，请百度。

2、引用应用程序中的 keystore

创建一个名为`<app dir>/android/key.properties`的文件，其中包含对密钥库的引用:

```
storePassword=<password from previous step>
keyPassword=<password from previous step>
keyAlias=key
storeFile=<location of the key store file, e.g. /Users/<user name>/key.jks>
```

> 注意：保持文件私密; 不要将它加入到公共源代码控制中</br>

3、在 gradle 中配置签名

可以通过编辑`<app dir>/android/app/build.gradle`文件为您的应用配置签名，示例如下：

- 新增 key 引用：

```
def keystorePropertiesFile = rootProject.file("key.properties")
def keystoreProperties = new Properties()
keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
```

- 关闭 debug 模式

```
buildTypes {
    release {
        // 目前状态为debug模式，替换该配置
        signingConfig signingConfigs.debug
    }
}
```

- 增加 key 引用

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
- 在 `release` 配置中将 `minifyEnabled` 和 `useProguard` 设为 `true`，再将混淆文件指向上一步创建的文件。如下：

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

1、在终端中进入项目中的 Android 文件夹

2、运行`flutter build apk` (`flutter build` 默认会包含 `--release选项`)

3、打包好的发布 APK 位于`<app dir>/build/app/outputs/apk/app-release.apk`
