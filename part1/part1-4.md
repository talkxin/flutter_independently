### dart 系统库介绍

> 详情请参照[dart 官方 API](https://api.dart.cn/stable/2.10.4/index.html)

在 dart SDK 中，系统库主要分为三类 core（核心类），VM（原生平台库），WEB(网络包)

#### CORE

核心库主要包含如下内容：

> dart:async</br>
> 支持通过使用 Future 和 Stream 这样的类实现异步编程

> dart:collection</br>
> 提供 dart:core 库中不支持的额外的集合操作工具类。

> dart:convert</br>
> 用于提供转换不同数据的编码器和解码器，包括 JSON 和 UTF-8。

> dart:core</br>
> 每一个 Dart 程序都可能会使用到的内置类型、集合以及其它的一些核心功能。

> dart:developer</br>
> 类似调试器和分析器这样的与开发者交互配合的工具。

> dart:math</br>
> 包含算术相关函数和常量，还有随机数生成器。

> dart:typed_data</br>
> 高效处理固定大小数据（例如无符号的 8 位整型）和 SIMD 数字类型的列表。

#### VM

> dart:io</br>
> 用于支持非 Web 应用的文件、Socket、HTTP 和其它 I/O 操作。

> dart:isolate</br>
> 使用 Isolate 实现并发编程：类似于线程的独立的 Worker。

> dart:mirrors</br>
> 支持检查和动态调用的基本反射功能。

#### WEB

> dart:html</br>
>
> 为 Web 应用开发所提供的 HTML 元素和其它资源。

> dart:indexed_db</br>
>
> 客户端上使用的可以索引的键值对存储。

> dart:web_audio</br>
>
> 用于浏览器的高保真音频编程。

> dart:web_gl</br>
> 用于浏览器的 3D 编程。

> dart:js(已弃用)</br>
> 不要使用该库，请使用 js 这个 Package 替代，就像我们在 JavaScript 互相调用 中说的那样。

> dart:js_util(已弃用)</br>
> 不要使用该库，请使用 js 这个 Package 替代，就像我们在 JavaScript 互相调用 中说的那样。

> dart:web_sql(已弃用)</br>
> 用于在浏览器中存储数据的 API，存储的数据可以通过 SQL 查询。
