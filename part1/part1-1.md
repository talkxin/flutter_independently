## Dart 的基础语法

### 新建 dart 脚本文件

dart 文件如 Java 文件一样，是以'.dart'为扩展名的文件。

### 程序入口

打开一个 dart 文件，就可以通过入口函数来编译运行该脚本，dart 的入口方法如 C 一样，是通过 main 方法来引导程序入口，入口函数声明如下：

```dart
    // 无返回值的main入口函数
    main(){
        print("hello dart!")
    }

    // 空返回值main入口函数
    void main(){
        print("hello dart!")
    }
```

### 程序注释的方式

dart 的注释同众多脚本语言一样，如下几种注释的方式：

```dart
    // 双斜杠注释，只能注释单行

    /*
        可以注释多行
        以星号斜杠为注释结尾
    */

    /**
    *   同java一样，该注释为文档注释
    */

    /// dart文档注释
    /// dart官方推荐使用该注释来说明文档
```

### 内置基础数据类型：

```UML
@startuml
dart内置数据类型 --|> 数字
dart内置数据类型 --|> 字符串
dart内置数据类型 --|> 布尔值
dart内置数据类型 --|> 列表
dart内置数据类型 --|> 映射
dart内置数据类型 --|> 默认对象类型


数字 : int
数字 : double
字符串 : String
布尔值 : bool
列表 : List
映射 : Map
默认对象类型 : var
默认对象类型 : dynamic
默认对象类型 : Object
@enduml
```

内置数据类型

> 如果声明了变量，但是没有给予默认值，则所有类型的默认值均为`null`，int 值也是`null`

数字数据类型的数值范围

> int 值的范围为`-2^53`至`2^53`之间，double 为 64 位的双精度浮点数。

基础数据类型的变量声明方式

```dart
/// 常量的定义

// 数字类型
var default_num = 1;
int int_num = 2;
double double_num = 3.01;

// 字符串类型
var string_test = "hello";
String string_test2 = 'hello world';
String string_test3 = """可以通过三个双引号
定义多行字符串
""";
String string_test4 = '''同理，
也可以使用单引号来定义多行字符串
'''

// 布尔值
var bool_test = true;
bool bool_test2 = false;

//动态改变数据类型可以用var/dynamic/Object来定义
var test1 = 1；
test1 = "hello";
print(test1);//输出hello

dynamic test2 = "hello";
test2 = 2;
print(test2);// 输出2

Object test3 = 3；
test3 = "hello";
print(test3);//输出hello 
```

常量的定义

> dart 中有两种定义常量的方式，一种是用`const`关键字，另一种是用`final`关键字。
> `final`为运行时常量，在定义该常量时其值可以是一个变量。
> `const`为编译时常量，在定义该常量时其值必须是一个字面值，且不能改变

```dart
final time = new DateTime.now(); // 正确
const time = new DateTime.now(); // 错误


const list = const[1,2,3];// 正确
const list = [1,2,3];// 错误
```

### 内置数据类型的常用操作

数值操作

```dart
// String 转 int
var one = int.parse('1');

// String 转 double
var onePointOne = double.parse('1.1');

// int 转 String
String oneAsStr = 1.toString();

// double 转 String
String piAsStr = 3.14159.toStringAsFixed(2); // 保留两位 '3.14'
```

字符串操作

```dart
// 1、在定义字符串时，如果字符串中包含特殊字符，则可以在字符串前加r使特殊字符不需要转译
String path = r"D:\workspace\code";

// 2、字符串拼接，dart中字符串拼接提供了两种方式

// 可以用+号来直接拼接字符串
String test1 = "hello" + " " + "world";

// 可以用插值表达式来拼接字符串
String name = "张三";
String allName = "他的名字是，${name}";
// 当仅作用于取值时，可以不用添加大括号，譬如
allName = "他的名字是，$name";
// 但当拼接的是一个表达式时，则必须使用大括号来标出全部
name = "zhangsan";
allName = "他的名字是，${name.toUpperCase()}";
```

布尔类型

```dart
// 需要注意的是，dart中如果不对变量进行初始化值，则该变量的默认值为null，布尔值也一样
bool flag;
print(flag);//输出null
flag = true;
print(flag);//输出true
```

列表

```dart
// 在dart中操作列表的方式，同操作数组类似

//创建列表
var list1 = [1,2,3];

//同时也可以指定列表的范型进行创建
var list2 = <String>['Seth', 'Kathy', 'Lars'];

//也可以使用对象方式初始化一个空的列表
var list3 = List<String>();

//可以使用函数来对列表中的内容进行修改
list2.add("test");//添加元素
list2.remove("test");//删除指定元素
list2.removeAt(0);//通过索引删除元素
list2.removeRange(0,2)//通过索引，删除列表中一个范围的内容
list2.removeLast();//返回并删除列表中最后一位内容
```

