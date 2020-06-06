## State 生命周期

理解 State 的生命周期对 Flutter 开发非常重要，此处通过一个实例来说明一下 State 的舍命周期。

**我们实现一个计数器 Widget**，点击使计数器加 1，由于要保存计数器的数值状态，所以我们应继承 StatefulWidget：

```dart
class CounterWidget extends StatefulWidget {
  const CounterWidget({
    Key key,
    this.initValue: 0
  });

  final int initValue;

  @override
  _CounterWidgetState createState() => new _CounterWidgetState();
}
```

`CounterWidget`接收一个`initValue`整型参数，它表示计数器的初始值。下面我们看一下 State 的部分：

```dart
class _CounterWidgetState extends State<CounterWidget> {
  int _counter;

  @override
  void initState() {
    super.initState();
    //初始化状态
    _counter=widget.initValue;
    print("initState");
  }

  @override
  Widget build(BuildContext context) {
    print("build");
    return Scaffold(
      body: Center(
        child: FlatButton(
          child: Text('$_counter'),
          //点击后计数器自增
          onPressed:()=>setState(()=> ++_counter,
          ),
        ),
      ),
    );
  }

  @override
  void didUpdateWidget(CounterWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("didUpdateWidget");
  }

  @override
  void deactivate() {
    super.deactivate();
    print("deactive");
  }

  @override
  void dispose() {
    super.dispose();
    print("dispose");
  }

  @override
  void reassemble() {
    super.reassemble();
    print("reassemble");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("didChangeDependencies");
  }

}
```

接下来，我们创建一个新路由，在新路由中，我们只显示一个`CounterWidget`：

```dart
Widget build(BuildContext context) {
  return CounterWidget();
}
```

我们运行应用并打开该路由页面，在新路由页打开后，屏幕中央就会出现一个数字 0，然后控制台日志输出：

```shell
I/flutter ( 5436): initState
I/flutter ( 5436): didChangeDependencies
I/flutter ( 5436): build
```

可以看到，在 StatefulWidget 插入到 Widget 树时首先`initState`方法会被调用。

然后我们点击 ⚡️ 按钮热重载，控制台输出日志如下：

```shell
I/flutter ( 5436): reassemble
I/flutter ( 5436): didUpdateWidget
I/flutter ( 5436): build
```

可以看到此时`initState`和`didChangeDependencies`都没有被调用，而此时`didUpdateWidget`被调用。

接下来，我们在 widget 树中移除`CounterWidget`，将路由`build`方法改为：

```dart
Widget build(BuildContext context) {
  //移除计数器
  //return CounterWidget();
  //随便返回一个Text()
  return Text("xxx");
}
```

然后热重载，日志如下：

```shell
I/flutter ( 5436): reassemble
I/flutter ( 5436): deactive
I/flutter ( 5436): dispose
```

我们可以看到，在`CounterWidget`从`widget`树中移除时，`deactive`和`dispose`会依次被调用。

下面我们来看看各个回调函数：

- `initState`：当 Widget 第一次插入到 Widget 树时会被调用，对于每一个 State 对象，Flutter framework 只会调用一次该回调，所以，通常在该回调中做一些一次性的操作，如状态初始化、订阅子树的事件通知等。不能在该回调中调用`BuildContext.inheritFromWidgetOfExactType`（该方法用于在 Widget 树上获取离当前 widget 最近的一个父级`InheritFromWidget`，关于`InheritedWidget`我们将在后面章节介绍），原因是在初始化完成后，Widget 树中的 InheritFromWidget 也可能会发生变化，所以正确的做法应该在`build()`方法或`didChangeDependencies()`中调用它。

- `didChangeDependencies()`：当 State 对象的依赖发生变化时会被调用；例如：在之前`build()` 中包含了一个`InheritedWidget`，然后在之后的`build()` 中`InheritedWidget`发生了变化，那么此时`InheritedWidget`的子`widget`的`didChangeDependencies()`回调都会被调用。典型的场景是当系统语言 Locale 或应用主题改变时，Flutter framework 会通知 widget 调用此回调。

- `build()`：此回调读者现在应该已经相当熟悉了，它主要是用于构建 Widget 子树的，会在如下场景被调用：

1. 在调用`initState()`之后。
2. 在调用`didUpdateWidget()`之后。
3. 在调用`setState()`之后。
4. 在调用`didChangeDependencies()`之后。
5. 在 State 对象从树中一个位置移除后（会调用 deactivate）又重新插入到树的其它位置之后。

- `reassemble()`：此回调是专门为了开发调试而提供的，在热重载(hot reload)时会被调用，此回调在 Release 模式下永远不会被调用。

- `didUpdateWidget()`：在 widget 重新构建时，Flutter framework 会调用`Widget.canUpdate`来检测 Widget 树中同一位置的新旧节点，然后决定是否需要更新，如果`Widget.canUpdate`返回 true 则会调用此回调。正如之前所述，`Widget.canUpdate`会在新旧 widget 的 key 和 runtimeType 同时相等时会返回 true，也就是说在在新旧 widget 的 key 和 runtimeType 同时相等时`didUpdateWidget()`就会被调用。

- `deactivate()`：当 State 对象从树中被移除时，会调用此回调。在一些场景下，Flutter framework 会将 State 对象重新插到树中，如包含此 State 对象的子树在树的一个位置移动到另一个位置时（可以通过 GlobalKey 来实现）。如果移除后没有重新插入到树中则紧接着会调用 dispose()方法。

- `dispose()`：当 State 对象从树中被永久移除时调用；通常在此回调中释放资源。

```UML
@startuml
:StatefulWidget
launched;
:initState;
:didChangeDependencies;
if (hot reload?) then (yes)
    :reassemble;
    :didUpdateWidget;
else(no)
    :didUpdateWidget;
endif
:build;
:deactivate;
:dispose;
:StatefulWidget
destroyed;
@enduml
```
