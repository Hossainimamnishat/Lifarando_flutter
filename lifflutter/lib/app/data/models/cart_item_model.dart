import 'food_item_model.dart';

class CartItem {
  final FoodItem foodItem;
  int quantity;
  final String? specialInstructions;

  CartItem({
    required this.foodItem,
    this.quantity = 1,
    this.specialInstructions,
  });

  double get totalPrice => foodItem.price * quantity;

  Map<String, dynamic> toJson() {
    return {
      'foodItem': foodItem.toJson(),
      'quantity': quantity,
      'specialInstructions': specialInstructions,
    };
  }

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      foodItem: FoodItem.fromJson(json['foodItem']),
      quantity: json['quantity'] ?? 1,
      specialInstructions: json['specialInstructions'],
    );
  }
}

