### dart 中类的构造方法

在dart中，如果定义的类没有定义构造方法，会默认携带一个无参的构造方法。

**普通构造方法**

普通构造函数如Java一样：
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

在dart中，两个同名的构造方法是无法进行重载的，为了解决这个问题在dart中引入了命名构造方法
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

在dart中，可以定义一个成员变量全都是final的构造函数，构造函数也需要使用const常量标记，这样可以节省

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
在dart中可以通过重定向来定向到一个构造方法，类似于Java中的super
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

**dart中单例与对象工厂**

dart中工厂构造函数，类似于Java中的单例模式，可以在工厂中管理一个静态缓存，在创造对象时，可以通过缓存来管理对象集合
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

### dart 中特殊的成员变量操作方式（get/set 方法）

### 运算符重载

### 类的继承与接口

### 类的泛型

### dart 中的自定义异常

### dart 中如何进行异步编程
