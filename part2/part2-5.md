## pubspec.yaml 配置文件详解

> `pubspec.yaml`是 Flutter 项目的核心配置文件，类似于 Android 项目中的 build.gradle 配置文件.

#### 配置文件示例如下：

```shell
# 项目名称，必填字端
name: newtify


# 版本号，非必填
# 若需要将项目托管在pub.dev则该字段必填。
version: 1.2.3


# 项目描述，非必填
# 若需要将项目托管在pub.dev则该字段必填。
description: >-
  Have you been turned into a newt?  Would you like to be?
  This package can help. It has all of the
  newt-transmogrification functionality you have been looking
  for.


# 项目主页，非必填
# 该项目的介绍主页，填写域名
homepage: https://example-pet-store.com/newtify


# 开发文档位置，非必填
# 与`homepage`不同，若该项目还包含其他文档，可以将文档的地址添加到该节点下。如果项目托管在pub.dev，该节点显示项目的API信息。
documentation: https://example-pet-store.com/newtify/docs


# 项目的远程库，非必填
# 若该项目是lib或开源库，这个配置文件用于关联库的来源地址，最好填写有效的地址，否则会无法关联获取项目。
repository: https://github.com/<user>/<repository>


# 问题追踪页面，非必填
# 若该项目是一个开源且随时更新的项目，可以通过填写该属性，标明该项目的问题追踪文档站点，如果使用pub.dev来进行项目托管，则pub.dev将尝试通过该字段显示该项目的问题跟踪链接。若该项目托管在github，则可以将该字段填写为github的issues
issue_tracker: https://github.com/<user>/<repository>/issues


# 项目的第三方插件依赖，在这个标签中列出了该项目正常工作所需的每一个软件包与版本。以下通过实例详解该标签的详情
dependencies:
  # 实例1 直接写明约束版本，若该插件是发布在https://pub.dev/ 之上，IDE会直接在项目目录下执行`flutter packages get`来下载其插件的最新版本
  transmogrify:
  # 实例2 该插件是在实例1的基础上进行延伸，其中`^1.4.0`的含义是约束了版本号，也就是在该项目中，需要使用1.4.0版本
  transmogrify: ^1.4.0
  #实例3 若该插件未部署在pub.dev之上，则可以通过URL来指定出插件下载的源
  transmogrify:
    hosted:
      name: transmogrify
      url: http://some-package-server.com
  #实例4 基于实例3，其中version表明了使用该插件的版本信息
  transmogrify:
    hosted:
      name: transmogrify
      url: http://some-package-server.com
    version: ^1.4.0
  #实例5 若该插件是发布在git上，可以用以下方式来进行插件获取，默认获取master下代码
  transmogrify:
    git:
      url: git://github.com/munificent/kittens.git
  #实例6 基于实例5，其中ref标明获取的分支信息
  transmogrify:
    git:
      url: git://github.com/munificent/kittens.git
      ref: some-branch
  #实例7 基于实例5，若插件只是在项目中的某一个目录中，可以通过path来指定插件位置
  transmogrify:
    git:
      url: git://github.com/munificent/kittens.git
      path: path/to/kittens
  #实例8 若插件在本地某一目录，可以通过指定path来找到该插件
  transmogrify:
    path: /Users/me/transmogrify


  #指定版本，若该项目使用的插件需要约束版本，则方法如下
  #实例1 在该项目中，此插件指定版本为1.4.0
  transmogrify: ^1.4.0
  #实例2 在该项目中，此插件最低版本为1.2.3
  transmogrify: ">=1.2.3"
  #实例3 在该项目中，此插件最低支持2.0.0版本，但不支持3.0.0以上版本
  transmogrify: ">=2.0.0 <3.0.0"
  #实例4 在该项目中，此插件最高支持到1.2.3以下版本
  transmogrify: "<1.2.3"


  #指定Flutter SDK
  #实例1 项目必填项，指定SDK，并获取SDK最新版
  flutter:
    sdk: flutter
  #实例2 基于实例1，指定SDK版本号
  flutter:
    sdk: flutter
    version: ">=2.0.0-dev.68.0 <3.0.0"
  #实例3 另外一种写法
  flutter_driver:
    sdk: flutter
    version: ^0.0.1


# 区别于dependencies标签，dependencies是生产环境依赖库版本，dev_dependencies是开发环境依赖库版本，该环境仅在开发调试时使用。标签规则同dependencies。
dev_dependencies:
  transmogrify: ^1.4.0


# 重写依赖包，会强制下载对应依赖包，并可以对该依赖包进行重写。
dependency_overrides:
  transmogrify: ^1.4.0


# Dart2开始需要添加该标签，声明该项目是基于dart的SDK哪个版本进行编译，随着dart平台的发展，可能在某个版本后不再向下兼容，所以这个标签约束了使用dart的版本
# 例，以下约束说明此项目仅适用于2.0到3.0的dart2 SDK编译。
environment:
  sdk: '>=2.0.0 <3.0.0'


# 可以将Dart2的可执行脚本引入到flutter之中，作为插件使用，但前提是这些脚本均可以在命令行正常调用。
executables:
  <name-of-executable>: <Dart-script-from-bin>


# 指定生成发布包的位置
# 非必填
# 若不填写，则默认使用pub.dev站点进行发布，但若希望阻止发布，则需要声明为none。
# 同时此设置可以将flutter项目发布到自定义的服务器之中。
publish_to: none


#
# 项目中配置声明方式
# 用于在项目中添加资源、设置字体、配置插件参数等。
fluuter:
  # 实例1 添加资源
  assets:
      - images/park.jpg
  #设置字体，样式，可以通过声明family来设置字体分组
  fonts:
      - family: Schyler
        fonts:
          - asset: fonts/Schyler-Regular.ttf
          - asset: fonts/Schyler-Italic.ttf
            style: italic


      - family: Trajan Pro
        fonts:
      - asset: fonts/TrajanPro.ttf
      - asset: fonts/TrajanPro_Bold.ttf
        weight: 700


#
# 其他声明方式


# 实例1 定义常量
age: 22
boolitem: true
name: 'hello'


#实例2 定义数组
server:
    - aaaaaa
    - bbbbbb
    - dddddd
```
