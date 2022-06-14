import 'package:basic_frame/bean/base_bean.dart';
import 'package:basic_frame/network/base/api_constant.dart';
import 'package:basic_frame/network/base/base_service.dart';
import 'package:basic_frame/network/http/request.dart';
import 'package:basic_frame/util/logger/logger_util.dart';
import 'package:basic_frame/util/toast.dart';
///登录
class LoginService extends BaseService {
  Future<BaseBean?> login(
      String username, String password, String registrationId) async {
    Request request = Request(baseUrl, loginUrl, isAuth: false);
    request.addParam("username", username);
    request.addParam("password", password);
    request.addParam("registrationId", registrationId);
    var data = await get(request); //captcha
    try {
      BaseBean baseBean = BaseBean.fromJson(data);
      return baseBean;
    } catch(e) {
      LoggerUtil().e(e);
      Toast.show('网络状态不好,登录失败，请稍后重试');
    }
  }
}