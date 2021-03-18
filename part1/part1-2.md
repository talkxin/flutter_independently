## dart 中的函数与类

### 定义函数

dart 中定义函数基本与 java 语言定义类似：

```dart
void test(){
    print("hello");
}

String test1(){
    return "hello";
}
```

其中与 Java 不同的是，在 Dart 中类型是可选的，可以省略返回类型，但官方还是建议携带类型定义函数：

```dart
test(){
    print("hello");
}

test1(){
    return "hello";
}
```

### 函数中的参数定义

#### 带类型式传参：

```dart
void test(String name){
    print(name);
}
```

#### 省略类型式传参：

```dart
/// 同定义函数中省略类型一样，在参数定义中，也可以省略类型进行定义传参
/// 但还是建议在传参时携带参数类型
void test(name){
    print(name);
}
```

#### 命名可选参数：

```dart
// 大括号中的参数是可选参数，可以通过定义传参
void test({String first_name,String second_name}){

}

/// 调用方式：
/// 1、所有可选参数均可以省略
test();
/// 2、可以指定需要传递的参数
test(second_name:"young",first_name:"paul");
```

#### 命名可选参数可以给可选参数定义默认值：

```dart
void test({int x,int y=0,int z=1}){
    print(x+y+z);
}
/// 调用方式：
test(x:5);//输出6
test(x:5,y:6,z:7);//输出18
```

#### 位置可选参数：

```dart
/// 中括号中的参数是可选的，但是需要注意的是，位置可选参数与命名可选参数的区别是：
/// 1、位置可选参数必须按可选顺序输入
/// 2、命名可选参数可以通过命名来指定输入的参数
void test(int x,[int y=1,int z=1]){
    print(x+y+z);
}

/// 调用方式：
test(5);//输出7
test(5,6);//输出12
test(5,6,7);//输出18
```

### 匿名函数

dart 也支持通过匿名的方式来定义函数，也称之为闭包：

```dart
var test=(int x,int y){
    return x+y;
}

/// 调用方式：
print(test(10,20));//输出30
```

同时 dart 函数也支持 Lambda 表达式：

```dart
// 普通函数
add(int x,int y){
    return x + y;
}
// 使用lambda表达式
// 这个函数与上面普通的函数定义完全等价
add_l(int x,int y)=>x+y;

// 结合闭包可以将代码大大简化
var test=(int x,int y)=>x+y;
```

### dart 中的类定义

dart 中的类定义与 Java 类似

```dart
class Test{
    // 命名了一个类
}

/// 事例化的方式也与Java相同，直接new出该对象即可
var test=new Test();
Test test1=new Test();
```
> 在dart中实例化对象时`new`关键字不是必须的，可以省略不写。

在 dart 中没有 Java 中类定义的诸如`public`,`private`多种访问修饰符，在 dart 中是通过对函数的命名来控制其内部变量的访问作用域，在 dart 中只有两种，公开与私有。

```dart
class Test{
    // 该属性为私有属性，只能在当前dart文件中访问该属性
    String _name;
    // 该属性为公开属性
    // 可以在当前dart文件中访问该属性，也可以在其他dart文件中访问该属性
    String sex;
}
```

这里说到 dart 的公私有函数与属性的作用域是在其他 dart 文件中，那么在 dart 中引用其他库的方式是：

```dart
// 可以使用相对或绝对路径来引用某一dart
// 譬如该文件属于本项目中的某一层级目录
import 'lib/testlib/test.dart';
// 指定package:前缀，表示导入包管理系统中的库
// 1、可以引用在本地包管理文件夹中其他自定义项目中的dart文件
// 2、可以引用Pub仓库仓库中的第三方库，在编译时自动下载到本地包管理文件夹中
import 'package:project2/lib/test.dart';
// 引入dart标准库
import 'dart:xxx';
```

如果引用的多个库文件中有重名的 dart 文件，可以通过起别名的方式来防止引用冲突：

```dart
import 'lib/test1/test.dart' as test1;
import 'lib/test2/test.dart' as test2;
import 'lib/test3/test.dart';

// 使用test1包中的Test类
Test test1=new test1.Test();
// 使用test2中的Test类
Test test2=new test2.Test();
// 使用test3包中的Test类
Test test3=new Test();
```
随着引用的库逐渐变大，直接引入整个的dart文件会导致我们的启动速度降低，此时可以同Python一样，在引用其他库时只引用我们所需要的部分：

```dart
// 只导入test.dart中的Test1与Test2
import 'lib/test.dart' show Test1,Test2;
// 除了Test3以外，都导入
import 'lib/test.dart' hide Test3;
```

为了加快我们程序的启动与运行，可以同python中一样使用懒加载来加载我们的库，即在使用时才加载该库：

```dart
import 'lib/test.dart' deferred as hello;

// 当我们的程序运行到该句柄时，才会去加载test.dart库
hello.loadLibrary();
```

