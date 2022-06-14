import 'dart:io';
import 'dart:isolate';

import 'package:basic_frame/util/logger/logger_util.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

///异步任务演示，副线程一次性返回结果
class IsolateUtil {
  void main() async {
    final directory = await getExternalStorageDirectory();
    final logPath = Directory('${directory!.path}/log');
    LoggerUtil(directory: logPath).i(DateTime.now().millisecondsSinceEpoch);
    final result = await compute(_parse, [2,logPath]);
  }

}

Future<int> _parse(List<dynamic> args) async {
  LoggerUtil(directory: args[1]).d('message');
  return args[0];
}

Future<int> parseInBackground([dynamic param]) async {
  final p = ReceivePort();
  await Isolate.spawn(_readAndParseJson, [p.sendPort, param]);
  return await p.first;
}

Future<int> _readAndParseJson(List<dynamic> args) async {
  LoggerUtil().d('message');
  Isolate.exit(args[0], 2);
}

Future<int> parse(int t) async {
  return t;
}