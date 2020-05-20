## Flutter Hello World
- Flutter官方在github中提供了相应的demo示例集，可以在[Flutter源码地址](https://github.com/flutter/flutter.git)中下载该示例。


```
git clone https://github.com/flutter/flutter.git
```
- 使用vscode打开hello world示例文件夹路径`fluuter/examples/hello_world`
- 打开debug页签，选择添加`Dart/Flutter`配置，并开始构建。
- 构建之前，vscode会通过`flutter packages get`命令来获取该项目所需的相关包。

> 第一次打开该工程时，vscode会检查该工程是的package是否完全，可以点击获取，则vscode会调用`flutter packages get`来获取或更新项目所需相关包<br/>
> 如果出现`Waiting for another flutter command to release the startup lock...`错误，需要删除`$FLUTTER_HOME/bin/cache/lockfile`文件，释放flutter命令锁定<br/>
>如果在获取包时出现以下错误提示，请打开`pubspec.yaml`文件，调整`dependencies`下项目支持包的版本号，或替换掉已废弃的包。<br/>


```
[flutter_view] flutter packages get
Running "flutter pub get" in flutter_view...                    
Because flutter_view depends on flutter any from sdk which depends on meta 1.1.7, meta 1.1.7 is required.
So, because flutter_view depends on meta 1.1.8, version solving failed.


pub get failed (1; So, because flutter_view depends on meta 1.1.8, version solving failed.)
```


### 工程目录结构


打开项目时可以看到如下工程目录结构，结构如下：<br/>


```

├── README.md           --项目说明文件
├── android             --编译Android项目的源码工程路径
├── ios                 --编译IOS项目的源码工程路径
├── images              --图片资源路径
├── lib                 --Flutter源码工程路径
│   └── main.dart       --默认main入口
├── pubspec.lock        --根据当前项目依赖所生成的文件，记录了当前使用的库的依赖版本
└── pubspec.yaml        --Flutter项目的核心配置文件

```