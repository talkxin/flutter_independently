## 发布 IOS 版 APP

### 在 iTunes Connect 上创建应用程序记录

1、打开[iTunes Connect](https://itunesconnect.apple.com/)

2、登陆 iTunes Connect 并进入`My Apps`页面

3、点击左上角+号，选择 New App。

4、填写应用详细信息，在 Platforms 部分中，确保已选中 iOS。由于 Flutter 目前不支持 tvOS，请不要选中该复选框。点击 Create。

5、导航到您 app 的应用程序详细信息，App Information 。

6、在 General Information 部分, 选择您在上一步中注册的软件包 ID。

### 查看 Xcode 项目设置

1、  在项目工程目录，执行`open ios/Runner.xcworkspace`打开 Xcode。

2、在左侧项目导航器中选择 Runner 项目并在弹出的界面中，选择 General 选项卡:

#### Identity 部分：

- `Display Name`:要在主屏幕和其他地方显示的应用程序的名称
- `Bundle Identifier`:您在 iTunes Connect 上注册的 App ID.

#### Signing 部分:

- `Automatically manage signing`:Xcode 是否应该自动管理应用程序签名和生成。默认设置为 true，对大多数应用程序来说应该足够了。
- `Team`:选择与您注册的 Apple Developer 帐户关联的团队。如果需要，请选择 Add Account…，然后更新此设置

#### Deployment Info 部分:

- `Deployment Target`:您的应用将支持的最低 iOS 版本。Flutter 支持 iOS 8.0 及更高版本。如果您的应用程序包含使用 iOS 8 中不可用的 API 的 Objective-C 或 Swift 代码，请适当更新此设置。

### 添加应用图标

1、在左侧项目导航器中选择 Runner 文件夹进入，并选择`Assets.xcassets`，使用您自己的应用程序图标更换占位图标

2、运行`flutter run`，验证应用图标是否已经被替换。

### 创建构建档案

1、在项目根目录执行`flutter build ios`创建项目的 release 版本

> `flutter build` 默认为 `--release`

3、在 Xcode 中，配置应用程序版本并构建：

- 在项目工程目录，执行`open ios/Runner.xcworkspace`打开 Xcode。
- 选择`Product > Scheme > Runner`
- 选择`Product > Destination > Generic iOS Device`
- 在 Xcode 项目导航器中选择 Runner , 然后在设置视图边栏中选择选择 Runner target
- 在 Identity 部分中，将`Version`更新为您希望发布的面向用户的版本号
- 在 Identity 部分中，将`Build`标识更新为用于跟踪`iTunes Connect`上的此版本的唯一版本号。每次上传都需要一个唯一的`build`号

4、创建一个构建档案并将其上传到 iTunes Connect：

- 选择 `Product > Archive` 以生成构建档案
- 在`Xcode Organizer`窗口的边栏中，选择您的 iOS 应用程序，然后选择您刚刚生成的 build 档案
- 点击`Validate…`按钮. 如果报错，请解决它们并生成另一个 build。您可以重复使用相同的 build ID，直到您上传档案
- 案已成功验证后，单击`Upload to App Store…`，您可以在 iTunes Connect 的应用详情也的`Activities`选项卡中查看构建状态

5、您应该在 30 分钟内收到一封电子邮件，通知您您的构建已经过验证，并可以在 TestFlight 上发布给测试人员。此时，您可以选择是否在 TestFlight 上发布，或继续并将您的 release 版发布到 App Store。

### 在 TestFlight 上发布您的应用程序

> 可以通过 TestFlight，将程序推送给内部或者外部的测试人员。

1、在[iTunes Connect](https://itunesconnect.apple.com/)上导航到应用程序详细信息页面的 TestFlight 选项卡

2、在侧边栏选择 Internal Testing

3、选择要发布到测试人员的 build，然后单击 Save

4、加任何内部测试人员的电子邮件地址。您可以在 iTunes Connect 的用户和角色页面添加更多的内部用户，可从页面顶部的下拉菜单中获得。

### 将您的应用发布到 App Store

1、从 iTunes 应用程序的应用程序详情页的边栏中选择 Pricing and Availability，然后填写所需的信息。

2、从边栏选择状态。如果这是该应用的第一个版本，则其状态将为 1.0 Prepare for Submission。完成所有必填字段。

3、击 Submit for Review.

4、Apple 会在应用程序审查过程完成时通知您。您的应用将根据您在 Version Release 部分指定的说明进行发布。

> 有关更多详细信息，请参阅将[Submitting Your App to the Store](https://help.apple.com/xcode/mac/current/#/dev067853c94)
