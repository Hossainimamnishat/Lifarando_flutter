import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../../../data/constants/countries.dart';

class AuthController extends GetxController {
  final RxBool isLoading = false.obs;
  final Rx<Country> selectedCountry = Countries.euCountries.first.obs;

  void loginAsGuest() {
    // Navigate to home as guest
    Get.offAllNamed(Routes.HOME);
  }

  void navigateToCreateAccount() {
    // Navigate to login/create account page
    Get.toNamed(Routes.LOGIN);
  }

  void navigateToLogin() {
    // Navigate to login/create account page
    Get.toNamed(Routes.LOGIN);
  }

  void selectCountry(Country country) {
    selectedCountry.value = country;
    Get.snackbar(
      'Country Changed',
      'Selected country: ${country.name}',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }
}

