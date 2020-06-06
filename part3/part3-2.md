## Widget 简介

#### 1、概念

在 Flutter 中，几乎所有的对象都是一个 Widget。与原生开发中的控件不同的是，Flutter 中的 widget 概念更为广泛，它不仅可以表示 UI 元素，也可以表示一些功能性的组建，如手势检测的`GestureDetector widget`，用于 App 主题数据传递的`Theme`等等，原生开发中的控件通常只是 UI 元素。
可以理解的是，在 Flutter 中 widget 可以代表某一个页面，也可以代表某一个组件，他是所有控件的总承载。

#### 2、widget 与 Element

在 Flutter 中，`Widget的功能是描述一个UI元素的配置数据`，他就是说，Wiget 其实并不是表示最终绘制在设备屏幕上的显示元素，它只是描述显示元素的一个配置数据。
实际上 Flutter 中真正代表屏幕上显示元素的类是`Element`，也就是说`Widget`只是描述 Element 的配置数据，并且一个 Widget 中可以对应若干个 element，也就是在真正渲染时，对应的每一个 Element 都会对应一个 widget。总结如下：

- Widget 实际上就是 Element 的配置数据，Widget 实际上是一个配置树，真正的 UI 渲染实际上是 Element 来构成，也就是类似于，一个 Activity 的一个 layout，layout 同时承载了不同的组件，而这些组件就好比是 Element，实际渲染也是由这些组件来进行；不过由于 Element 是通过 widget 生成的，所以他们之间有对应关系，在大多数场景，我们可以宽泛的认为 widget 树就是 ui 控件树或渲染树。
- 一个 widget 对象可以对应多个 Element 对象。就像 layout 可以同时承载多个组件一样。

#### Widget 主要接口

```dart
abstract class Widget extends DiagnosticableTree {
  const Widget({ this.key });


  final Key key;


  @protected
  Element createElement();


  @override
  String toStringShort() {
    return key == null ? '$runtimeType' : '$runtimeType-$key';
  }


  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.defaultDiagnosticsTreeStyle = DiagnosticsTreeStyle.dense;
  }


  static bool canUpdate(Widget oldWidget, Widget newWidget) {
    return oldWidget.runtimeType == newWidget.runtimeType
        && oldWidget.key == newWidget.key;
  }
}
```

- `Widget`继承自`DiagnosticableTree`，`DiagnosticableTree`即诊断树，主要作用是提供调试信息。
- Key：该属性类似于 React/Vue 中的 key，主要的作用是决定是否在下一次 build 时复用旧的 widget，决定的条件在`canUpdate()`方法中。
- createElement()：在 Flutter Framework 在构建 UI 树时，会调用该方法生成对应节点的 Element 对象，此方法是 Flutter Framework 隐式调用的，在开发过程中基本上不会主动调用该方法。
- debugFillProperties():重写父类的方法，主要设置诊断树的一些特性。
- canUpdate():是一个静态方法，它主要的作用是在于 Widget 树重新 build 时复用旧的 widget，具体来说，应该是，当 newWidget 与 oldWidget 的 runtimeType 和 key 相等时，会复用旧的 element 对象，否则就会重新 build 新的 Element 的对象。

widget 类本身是一个抽象类，其中最核心的就是定义了`createElement()`接口，在 Flutter 开发中，我们一般不用直接继承`widget`类来实现一个新组件，相反，我们通常会通过继承`StatelessWidget`或`StatefulWidget`来间接继承 Widget 类来实现。`StatelessWidget`和`StatefulWidget`都是直接继承自 Widget 类，而这两个类也正是 Flutter 中非常重要的两个抽象类，它们引入了两种 Widget 模型。

### SeatelessWidget

`SeatelessWidget`继承自`Widget`类，重写了`createElement()`方法， `StatelessElement`间接继承自`Element`类，与`StatelessWidget`相对应。

`StatelessWidget`用于不需要维护状态的场景，它通常在 build 方法中通过嵌套其它 Widget 来构建 UI，在构建过程中会递归的构建其嵌套的 Widget。

实例如下：

```dart
class Echo extends StatelessWidget {
  const Echo({
    Key key,
    @required this.text,
    this.backgroundColor:Colors.grey,
  }):super(key:key);


  final String text;
  final Color backgroundColor;


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: backgroundColor,
        child: Text(text),
      ),
    );
  }
}
```

> 按照惯例，widget 的构造函数参数应使用命名参数，命名参数中的必要参数要添加@required 标注，这样有利于静态代码分析器进行检查。另外，在继承 widget 时，第一个参数通常应该是 Key，另外，如果 Widget 需要接收子 Widget，那么 child 或 children 参数通常应被放在参数列表的最后。同样是按照惯例，Widget 的属性应尽可能的被声明为 final，防止被意外改变。

### StatefulWidget

和`StatelessWidget`一样，`StatefulWidget`也是继承自 Widget 类，并重写了`createElement()`方法，不同的是返回的 Element 对象并不相同；另外`StatefulWidget`类中添加了一个新的接口`createState()`。

- `StatefulElement` 间接继承自 Element 类，与`StatefulWidget`相对应（作为其配置数据）。`StatefulElement`中可能会多次调用`createState()`来创建状态(State)对象。

- `createState()` 用于创建和 Stateful widget 相关的状态，它在 Stateful widget 的生命周期中可能会被多次调用。例如，当一个`Stateful widget`同时插入到 widget 树的多个位置时，Flutter framework 就会调用该方法为每一个位置生成一个独立的 State 实例，其实，本质上就是一个`StatefulElement`对应一个 State 实例。

### Context

`build`方法有一个`context`参数，它是`BuildContext`类的一个实例，表示当前`widget`在`widget`树中的上下文，每一个`widget`都会对应一个`context`对象（因为每一个`widget`都是`widget`树上的一个节点）。实际上，`context`是当前`widget`在`widget`树中位置中执行”相关操作“的一个句柄，比如它提供了从当前 widget 开始向上遍历`widget`树以及按照`widget`类型查找父级`widget`的方法。

### State

一个`StatefulWidget`类会对应一个`State`类，`State`表示与其对应的`StatefulWidget`要维护的状态，`State`中的保存的状态信息可以：

在`widget` 构建时可以被同步读取。
在`widget`生命周期中可以被改变，当`State`被改变时，可以手动调用其`setState()`方法通知 Flutter framework 状态发生改变，Flutter framework 在收到消息后，会重新调用其 build 方法重新构建 widget 树，从而达到更新 UI 的目的。
State 中有两个常用属性：

1. `widget`，它表示与该 State 实例关联的 widget 实例，由 Flutter framework 动态设置。注意，这种关联并非永久的，因为在应用生命周期中，UI 树上的某一个节点的 widget 实例在重新构建时可能会变化，但 State 实例只会在第一次插入到树中时被创建，当在重新构建时，如果 widget 被修改了，Flutter framework 会动态设置 State.widget 为新的 widget 实例。

2. `context`，StatefulWidget 对应的 BuildContext，作用同 StatelessWidget 的 BuildContext。
