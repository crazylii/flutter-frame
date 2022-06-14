import 'package:basic_frame/util/logger/logger_util.dart';
import 'package:dio/dio.dart';

const dioUtilTag = "DioUtil";

class DioSetting {
  late Dio dio;
  String baseUrl;

  DioSetting(this.baseUrl) {
    if (baseUrl.isEmpty) {
      throw Exception("please set base url");
    }
    dio = Dio()
      ..options = BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: 10000,
          receiveTimeout: 1000 * 60 * 60 * 24,
          responseType: ResponseType.json)
      //网络状态拦截
      ..interceptors.add(HttpLog())
      ..interceptors.add(ErrorInterceptor());
  }
}

class HttpLog extends Interceptor{
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    var str = """\n ---------Start Http Request---------\n """
        """Url:${options.baseUrl}${options.path}\n """
        """Method:${options.method}\n """
        """Headers:${options.headers}\n """
        """Data:${options.data}\n """
        """QueryParameters:${options.queryParameters}\n """
        """---------End Http Request---------\n """;
    LoggerUtil().i(str, tag: dioUtilTag);
    return super.onRequest(options,handler);
  }
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    var str = """\n ---------Start Http Response---------\n """
        """Url:${response.requestOptions.baseUrl}${response.requestOptions.path}\n """
        """StatusCode:${response.statusCode}\n """
        """StatusMessage:${response.statusMessage}\n """
        """Headers:${response.headers.toString()}\n """
        """---------End Http Response---------\n """;
    LoggerUtil().i(str, tag: dioUtilTag);
    LoggerUtil().i(response.data, tag: dioUtilTag);
    return super.onResponse(response,handler);
  }
}

class ErrorInterceptor extends Interceptor{

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    LoggerUtil().e(err.response?.data, tag: dioUtilTag);
    super.onError(err, handler);
  }
}