[列表的详细操作可以参考](http://codingdict.com/article/21920)

映射

```dart
// 映射类似于java中的map，属于键值对结构

// 基础创建
var map1 = {
    "first" : "第一个",
    "second" : "第二个",
    "test" : "键值对"
}

// 使用MAP对象创建并赋值
var map2 = new Map();
map2['first'] = "第一个";
map2["senond"] = "第二个";

// 在map中同样可以使用范型来创建
// 这样可以指定Map的key跟value属于那种类型
Map<String, String> dic1 = new Map.from({'name': '张三'});
```

### 运算符

> 算数运算符：`+`,`-`,`*`,`/`,`%`,同时 dart 多出一个整除运算符`~/`，与普通除号的区别是将相除后的结果取整返回。

```dart
// 取整示例
var a = 2;
var b = 15;
print(b/a);//输出7.5
print(b~/a);//输出7
```

> 按位运算符：`>>`,`<<`,`&`,`|`

> 关系运算符：`==`,`!=`,`<`,`>`,`<=`,`>=`

> 逻辑运算符：`!`,`&&`,`||`

> 赋值运算符：`=`,`??=`

```dart
// ??= 表示为空赋值
// 如果a为空，则会把b的值赋值给a，否则保持a的值不变
var a= 3;
var b= 5;
print(a ??= b);//输出3
a=null;
print(a ??= b);//输出5

// 同样也可以将??=拆开使用
// 其含义为，如果赋值不为空则会将该值赋予，否则则赋值？？后边的值
var a;
var b=10;
var c = a ?? b;
print(c);//输出10
a = 20;
c =  a ?? b;
print(c);//输出20
```

> 复合赋值运算符：`+=`,`-=`,`*=`,`/=`,`&=`,`~/=`

> 特殊运算符：在 dart 中也支持三元表达式

```dart
bool a = true;
var b=a?10:20;
print(b);//输出10
```

### 条件表达式与循环

条件判断：
```dart
/// dart中支持两种条件判断方式：if/else switch/case 其用法与java相同
var a=30;
if(a<10){
    print("分支1")
}else if(a>20 && a<50){
    print("分支2")
}else{
    print("分支3")
}

// switch 支持字符串与数字
var b="中国";
switch(a){
    case "中国":
        print("中国人");
        break;
    case "美国":
        print("美国人");
        break;
    case "日本":
    case "其他":
        print("其他国家");
        break;
    default:
        print("参数错误");
}
```

循环：
> 在dart中循环与java相同，支持for/while/do while循环三种，同时也支持特有循环

```dart
// 基础循环
var list1 = [1,2,3,4,5];
for(var i=0;i<list1.length;i++){
    print(list1[i]);
}
var l=0;
while(l<list1.length){
    print(list1[l]);
    l++;
}

// 特有循环
for(var i in list1){
    print(i);
}
// forEach循环。其参数为一个Function对象，这里传入一个匿名函数
list1.forEach((var it){
    print(it);
});
// 可以使用匿名箭头函数简写
list1.forEach((it) => print(it));

// 使用循环遍历Map
var myMap = {
'zhangsan':'201901',
'lisi':'201902',
'wangwu':'201902'
};
// 基础循环
for (var i = 0; i < myMap.keys.length; i++) {
    print(myMap[myMap.keys.elementAt(i)]);
}
// 但是用dart的特有循环可以快速的完整对map的循环处理
for (var k in myMap.keys) {
print(myMap[k]);
}

myMap.forEach((key, value) => print("$key : $value"));
```

### 错误拦截与处理

在dart中错误处理方式如Java类似，分为三种情况：

```dart
try {
  test();
} on NullPoingtException {
  // 一个具体异常
  print("the exception is NullPoingtException");
} on Exception catch (e) {
  // 任意一个异常
  print('Unknown exception: $e');
} catch (e) {
  // 非具体类型
  print('Something really unknown: $e');
}finally {
  // 即使抛出一个异常时也会进
  print("this is finally");
}
```

其中如果cache当前代码块不处理，则可以通过使用`rethrow`将错误传递下去。

列举几个常见错误类型：
- DeferredLoadException 延迟库无法加载
- FormatException 数据类型转换异常,或解析异常
- IntegerDivisionByZeroException 数字除以零
- IOException IO流异常
- NullPoingtException 空指针异常