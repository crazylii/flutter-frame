///可拓展service
abstract class BaseService {

  ///get请求
  Future get(Object request);

  ///post请求
  Future post(Object request);

  ///put请求
  Future put(Object request);

  ///delete请求
  Future delete(Object request);
}
