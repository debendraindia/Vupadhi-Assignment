import 'package:get/get.dart';

class SplashVm extends GetxController {
  @override
  void onInit() {
    super.onInit();
    initializeApp();
  }

  void initializeApp() async {
    await Future.delayed(Duration(seconds: 3));
    Get.offNamed('/login');
  }
}
