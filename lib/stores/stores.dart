import 'package:get/get.dart';

class Stores extends GetxController {
  var count = 0.obs;

  increment() => count++;
}

class StoresBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Stores>(() => Stores());
  }
}
