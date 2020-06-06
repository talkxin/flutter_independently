## 自建 dart/flutter 私人仓库

参考[kahnsen](https://kahnsen.github.io/kahnblog/2018/12/28/Dart%E4%BE%9D%E8%B5%96%E5%92%8C%E6%90%AD%E5%BB%BAFlutter-or-Dart%E7%AE%80%E6%98%93%E7%A7%81%E4%BA%BA%E4%BB%93%E5%BA%93/)的博客重新编辑。

在 pubspec.yaml 配置文件中可以得知，我们可以设置相应的仓库来进行第三方插件的获取，如果一些开发的第三方库不想放到开源仓库，可以参照下面说明来搭建私人仓库。

dart 官方给出了仓库的源码实例，该仓库也是由 dart 开发而成，git 地址为[https://github.com/kahnsen/pub_server](https://github.com/kahnsen/pub_server)

### 搭建步骤如下：

1. 克隆项目
   ```
    git clone https://github.com/kahnsen/pub_server.git
   ```
2. 进入项目文件夹
   ```
   cd pub_server
   ```
3. 执行`pub get`获取该项目第三方依赖插件
   > 如果没有 pub 命令，则当前系统没有安装 dart SDK，需要先安装 dart 开发环境

4) 成功后调用如下命令，来运行仓库实例，`/tmp/package-db`是参数，可以根据实际情况进行变更，后续上传的包均上传至该目录。
   ```
   dart example/example.dart -d /tmp/package-db
   ```
5) 设置端口，仓库实例的默认位置是`127.0.0.1:8080`端口，若需要变更端口号，可以在项目的`example/example.dart`文件中进行修改，修改后重启实例即可。
6) 仓库运行成功后，即可以在`pubspec.yaml`中修改`publish_to`标签来实现上传，示例如下：
   ```
    publish_to: http://127.0.0.1:8080
   ```
7) 测试上传，在需要航船的 flutter 项目的根目录执行`pub publish --dry-run`命令来验证仓库是否可用，该命令只会对仓库进行验证，并不会实际进行上传。
8) 验证通过后，执行`pub publish`即可完成上传操作。
9) 验证`pub get`，在`pubspec.yaml`中通过以下配置，即可将插件的获取源修改成私人仓库 ，再次执行项目即可验证仓库可用性。

```
dependencies:
  <your packages>:
    hosted:
      name: <your packages>
      url: http://127.0.0.1:8080
```
