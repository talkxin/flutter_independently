### dart 中类的构造方法

在 dart 中，如果定义的类没有定义构造方法，会默认携带一个无参的构造方法。

**普通构造方法**

普通构造函数如 Java 一样：

```dart
class Test{
    int x,y;

    Test(int x,int y){
        this.x=x;
        this.y=y;
    }
}

/// 如果单纯赋值类型的构造方法，dart提供了另外一种构造方法的语法

class Test2{
    int x,y;

    // 这样就可以完成构造方法中的赋值操作，这样写就可以节省一部分赋值的代码块
    Test2(this.x,this.y);
}
```

**命名构造方法**

在 dart 中，两个同名的构造方法是无法进行重载的，为了解决这个问题在 dart 中引入了命名构造方法

```dart
class User{
    int userId;
    String userName;
    int age;

    User.initId(int id){
        this.userId=id;
    }

    User.userInfo(String name,int age){
        this.userName=name;
        this.age=age;
    }
}

void main(){
    // 使用initId构造方法创建对象
    User test1=User.initId(1);
    // 使用userinfo构造方法创建对象
    User test2=User.userInfo("张三",26);
}
```

**常量构造方法**

在 dart 中，可以定义一个成员变量全都是 final 的构造函数，构造函数也需要使用 const 常量标记，这样可以节省

```dart
class Test{
    final int x;
    final int y;

    const Test(this.x,this.y);
}

void main(){
    // 如果使用常量构造方法，则需要通过const关键字来创建对象
    final Test test=const Test(0,0);
}
```

**构造方法重定向**
在 dart 中可以通过重定向来定向到一个构造方法，类似于 Java 中的 super

```dart
class Test{
    int x,y;

    Test(this.x,this.y);

    Test.findobj(int x,int y):this(x,y);

    Test.findtest(int x,int y):this.findobj(x,y);

    //当然也可以使用标准方式
    Test.toFindobj(int x,int y){
        Test.findobj(x,y);
    }
}
```

**dart 中单例与对象工厂**

dart 中工厂构造函数，类似于 Java 中的单例模式，可以在工厂中管理一个静态缓存，在创造对象时，可以通过缓存来管理对象集合

```dart
class  Logger {
    final String name;

    // 创建一个静态Map做为缓存
    static final Map<String, Logger> _cache =  <String, Logger>{};

    // 定义一个命名构造方法，用下划线"_"修饰，将构造方法私有化
    Logger._internal(this.name);

    // 使用关键字factory修饰类同名构造方法
    factory Logger(String name) {
        if (_cache.containsKey(name)) {
            return _cache[name];
        } else {
            // 调用命名构造方法创建新对象
            final logger= new  Logger._internal(name);
            _cache[name] = logger; // 存入缓存
            return logger;
        }
    }
}

void  main() {
    var uiLog = new Logger('UI');
    var eventLog = new Logger('event');
}
```

### dart 中类的初始化列表

在 dart 中，有一种在 C++中的特性，叫初始化列表，用于初始化实例变量，属于一种特殊的构造方法

```dart
class Test{
    int x;
    int y;

    Test(x, y)
      : x = x,
        y = y{
    // 这是标准的构造方法内容，在初始化x与y的值以后，可以在这里运行构造方法内容
    // 如果不包含构造方法，则在初始化完成最后一个参数后以';'结尾即可
    // 在进行初始化列表时，需要在构造方法后边，加’:‘
    // 每个初始化的成员变量之间，以','分割
    print("这是构造方法");
  }
}

void main() {
  Test p = Test(2, 3);
  print(p.y);
}
```

> 这里需要注意的是，初始化列表的调用是在构造方法之前，也就是在实例化对象之前，所以在初始化列表中是无法使用`this`来引用成员变量

### dart 中特殊的成员变量操作方式（get/set 方法）

在 Java 中，让外部使用私有的成员变量，一般是使用 get/set 方法的方式用于暴露私有成员变量，在 dart 中，通过 get/set 关键字来快速实现 get/set 方法

```dart
class Test {
  String x;
  String y;
  String z;

  Test()
      : x = "x",
        y = "y",
        z = "z";

  // set函数，在函数前面增加set关键字，在使用set关键字时，只能给一个成员变量赋值
  set setX(String x) {
    this.x = x;
  }

  // get函数，在函数前面增加get关键字,函数不需要增加’()‘
  String get getX {
    return this.x;
  }

  // 也可以使用=>来快速实现get方法
  String get getY => this.y;

  // get/set函数可以使用相同的函数名
  set zname(String z) {
    this.z = z;
  }

  get zname => this.z;
}

void main() {
  var p = Test();
  // 使用set，对x进行赋值
  p.setX = "123";
  print(p.getX); //输出123
  print(p.getY); //输出y
  p.zname = "set zname";
  print(p.zname); //输出set zname
}
```

### 运算符重载

运算符重载，也是一个在 c++中才有的特性，主要是为类重载一个可执行的运算符，可以执行诸如自定义对象之间的运算。

```dart
class Test {
  int x, y, z;
  Test(int numX, numY, numZ)
      : x = numX,
        y = numY,
        z = numZ;

  //使用operator关键字对类进行运算符重载
  Test operator +(Test t) {
    return Test(this.x + t.x, this.y + t.y, this.z + t.z);
  }

  // 重载可以传入任意对象，完成对象的构造
  Test operator -(Test2 t) {
    return Test(t.x - this.x, t.y - this.y, t.z - this.z);
  }
}

class Test2 {
  int x, y, z;
  Test2()
      : x = 10,
        y = 20,
        z = 30;
}

void main() {
  Test t1 = Test(4, 5, 6);
  Test t2 = Test(1, 2, 3);
  Test2 tt1 = Test2();
  t1 = t1 + t2;
  print("${t1.x},${t1.y},${t1.z}"); //输出5,7,9
  t1 = t1 - tt1;
  print("${t1.x},${t1.y},${t1.z}"); //输出5,13,21
}
```

在 dart 中允许重载的运算符如下：

> `+`，`–`，`*`，`~/`（取整），`/`，`%`，`^`（异或），`<`，`>`，`<=`，`>=`，`==`，`[]`，`[]=`，`&`（按位与），`~`（按位非），`<<`，`>>`，`|`（按位或）

### 类的继承与接口

### 类的泛型

### dart 中的自定义异常

### dart 中如何进行异步编程
