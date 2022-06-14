import 'package:dio/dio.dart';
import 'dio_setting.dart';

class HttpUtil{
  static HttpUtil? _instance;
  final Map<String,Dio> _map = {};
  HttpUtil._();

  static HttpUtil getInstance() {
    _instance = _instance ?? HttpUtil._();
    return _instance!;
  }

  Dio getDio(String baseUrl){
      if(!_map.containsKey(baseUrl)){
        DioSetting dioSetting = DioSetting(baseUrl);
        _map[baseUrl] = dioSetting.dio;
      }
      Dio? tmp = _map[baseUrl];
      if(tmp == null){
        DioSetting dioSetting = DioSetting(baseUrl);
        _map[baseUrl] = dioSetting.dio;
        return dioSetting.dio;
      }else{
        return tmp;
      }
  }
}