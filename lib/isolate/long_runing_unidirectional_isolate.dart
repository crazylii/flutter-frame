import 'dart:io';
import 'dart:isolate';
import 'package:basic_frame/local_store/file/file_store.dart';
import 'package:basic_frame/util/logger/logger_util.dart';
import 'package:path_provider/path_provider.dart';

///异步调用演示，副线程多次返回结果
class LongRunningUnidirectionalIsolate {
  static const tag = "LongRunningUnidirectionalIsolate";
  //演示测试方法
  void test() async {
    Directory? logPath;
    try {
      final path = await getExternalStorageDirectory();
      logPath = Directory('${path!.path}/log');
      final filePath = '${path.path}/log/test.txt';

      List<dynamic> args = [];
      //添加log输出地址
      args.add(logPath);
      //添加待执行函数
      args.add(FileStoreUtil().readLineString);
      //添加待执行函数所需参数，无参函数可不添加
      args.add(filePath);
      await for (final message in send<String, String>(args)) {
        LoggerUtil().e(message, tag: '[$tag][test]');
      }
    } catch (e) {
      LoggerUtil(directory: logPath).e(e, tag: '[$tag][test]');
    }
  }
}

///多返回值异步任务方法
///args目前仅支持输入三个参数
///args[0]: 待执行函数体, 必须，仅支持Stream<R> 类型返回值函数
///args[1]: log输出地址, 必须
///args[2]: 待执行函数参数, 可选，无参函数则不添加
Stream<R> send<Q, R>(List<dynamic> args) async* {
  final p = ReceivePort();
  args.insert(0, p.sendPort);
  await Isolate.spawn(_work<Q, R>, args);
  await for (R message in p) {
    yield message;
  }
}

///带参数函数返回值
typedef WorkCallback<Q, R> = Stream<R> Function(Q message);
///无参数函数返回值
typedef WorkVoidCallback<R> = Stream<R> Function();

Future _work<Q, R>(List<dynamic> args) async {
  Directory? logPath;
  try {
    SendPort sendPort = args[0];
    logPath = args[1];
    if (args.length == 3) {//无参函数
      WorkVoidCallback<R> work = args[2];
      await for (final message in work.call()) {
        sendPort.send(message);
      }
    } else if (args.length == 4) {//带参函数
      WorkCallback<Q, R> work = args[2];
      final params = args[3];
      await for (final message in work(params)) {
        sendPort.send(message);
      }
    }
    Isolate.exit();
  } catch(e) {
    LoggerUtil(directory: logPath).e(e, tag: '[LongRunningUnidirectionalIsolate][_work]');
    //延迟销毁，等待错误log能够输出到文件中
    Future.delayed(const Duration(seconds: 500), () => Isolate.exit());
  }
}
