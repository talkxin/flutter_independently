## Container(容器组件)

### 简介
Container组件是Flutter中最常用的布局组件之一，在我们每个Widget中会返回一个默认布局组件，该组件就是Container容器组件，我们可以在该组件中描述该容器的大小，背景颜色，边框等：

```dart
class MyTest extends StatefulWidget {
  @override
  _MyTestState createState() => _MyTestState();
}

class _MyTestState extends State<MyTest> {
  @override
  Widget build(BuildContext context) {
    ///每个widget都会默认承载一个容器
    return Container(
      
    );
  }
}
```

### 构造函数

我们先看一下容器组件的构造函数
```dart
  Container({
    Key? key,
    this.alignment,//布局排列
    this.padding,//容器内补白
    this.color,//背景色
    this.decoration,//背景装饰
    this.foregroundDecoration,//前景装饰
    double? width,//容器宽度
    double? height,//容器高度
    BoxConstraints? constraints,//容器大小的限制条件
    this.margin,//容器外补白
    this.transform,//变换
    this.transformAlignment,
    this.child,//内容
    this.clipBehavior = Clip.none,
  });
```
#### 容器的大小

- 容器大小可以通过`width`,`height`属性来设置。
- 也可以通过`constraints`来限制容器的宽高。
- 如果同时设置了三个属性，则容器会以`width`,`height`属性优先。实际上不设置`constraints`容器内部也会根据宽高属性，自行生成一个默认的值。

```dart
// 容器的大小将被限制在[100*100 ~ 200*200]内
BoxConstraints(
  minWidth: 100,
  maxWidth: 200,
  minHeight: 100,
  maxHeight: 200,
)
```

#### 容器的颜色

在容器中可以通过设置`color`属性来控制容器的背景颜色，此处需要注意，该属性不能与`decoration`属性同时设置。
