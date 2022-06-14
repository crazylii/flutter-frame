import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

///ViewModel 中间层 ， 连接数据层和UI层
abstract class BaseViewModel<T> extends ChangeNotifier{
  final BuildContext context;

  bool disposed = false;

  BaseViewModel(this.context);

  T get service => _getService();

  T _getService(){
    return context.read<T>();
  }
  @override
  void dispose() {
    super.dispose();
    disposed = true;
  }

  @override
  void notifyListeners() {
    if (!disposed) {
      super.notifyListeners();
    }
  }
}