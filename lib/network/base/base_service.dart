import 'package:basic_frame/util/logger/logger_util.dart';
import 'package:dio/dio.dart';
import '../http/http_util.dart';
import '../http/request.dart';
import 'dart:convert';

class BaseService {
  final tag = "BaseService";

  ///get请求
  Future<dynamic> get(Request request) async {
    var data;
    try {
      Dio _dio = HttpUtil.getInstance().getDio(request.domain);
      var options = Options(headers: request.header);
      Response resp = await _dio.get(request.api,
          queryParameters: request.params, options: options);
      if (resp.statusCode == 200) {
        LoggerUtil().i("resp data: ${resp.data}", tag: tag);
        data = resp.data;
      }
    } on DioError catch (e) {
      //org.apache.shiro.authc.AuthenticationException
      data = e.response?.data;
    }
    //json转map
    if (data != null && data is String) data = jsonDecode(data);
    return data;
  }

  ///post请求
  Future<dynamic> post(Request request) async {
    var data;
    try {
      Dio _dio = HttpUtil.getInstance().getDio(request.domain);
      var options = Options(headers: request.header);
      Response resp = await _dio.post(request.api,
          data: request.params,
          queryParameters: request.queryParams,
          options: options);

      if (resp.statusCode == 200) {
        LoggerUtil().i("resp data: ${resp.data}", tag: tag);
        data = resp.data;
      }
    } on DioError catch (e) {
      //org.apache.shiro.authc.AuthenticationException
      data = e.response?.data;
    }
    //json转map
    if (data != null && data is String) data = jsonDecode(data);
    return data;
  }

  ///put请求
  Future put(Request request) async {
    var data;
    try {
      Dio _dio = HttpUtil.getInstance().getDio(request.domain);
      var options = Options(headers: request.header);
      Response resp = await _dio.put(request.api,
          data: request.params,
          queryParameters: request.queryParams,
          options: options);

      if (resp.statusCode == 200) {
        LoggerUtil().i("resp data: ${resp.data}", tag: tag);
        data = resp.data;
      }
    } on DioError catch (e) {
      //org.apache.shiro.authc.AuthenticationException
      data = e.response?.data;
    }
    //json转map
    if (data != null && data is String) data = jsonDecode(data);
    return data;
  }

  ///delete请求
  Future delete(Request request) async {
    var data;
    try {
      Dio _dio = HttpUtil.getInstance().getDio(request.domain);
      var options = Options(headers: request.header);
      Response resp = await _dio.delete(request.api,
          data: request.params,
          queryParameters: request.queryParams,
          options: options);
      if (resp.statusCode == 200) {
        LoggerUtil().i("resp data: ${resp.data}", tag: tag);
        data = resp.data;
      }
    } on DioError catch (e) {
      //org.apache.shiro.authc.AuthenticationException
      data = e.response?.data;
    }
    //json转map
    if (data != null && data is String) data = jsonDecode(data);
    return data;
  }
}
