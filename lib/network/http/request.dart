import 'package:basic_frame/constant.dart';
import 'package:basic_frame/local_store/shared_prefer/shared_preference.dart';
import 'package:basic_frame/util/logger/logger_util.dart';

class Request{
  String domain;
  String api;
  Map<String, dynamic> params={};
  Map<String, dynamic> queryParams={};
  Map<String, String> header={};
  bool isAuth=true;

  ///isAuth 接口是否需要token认证 默认true
  Request(this.domain,this.api,{this.isAuth=true}){
    if(isAuth) {
      var token = SharedPreferenceUtil().get(tokenKey) as String;
      var userId = SharedPreferenceUtil().get(userIdKey) as String;
      LoggerUtil().i("token = $token");
      LoggerUtil().i("userId = $userId");
      header[tokenKey] = token??'';
      header[userIdKey] = userId??'';
    }
    header['Content-Type']='application/json';
  }

  void addParam(String key,dynamic value){
    params[key] = value;
  }

  void addQueryParam(String key,dynamic value){
    queryParams[key] = value;
  }

  void addHeader(String key,String value){
    header[key]=value;
  }

}