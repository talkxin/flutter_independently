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

其中与Java不同的是，在Dart中类型是可选的，可以省略返回类型，但官方还是建议携带类型定义函数：

```dart
test(){
    print("hello");
}

test1(){
    return "hello";
}
```

### 函数中的参数定义

带类型式传参：
```dart
void test(String name){
    print(name);
}
```
省略类型式传参：
```dart
/// 同定义函数中省略类型一样，在参数定义中，也可以省略类型进行定义传参
/// 但还是建议在传参时携带参数类型
void test(name){
    print(name);
}
```
命名可选参数：
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

命名可选参数可以给可选参数定义默认值：
```dart
void test({int x,int y=0,int z=1}){
    print(x+y+z);
}
/// 调用方式：
test(x:5);//输出6
test(x:5,y:6,z:7);//输出18
```

位置可选参数：
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

dart也支持通过匿名的方式来定义函数，也称之为闭包：
```dart
var test=(int x,int y){
    return x+y;
}

/// 调用方式：
print(test(10,20));//输出30
```

同时dart函数也支持Lambda表达式：
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