import 'package:get/get.dart';
import 'package:tek_app/core/view_model/auth_view_model.dart';
import 'package:tek_app/core/view_model/cart_viewmodel.dart';
import 'package:tek_app/core/view_model/checkout_viewmodel.dart';
import 'package:tek_app/core/view_model/control_view_model.dart';
import 'package:tek_app/helper/local_storage_data.dart';
import 'package:tek_app/view/ckeckout/checkout_view.dart';

import '../core/view_model/home_view_model.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthViewModel());
    Get.lazyPut(() => ControlViewModel());
    Get.lazyPut(() => HomeViewModel());
    Get.lazyPut(() => CartViewModel());
    Get.lazyPut(() => LocalStorageData());
    Get.lazyPut(() => CheckOutViewModel());
  }
}
