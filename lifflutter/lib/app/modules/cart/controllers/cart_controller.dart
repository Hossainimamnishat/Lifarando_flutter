import 'package:get/get.dart';
import '../../../data/models/cart_item_model.dart';
import '../../../data/models/food_item_model.dart';
import 'package:get_storage/get_storage.dart';

class CartController extends GetxController {
  final storage = GetStorage();
  final RxList<CartItem> cartItems = <CartItem>[].obs;
  final RxDouble subtotal = 0.0.obs;
  final RxDouble deliveryFee = 2.99.obs;
  final RxDouble total = 0.0.obs;
  final RxString restaurantId = ''.obs;
  final RxString restaurantName = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadCart();
  }

  void loadCart() {
    final cartData = storage.read('cart');
    if (cartData != null) {
      final List<dynamic> items = cartData['items'] ?? [];
      cartItems.value = items.map((item) => CartItem.fromJson(item)).toList();
      restaurantId.value = cartData['restaurantId'] ?? '';
      restaurantName.value = cartData['restaurantName'] ?? '';
      calculateTotal();
    }
  }

  void addItem(FoodItem foodItem, String resId, String resName) {
    // If cart is from different restaurant, clear it
    if (restaurantId.value.isNotEmpty && restaurantId.value != resId) {
      Get.defaultDialog(
        title: 'Different Restaurant',
        middleText: 'Your cart contains items from ${restaurantName.value}. Do you want to clear the cart?',
        textConfirm: 'Yes',
        textCancel: 'No',
        onConfirm: () {
          clearCart();
          _addItemToCart(foodItem, resId, resName);
          Get.back();
        },
      );
      return;
    }

    _addItemToCart(foodItem, resId, resName);
  }

  void _addItemToCart(FoodItem foodItem, String resId, String resName) {
    restaurantId.value = resId;
    restaurantName.value = resName;

    final existingIndex = cartItems.indexWhere((item) => item.foodItem.id == foodItem.id);

    if (existingIndex != -1) {
      cartItems[existingIndex].quantity++;
      cartItems.refresh();
    } else {
      cartItems.add(CartItem(foodItem: foodItem, quantity: 1));
    }

    calculateTotal();
    saveCart();
    Get.snackbar(
      'Added to Cart',
      '${foodItem.name} has been added to your cart',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }

  void removeItem(String foodItemId) {
    cartItems.removeWhere((item) => item.foodItem.id == foodItemId);
    if (cartItems.isEmpty) {
      restaurantId.value = '';
      restaurantName.value = '';
    }
    calculateTotal();
    saveCart();
  }

  void updateQuantity(String foodItemId, int quantity) {
    final index = cartItems.indexWhere((item) => item.foodItem.id == foodItemId);
    if (index != -1) {
      if (quantity <= 0) {
        removeItem(foodItemId);
      } else {
        cartItems[index].quantity = quantity;
        cartItems.refresh();
        calculateTotal();
        saveCart();
      }
    }
  }

  void clearCart() {
    cartItems.clear();
    restaurantId.value = '';
    restaurantName.value = '';
    calculateTotal();
    storage.remove('cart');
  }

  void calculateTotal() {
    subtotal.value = cartItems.fold(0, (sum, item) => sum + item.totalPrice);
    total.value = subtotal.value + deliveryFee.value;
  }

  void saveCart() {
    storage.write('cart', {
      'items': cartItems.map((item) => item.toJson()).toList(),
      'restaurantId': restaurantId.value,
      'restaurantName': restaurantName.value,
    });
  }

  int get itemCount => cartItems.fold(0, (sum, item) => sum + item.quantity);
}

