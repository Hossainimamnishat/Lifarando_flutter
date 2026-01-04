import 'package:get/get.dart';

class ProfileController extends GetxController {
  final RxString userName = 'Hossain Imam Nishat'.obs;
  final RxString userEmail = 'imam.nishat@example.com'.obs;
  final RxString userPhone = '+49 123 456 7890'.obs;
  final RxString userAddress = 'Munich, Germany'.obs;
}

