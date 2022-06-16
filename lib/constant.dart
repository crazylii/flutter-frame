import 'package:path_provider/path_provider.dart';

///登录信息缓存
const hasLoginKey = "hasLogin";
const tokenKey = "x-token-header";
const userIdKey = "x-userid-header";
const userNameKey = "x-username";

///log本地输出路径
String? _logPath;

///此方法必须在主线程调用
Future<String> logPath() async {
  return _logPath ??= '${(await getExternalStorageDirectory())?.path}/log';
}
