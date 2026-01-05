import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final RxBool isLoading = false.obs;
  final RxBool agreedToTerms = true.obs;
  final RxBool obscurePassword = true.obs;

  // Default credentials for login
  static const String defaultEmail = 'hossain.nishat@example.com';
  static const String defaultPassword = 'nishat123';

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
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

  void login() {
    // Validate inputs
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter both email and password',
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

    // Check credentials
    if (emailController.text.toLowerCase() == defaultEmail.toLowerCase() &&
        passwordController.text == defaultPassword) {
      // Successful login
      isLoading.value = true;

      // Simulate login delay
      Future.delayed(const Duration(seconds: 1), () {
        isLoading.value = false;

        Get.snackbar(
          'Success',
          'Welcome back, Hossain Imam Nishat!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );

        // Navigate to home
        Get.offAllNamed('/home');
      });
    } else {
      // Invalid credentials
      Get.snackbar(
        'Login Failed',
        'Invalid email or password. Try:\nEmail: $defaultEmail\nPassword: $defaultPassword',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 4),
      );
    }
  }

  void showDefaultCredentials() {
    Get.dialog(
      AlertDialog(
        title: const Text('Default Login Credentials'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Use these credentials to login:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text('Email:'),
            SelectableText(
              defaultEmail,
              style: const TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            const Text('Password:'),
            SelectableText(
              defaultPassword,
              style: const TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Auto-fill credentials
              emailController.text = defaultEmail;
              passwordController.text = defaultPassword;
              Get.back();
            },
            child: const Text('Auto-fill'),
          ),
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Close'),
          ),
        ],
      ),
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

