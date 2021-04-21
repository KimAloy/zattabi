import 'package:get/get.dart';
import 'package:zattabi/controllers/controllers.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
  }
}
