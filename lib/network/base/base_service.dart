import 'dart:io';
import 'package:basic_frame/bean/base_bean.dart';
import 'package:basic_frame/util/logger/logger_util.dart';

///共用函数集
class BaseService {
  ///json解析函数，运行于独立Isolate
  ///[params]: 参数列表
  ///params[0]: log输出地址
  ///params[1]: 需要解析的json
  BaseBean? parseJson(List<dynamic> params) {
    final logPath = params[0];
    final data = params[1];
    try {
      return BaseBean.fromJson(data);
    } catch (e) {
      LoggerUtil(directory: Directory(logPath))
          .e(e, tag: '[BaseService][parseJson]');
    }
    return null;
  }
}
