import 'package:get/get.dart';

class ProfileController extends GetxController {
  final RxString userName = 'John Doe'.obs;
  final RxString userEmail = 'john.doe@example.com'.obs;
  final RxString userPhone = '+49 123 456 7890'.obs;
  final RxString userAddress = 'Berlin, Germany'.obs;
}

