import 'package:dio/dio.dart';

class CacheObject {
  Response response;
  int timeStamp;
  CacheObject(this.response) : timeStamp = DateTime.now().millisecondsSinceEpoch;

  @override
  bool operator ==(other) {
    return response.hashCode == other.hashCode;
  }

  @override
  int get hashCode => response.realUri.hashCode;
}
class NetCache extends Interceptor {
  var cache = <String, CacheObject>{};
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {

  }
}