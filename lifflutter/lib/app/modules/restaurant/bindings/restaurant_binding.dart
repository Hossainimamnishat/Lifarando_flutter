import 'package:get/get.dart';
import '../controllers/restaurant_controller.dart';
import '../../cart/controllers/cart_controller.dart';

class RestaurantBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RestaurantController>(() => RestaurantController());
    Get.lazyPut<CartController>(() => CartController());
  }
}

