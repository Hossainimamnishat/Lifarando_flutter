import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class AuthController extends GetxController {
  final RxBool isLoading = false.obs;

  void loginAsGuest() {
    // Navigate to home as guest
    Get.offAllNamed(Routes.HOME);
  }

  void navigateToCreateAccount() {
    // TODO: Navigate to create account page when implemented
    Get.snackbar(
      'Coming Soon',
      'Create account feature will be available soon',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void navigateToLogin() {
    // TODO: Navigate to login details page when implemented
    Get.snackbar(
      'Coming Soon',
      'Login feature will be available soon',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}

