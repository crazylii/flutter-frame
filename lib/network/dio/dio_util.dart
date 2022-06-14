import 'package:dio/dio.dart';
import 'dio_setting.dart';

class DioUtil{
  static DioUtil? _instance;
  final Map<String,Dio> _map = {};
  DioUtil._();

  static DioUtil getInstance() {
    _instance = _instance ?? DioUtil._();
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