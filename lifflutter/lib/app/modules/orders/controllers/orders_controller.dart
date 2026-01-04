import 'package:get/get.dart';
import '../../../data/models/order_model.dart';
import 'package:get_storage/get_storage.dart';

class OrdersController extends GetxController {
  final storage = GetStorage();
  final RxList<Order> orders = <Order>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadOrders();
  }

  void loadOrders() {
    isLoading.value = true;
    
    // Mock data - In real app, this would be an API call
    Future.delayed(const Duration(seconds: 1), () {
      final savedOrders = storage.read('orders');
      if (savedOrders != null) {
        orders.value = (savedOrders as List)
            .map((order) => Order.fromJson(order))
            .toList();
      }
      isLoading.value = false;
    });
  }

  void addOrder(Order order) {
    orders.insert(0, order);
    saveOrders();
  }

  void saveOrders() {
    storage.write('orders', orders.map((order) => order.toJson()).toList());
  }
}

