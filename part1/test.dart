// 导入io库，调用sleep函数
import 'dart:io';

// 模拟耗时操作，调用sleep函数睡眠2秒
// 当我们使用了async关键字，意味着函数已经变成了异步函数。
doTask() async {
  // await表示等待该异步任务执行完成
  await sleep(const Duration(seconds: 2));
  print("Ok");
}

void main() {
  print("main start");
  doTask();
  print("main end");
}
