## Dart 单元测试


来源于：[亿百教程](https://www.yiibai.com/dart/dart_programming_unit_testing.html)，重新编译


#### 1、安装dart test单元测试用例库：


- 在`pubspec.yaml`中的`dependencies`节点下添加`test:`，依赖最新的单元测试库
- 当保存时，IDE会自动运行`flutter pub get`命令来进行安装依赖，当然也可以在项目目录直接执行该命令。
  
> 若是`Dart`项目，则在项目下执行`pub get`命令来进行安装依赖


#### 2、在测试单元导入相关依赖：


- 在单元测试用例文件中，导入相关依赖：

```dart
    import "package:test/test.dart";
```


#### 3、编写测试用例：


dart单元测试主要集中使用三个函数来进行：


- `test()`顶级函数：用于指定测试。语法如下：<br/>
  
```dart
test("Description of the test ", () { 
});
```


- `expect()`断言测试函数：用户测试程序断言，参数值等。语法如下：<br/>
  
```dart
test("Description of the test ", () {  
   expect(actualValue , matchingValue);
});
```

- `group()`分组测试函数：可用于对测试进行分组，每个组的描述都会添加到测试描述的开头。使用该函数可以对测试用例进行分组，以便为测试代码添加更多含义。如果有许多测试用例，这有助于编写更清晰的代码。语法如下：<br/>

```dart
group("some_Group_Name", () { 
   test("test_name_1", () { 
      expect(actual, equals(exptected)); 
   });  
   test("test_name_2", () { 
      expect(actual, equals(expected)); 
   }); 
});
```
  
### 示例一：传递测试


以下示例定义方法`Add()`，此方法采用两个整数值并返回表示总和的整数。演示使用`expect()`来强制执行断言测试。


```dart
import 'package:test/test.dart';      
// Import the test package 


int Add(int x,int y)                  
// Function to be tested { 
   return x+y; 
}  
void main() { 
   // Define the test 
   test("test to check add method",(){  
      // Arrange 
      var expected = 30; 


      // Act 
      var actual = Add(10,20); 


      // Asset 
      expect(actual,expected); 
   }); 
}
```


执行得到结果如下：

```
00:00 +0: test to check add method 
00:00 +1: All tests passed!
```


### 示例2:失败测试


下面定义的`subtract()`方法存在逻辑错误，下面将测试验证。


```dart
import 'package:test/test.dart'; 
int Add(int x,int y){ 
   return x+y; 
}
int Sub(int x,int y){ 
   return x-y-1; 
}  
void main(){ 
   test('test to check sub',(){ 
      var expected = 10;   
      // Arrange 


      var actual = Sub(30,20);  
      // Act 


      expect(actual,expected);  
      // Assert 
   }); 
   test("test to check add method",(){ 
      var expected = 30;   
      // Arrange 


      var actual = Add(10,20);  
      // Act 


      expect(actual,expected);  
      // Asset 
   }); 
}
```

输出结果，函数`add()`的测试用例通过，但`subtract()`的测试失败，如下所示。

```
00:00 +0: test to check sub 
00:00 +0 -1: test to check sub 
Expected: <10> 
Actual: <9> 
package:test  expect 
bin\Test123.dart 18:5  main.<fn> 


00:00 +0 -1: test to check add method 
00:00 +1 -1: Some tests failed.  
Unhandled exception: 
Dummy exception to set exit code. 
#0  _rootHandleUncaughtError.<anonymous closure> (dart:async/zone.dart:938) 
#1  _microtaskLoop (dart:async/schedule_microtask.dart:41)
#2  _startMicrotaskLoop (dart:async/schedule_microtask.dart:50) 
#3  _Timer._runTimers (dart:isolate-patch/timer_impl.dart:394) 
#4  _Timer._handleMessage (dart:isolate-patch/timer_impl.dart:414) 
#5  _RawReceivePortImpl._handleMessage (dart:isolate-patch/isolate_patch.dart:148)
```


### 示例3：分组测试

为`split()`函数和`trim()`函数编写测试用例。因此在逻辑上将这些测试用例分组并为字符串。

```dart
import "package:test/test.dart"; 
void main() { 
   group("String", () { 
      test("test on split() method of string class", () { 
         var string = "foo,bar,baz"; 
         expect(string.split(","), equals(["foo", "bar", "baz"])); 
      }); 
      test("test on trim() method of string class", () { 
         var string = "  foo "; 
         expect(string.trim(), equals("foo")); 
      }); 
   }); 
}
```

输出结果如下：

```
00:00 +0: String test on split() method of string class 
00:00 +1: String test on trim() method of string class 
00:00 +2: All tests passed
```

## flutter项目调试


#### Dart语言检查
- 在运行项目之前IDE工具会调用`flutter analyze`命令来检查项目中的语法检查，它是dart工具`dartanalyzer`的包装，以避免无类型参数，无类型的列表文字等编译错误。一般使用IDE执行编译启动的话，会自动执行该工具检查语法错误。


#### 断点调试


- 我们可以在vs code上进行断点调试，在进行debug时会自动运行到断点处停止。
- 我们也可以通过Observatory工具的web页面进行远程调试，Observatory默认监听`http://127.0.0.1:8100/`，我们可以通过工具将其映射至局域网进行调试。


### debugger（）声明


- 当使用Dart Observatory(或另一个Dart调试器，例如IntelliJ IDE中的调试器)时，可以使用该 debug ger() 语句插入编程式断点。要使用这个，你必须添加 import 'dart:developer'; 到相关文件顶部。
debugger() 语句采用一个可选 when 参数，您可以指定该参数仅在特定条件为真时中断，如下所示:


```
    void someFunction(double offset) { debugger(when: offset > 30.0); // ...
}
```


### print 、 debugPrint 、 flutter logs


- Dart print() 功能将输出到系统控制台，您可以使用 flutter logs 来查看它(基本上是一个包装
adb logcat )。
- 如果你一次输出太多，那么Android有时会丢弃一些日志行。为了避免这种情况，您可以使用Flutter的 foundation 库中的 debugPrint() 。 这是一个封装print，它将输出限制在一个级别，避免被Android
内核丢弃。
- Flutter框架中的许多类都有 toString 实现。按照惯例，这些输出通常包括对象的 runtimeType 单行 输出，通常在表单中ClassName(more information about this instance...)。 树中使用的一些类也具有
toStringDeep ，从该点返回整个子树的多行描述。已一些具有详细信息 toString 的类会实现一个 t oStringShort ，它只返回对象的类型或其他非常简短的(一个或两个单词)描述。


#### debugDumpApp()


##### Widget树
- 要转储Widgets树的状态，请调用 debugDumpApp() 。 只要应用程序已经构建了至少一次(即在调用 b uild() 之后的任何时间)，您可以在应用程序未处于构建阶段(即，不在 build() 方法内调用 )的 任何时间调用此方法(在调用 runApp() 之后)。


例如：


```
import 'package:flutter/material.dart';
void main() {
  runApp(
    new MaterialApp(
      home: new AppHome(),
), );
}
class AppHome extends StatelessWidget { @override
Widget build(BuildContext context) {
    return new Material(
      child: new Center(
        child: new FlatButton(
          onPressed: () {
            debugDumpApp();
          },
          child: new Text('Dump App'),
        ),
), );
} }
```
- 这是一个“扁平化”的树，显示了通过各种构建函数投影的所有widget(如果你在widget树的根中调用 toStringDeepwidget ，这是你获得的树)。 你会看到很多在你的应用源代码中没有出现的widget，
因为它们是被框架中widget的 build() 函数插入的。例如， InkFeature 是Material widget的一个实 现细节 。
- 当按钮从被按下变为被释放时debugDumpApp()被调用，FlatButton对象同时调用 setState() ，并将 自己标记为"dirty"。 这就是为什么如果你看转储，你会看到特定的对象标记为“dirty”。您还可以查看已 注册了哪些手势监听器; 在这种情况下，一个单一的GestureDetector被列出，并且监听“tap”手势 (“tap”是 TapGestureDetector 的 toStringShort 函数输出的)
- 如果您编写自己的widget，则可以通过覆盖 debugFillProperties() 来添加信息。 将DiagnosticsPro perty对象作为方法参数，并调用父类方法。 该函数是该 toString 方法用来填充小部件描述信息的。



#### debugDumpRenderTree()


##### 渲染树


- 如果您尝试调试布局问题，那么Widget树可能不够详细。在这种情况下，您可以通过调用 debugDumpR enderTree() 转储渲染树。 正如 debugDumpApp() ，除布局或绘制阶段外，您可以随时调用此函数。 作为一般规则，从frame 回调 或事件处理器中调用它是最佳解决方案。
- 要调用 debugDumpRenderTree() ，您需要添加 import'package:flutter/rendering.dart'; 到您的 源文件。
- 当调试布局问题时，关键要看的是 size 和 constraints 字段。约束沿着树向下传递，尺寸向上传
递。
- 如果您编写自己的渲染对象，则可以通过覆盖 debugFillProperties() 将信息添加到转储。 将Diagn osticsProperty对象作为方法的参数，并调用父类方法。


#### debugDumpLayerTree() 


##### Layer树
- 渲染树是可以分层的，而最终绘制需要将不同的层合成起来，而Layer则是绘制时需要 合成的层，如果您尝试调试合成问题，则可以使用 debugDumpLayerTree()
- 根部的变换是应用设备像素比的变换; 在这种情况下，每个逻辑像素代表3.5个设备像素。
- RepaintBoundary widget在渲染树的层中创建了一个RenderRepaintBoundary 。这用于减少需要重 绘的需求量。


#### debugDumpSemanticsTree()


##### 语义树
- 可以调用 debugDumpSemanticsTree() 获取语义树(呈现给系统可访问性API的树)的转储。 要使 用此功能，必须首先启用辅助功能，例如启用系统辅助工具或 SemanticsDebugger 


#### debugPrintBeginFrameBanner debugPrintEndFrameBanner


##### 调度树
- 要找出相对于帧的开始/结束事件发生的位置，可以切换debugPrintBeginFrameBanner 和 debugPrin tEndFrameBanner 布尔值以将帧的开始和结束打印到控制台。
- debugPrintScheduleFrameStacks 还可以用来打印导致当前帧被调度的调用堆栈。

## Flutter性能调试问题



#### 渲染性能统计
- 要了解您的应用程序导致重新布局或重新绘制的原因，您可以分别设置 debugPrintMarkNeedsLayoutS tacks 和 debugPrintMarkNeedsPaintStacks 标志。 每当渲染盒被要求重新布局和重新绘制时，这些 都会将堆栈跟踪记录到控制台。如果这种方法对您有用，您可以使用 services 库中的 debugPrintSt ack() 方法按需打印堆栈痕迹。


#### 统计应用启动时间
- 要收集有关Flutter应用程序启动所需时间的详细信息，可以在运行 flutter run 时使用 trace- startup 和 profile 选项。


```
$ flutter run --trace-startup --profile
```
- 跟踪输出保存为 `start_up_info.json` ，在Flutter工程目录在build目录下。输出列出了从应用程序启动到这些跟踪事件(以微秒捕获)所用的时间:
> 进入Flutter引擎时.
> 展示应用第一帧时.
> 初始化Flutter框架时.
> 完成Flutter框架初始化时.


如：
```
    {
        "engineEnterTimestampMicros":96025565262, 
        "timeToFirstFrameMicros": 2171978,
        "timeToFrameworkInitMicros":514585, 
        "timeAfterFrameworkInitMicros": 1657393
}


```


#### 跟踪代码性能


- 要执行自定义性能跟踪和测量Dart任意代码段的wall/CPU时间(类似于在Android上使用systrace)。
使用 dart:developer 的Timeline工具来包含你想测试的代码块，例如:


```
Timeline.startSync('interesting function'); 
// iWonderHowLongThisTakes(); 
Timeline.finishSync();
```


然后打开你应用程序的Observatory timeline页面，在“Recorded Streams”中选择‘Dart’复选框，并执 行你想测量的功能。


刷新页面将在Chrome的跟踪工具中显示应用按时间顺序排列的timeline记录。


请确保运行 flutter run 时带有 --profile 标志，以确保运行时性能特征与您的最终产品差异最小。

## flutter日志收集


### print 、 debugPrint 、 flutter logs


- Dart print() 功能将输出到系统控制台，您可以使用 flutter logs 来查看它(基本上是一个包装
adb logcat )。
- 如果你一次输出太多，那么Android有时会丢弃一些日志行。为了避免这种情况，您可以使用Flutter的 foundation 库中的 debugPrint() 。 这是一个封装print，它将输出限制在一个级别，避免被Android
内核丢弃。
- Flutter框架中的许多类都有 toString 实现。按照惯例，这些输出通常包括对象的 runtimeType 单行 输出，通常在表单中ClassName(more information about this instance...)。 树中使用的一些类也具有
toStringDeep ，从该点返回整个子树的多行描述。已一些具有详细信息 toString 的类会实现一个 t oStringShort ，它只返回对象的类型或其他非常简短的(一个或两个单词)描述。