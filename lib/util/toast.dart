import 'package:flutter_easyloading/flutter_easyloading.dart';

class Toast{
  //   0: top,
  //   1: center
  //   2: bottom
  static void show(String msg,{int align=2}){
      EasyLoading.showToast(msg,toastPosition: EasyLoadingToastPosition.values[align]);
  }
}