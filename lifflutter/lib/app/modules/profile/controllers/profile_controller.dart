import 'package:get/get.dart';

class ProfileController extends GetxController {
  final RxString userName = 'Hossain Imam Nishat'.obs;
  final RxString userEmail = 'imam.nishat@example.com'.obs;
  final RxString userPhone = '+49 123 456 7890'.obs;
  final RxString userAddress = 'Munich, Germany'.obs;

  // Logout method
  void logout() {
    // Clear user data (you can add more clearing logic here)
    userName.value = '';
    userEmail.value = '';
    userPhone.value = '';
    userAddress.value = '';

    // Show success message
    Get.snackbar(
      'Logged Out',
      'You have been logged out successfully',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );

    // Navigate to home and clear navigation stack
    Get.offAllNamed('/home');
  }
}

