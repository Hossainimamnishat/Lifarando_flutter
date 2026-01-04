import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../cart/controllers/cart_controller.dart';
import '../../orders/controllers/orders_controller.dart';
import '../../home/controllers/home_controller.dart';
import '../../../data/models/order_model.dart';

class CheckoutController extends GetxController {
  final cartController = Get.find<CartController>();
  final RxString deliveryAddress = 'Berlin, Germany'.obs;
  final RxString paymentMethod = 'Cash on Delivery'.obs;
  final RxString deliveryInstructions = ''.obs;
  final RxBool isProcessing = false.obs;

  void placeOrder() {
    if (cartController.cartItems.isEmpty) {
      Get.snackbar('Error', 'Your cart is empty');
      return;
    }

    isProcessing.value = true;

    // Mock order placement - In real app, this would be an API call
    Future.delayed(const Duration(seconds: 2), () {
      final order = Order(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        userId: 'user123',
        restaurantId: cartController.restaurantId.value,
        restaurantName: cartController.restaurantName.value,
        items: cartController.cartItems.toList(),
        subtotal: cartController.subtotal.value,
        deliveryFee: cartController.deliveryFee.value,
        total: cartController.total.value,
        status: 'pending',
        orderDate: DateTime.now(),
        deliveryAddress: deliveryAddress.value,
        estimatedDeliveryTime: '30-40 min',
      );

      // Save order
      try {
        final ordersController = Get.find<OrdersController>();
        ordersController.addOrder(order);
      } catch (e) {
        // OrdersController not initialized yet, that's fine
      }

      // Clear cart
      cartController.clearCart();

      isProcessing.value = false;

      // Show success dialog
      Get.defaultDialog(
        title: 'Order Placed Successfully!',
        middleText: 'Your order will be delivered in 30-40 minutes',
        textConfirm: 'View Orders',
        textCancel: 'Continue Shopping',
        confirmTextColor: Colors.white,
        onConfirm: () {
          Get.back();
          Get.offAllNamed('/home');
          Get.find<HomeController>().changeTab(2);
        },
        onCancel: () {
          Get.back();
          Get.offAllNamed('/home');
        },
      );
    });
  }

  void updateDeliveryAddress(String address) {
    deliveryAddress.value = address;
  }

  void updatePaymentMethod(String method) {
    paymentMethod.value = method;
  }

  void updateDeliveryInstructions(String instructions) {
    deliveryInstructions.value = instructions;
  }
}

