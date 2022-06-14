import 'package:basic_frame/network/base/base_service.dart';
import 'package:basic_frame/network/dio/dio_util.dart';
import 'package:basic_frame/network/dio/request.dart';
import 'package:basic_frame/util/logger/logger_util.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

class DioService implements BaseService {
  static const tag = "DioService";
  ///get请求
  @override
  Future get(Object request) async {
    request = request as Request;
    var data;
    try {
      Dio _dio = DioUtil.getInstance().getDio(request.domain);
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
  @override
  Future<dynamic> post(Object request) async {
    request = request as Request;
    var data;
    try {
      Dio _dio = DioUtil.getInstance().getDio(request.domain);
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
  @override
  Future put(Object request) async {
    request = request as Request;
    var data;
    try {
      Dio _dio = DioUtil.getInstance().getDio(request.domain);
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
  @override
  Future delete(Object request) async {
    request = request as Request;
    var data;
    try {
      Dio _dio = DioUtil.getInstance().getDio(request.domain);
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
