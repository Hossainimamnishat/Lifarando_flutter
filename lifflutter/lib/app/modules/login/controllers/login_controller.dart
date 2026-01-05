import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final RxBool isLoading = false.obs;
  final RxBool agreedToTerms = true.obs;

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }

  void continueWithGoogle() {
    Get.snackbar(
      'Google Sign In',
      'Google authentication coming soon',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.white,
      colorText: Colors.black87,
    );
  }

  void continueWithFacebook() {
    Get.snackbar(
      'Facebook Sign In',
      'Facebook authentication coming soon',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.white,
      colorText: Colors.black87,
    );
  }

  void getVerificationCode() {
    if (emailController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter your email address',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (!GetUtils.isEmail(emailController.text)) {
      Get.snackbar(
        'Error',
        'Please enter a valid email address',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    // TODO: Implement verification code logic
    Get.snackbar(
      'Verification Code',
      'Verification code sent to ${emailController.text}',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  void openTermsAndConditions() {
    Get.snackbar(
      'Terms and Conditions',
      'Terms and Conditions page coming soon',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void openPrivacyStatement() {
    Get.snackbar(
      'Privacy Statement',
      'Privacy Statement page coming soon',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void openCookiePolicy() {
    Get.snackbar(
      'Cookie Policy',
      'Cookie Policy page coming soon',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}

