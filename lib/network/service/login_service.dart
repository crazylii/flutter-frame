import 'package:basic_frame/bean/base_bean.dart';
import 'package:basic_frame/constant.dart';
import 'package:basic_frame/network/base/api_constant.dart';
import 'package:basic_frame/network/base/base_service.dart';
import 'package:basic_frame/network/base/presenter.dart';
import 'package:flutter/foundation.dart';
import '../dio/request.dart';

///登录
class LoginService extends BaseService {
  LoginService({this.service});
  final Presenter? service;

  Future<BaseBean?> login(
      String username, String password, String registrationId) async {
    Request request = Request(baseUrl, loginUrl, isAuth: false);
    request.addParam("username", username);
    request.addParam("password", password);
    request.addParam("registrationId", registrationId);
    var data = await service?.get(request); //captcha
    List params = List.empty(growable: true);
    final loggPath = await logPath();
    //添加log路径
    params.add(loggPath);
    //添加json
    params.add(data);
    //单独Isolate解析json
    BaseBean? bean = await compute(parseJson, params);
    if (bean == null) {
      throw Exception('登录结果json解析失败');
    }
    return bean;
  }
}
