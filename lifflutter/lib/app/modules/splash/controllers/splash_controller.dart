import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _navigateToAuth();
  }

  void _navigateToAuth() {
    // Reduced delay for faster startup
    Future.delayed(const Duration(milliseconds: 1500), () {
      Get.offNamed(Routes.AUTH);
    });
  }
}

