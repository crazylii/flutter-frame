/// success : true
/// message : "登录成功。"
/// code : 200
/// result : null

class BaseBean {
  BaseBean({
      this.success, 
      this.message, 
      this.code, 
      this.result,});

  BaseBean.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    code = json['code'];
    result = json['result'];
  }
  bool? success;
  String? message;
  int? code;
  dynamic result;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    map['code'] = code;
    map['result'] = result;
    return map;
  }

}