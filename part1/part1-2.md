## 在mac环境下搭建flutter开发环境


### sdk依赖


flutter会同时构建Android和iOS两个平台发布包，会依赖 Android sdk与iOS sdk。


### 设置镜像


在国内访问flutter会收到限制，flutter官方提供了临时镜像，可以将如下参数加入环境变量：



```
export PUB_HOSTED_URL=https://pub.flutter-io.cn
export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
```


如果该镜像被封可以参考[flutter官网文档](https://flutter.dev/community/china)进行变更。


### 获取flutter sdk
1. 去[flutter官网](https://flutter.io/sdk-archive/#macos)下载最新的安装包。


2. flutter版本会持续更新，一切以官方版本为准。


3. 解压压缩包并添加环境变量



export PATH=`pwd`/flutter/bin:$PATH



4. 查看flutter状态：



flutter doctor


flutter sdk中已经包含了dart sdk可以不用单独安装dart。


### flutter sdk分支
flutter sdk官方版本有多个分支，其中stable分支为稳定版本分支，dev，master分支为开发分支，可以通过`flutter channel`命令来查看所有分支，并会以*号表明当前分支；如果需要切换分支，可以使用`fluter channel xxx`的命令来切换对应分支，但官方建议一般开发者使用stable分支保证项目的稳定性。
    
### flutter sdk升级与依赖包
升级sdk一般分成两种状态：


1. 命令行升级：


```
#在命令行中执行如下命令，可直接连接官网或镜像升级对应分支版本
flutter upgrade
```


2. 绑定ide升级：


    IDE绑定flutter插件，如VS code，会在启动时检查flutter版本与依赖包，并提示用户进行升级，执行后会同步升级版本及所有依赖包。
    
升级依赖包：
      如果只想更新项目依赖包，可以在项目所在路径执行如下命令：
      
```
#获取项目的所有依赖包
flutter packages get
#获取项目所有依赖包的最新版本
flutter packages upgrade
```

### 替换flutter SDK分支

在安装Flutter后，可以查看SDK的依赖分支，如果投产时版本要求需要SDK的稳定版本，可以通过以下方式进行查看：
```
$ flutter channel
Flutter channels:
  master
  dev
* beta
  stable
```
运行`flutter channel stable`可以切换至稳定版，此时再运行`flutter upgrade`即可进行更新。

>flutter升级时可能会报如下错误：<br/>
>Your flutter checkout has local changes that would be erased by upgrading. If you want to keep these changes, it is recommended that you stash them via “git stash” or else commit the changes to a local branch. If it is okay to remove local changes, then re-run this command with --force.
exit code 1<br/>
>可以查看版本是否是beta版本，若是测试版，需要切换至dev或stable即可解决该问题。
