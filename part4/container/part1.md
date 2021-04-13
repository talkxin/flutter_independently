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
#### width/height属性

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

#### color属性

- 在容器中可以通过设置`color`属性来控制容器的背景颜色，此处需要注意，该属性不能与`decoration`属性同时设置。
- 与设置容器大小同理，在设置容器颜色时，如果只设置`color`则会在容器内部默认创建一个`decoration`。
- 使用`color`来指定容器的背景色时需要注意的是，不能直接通过色号来指定颜色，譬如`#FF0000`代表红色，在Flutter中，可以使用`Color(0xFF0000)`或者使用默认颜色`Colors.red`来标识颜色，否则会报错。

#### 背景色装饰器（decoration）

`decoration`除了可以设置背景颜色以外，还有其他强大的功能，我们可以通过该属性设置容器的边框、阴影、渐变、圆角等常用属性。我们可以通过`BoxDecoration`来实例化该属性并进行设置。

##### 设置边框
我们可以使用官方提供的`Border.all`构造函数直接生成4条边框，也可以使用`Border`构造函数单独设置不同方向上的边框。
```dart
/// 设置4条粗细为1px的黑色实线边框
BoxBorder(
  border:Border.all(
    color: Colors.black,
    width: 1,
    style: BorderStyle.solid
  )
)
/// 设置上边框为1px的黑色实线边框，左边框为1px的红色实线边框
BoxBorder(
  border:Border(
    top: BorderSide(
        color: Colors.black,
        width: 1,
        style: BorderStyle.solid
    ),
    left: BorderSide(
        color: Colors.red,
        width: 1,
        style: BorderStyle.solid 
    )),
)
```
##### 设置阴影
可以使用`BoxShdow`来设置阴影属性，具体用法跟web中的阴影类似。
```dart
BoxDecoration(
    boxShadow: [
        BoxShadow(
        offset: Offset(0,0),
        blurRadius: 6,
        spreadRadius: 10,
        color: Color.fromARGB(20, 0, 0, 0)
        )
    ]
)
```
##### 设置渐变
可以通过渐变设置，将容器背景色设置成渐变色。Flutter支持线性渐变和径向渐变两种：
```dart
/// 线性渐变实例：由左到右，从红色向蓝色进行线性渐变
BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Colors.red,Colors.blue]
        )
      )

/// 径向渐变实例：由红色到蓝色从中心进行径向渐变
BoxDecoration(
          gradient: RadialGradient(
              center: Alignment.center, 
              colors: [Colors.red, Colors.blue]))
```
##### 设置圆角

与边框相同，我们可以同时设置容器4个角的圆角，也可以独立设置某些角的圆角。
```dart
/// 同时设置4个角圆角，圆角为5
BoxDecoration(
        borderRadius: BorderRadius.circular(5)
      ),

/// 单独设置圆角：左上角设置为5，右上角设置为10，左下角设置为5，右下角设置为10
BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(5),
          topRight: Radius.circular(10),
          bottomLeft: Radius.circular(5),
          bottomRight: Radius.circular(10)
        )
      ),
```
#### alignment属性
该属性用于决定容器中组件将以何种方式进行排列，通常我们会用到如下排列方式：
```dart
Alignment.topLeft//左上
Alignment.topCenter// 上中
Alignment.topRight// 右上
Alignment.centerLeft// 左中
Alignment.center// 居中
Alignment.centerRight// 右中
Alignment.bottomLeft// 左下
Alignment.bottomCenter// 下中
Alignment.bottomRight// 右下
```
#### transform属性
transform属性主要是对容器进行变换，变换的方式包括平移，缩放，旋转和倾斜。在flutter中通过Matrix4类来进行变换的计算。变换的方式如下
```dart
translationValues(x, y, z)// 平移x, y, z；
rotationX(radians)// x轴旋转radians弧度；
rotationY(radians)// y轴旋转radians弧度；
rotationZ(radians)// z轴旋转radians弧度；
skew(alpha, beta)// x轴倾斜alpha度，y轴倾斜beta度；
skewX(alpha)// x轴倾斜alpha度；
skewY(beta)// y轴倾斜beta度；

```
#### padding和margin属性

margin：容器外补白；该属性是指从自身边框到另一个容器边框之间的距离。
padding：容器内补白；该属性是指资深边框到自身内部到另一个容器边框之间的距离。