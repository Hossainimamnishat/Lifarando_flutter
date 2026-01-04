import 'package:get/get.dart';
import '../../../data/models/restaurant_model.dart';
import '../../../data/models/food_item_model.dart';

class RestaurantController extends GetxController {
  late Restaurant restaurant;
  final RxList<FoodItem> menuItems = <FoodItem>[].obs;
  final RxList<FoodItem> filteredMenuItems = <FoodItem>[].obs;
  final RxString selectedCategory = 'All'.obs;
  final RxList<String> categories = <String>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    restaurant = Get.arguments as Restaurant;
    loadMenu();
  }

  void loadMenu() {
    isLoading.value = true;

    // Mock data - In real app, this would be an API call
    Future.delayed(const Duration(milliseconds: 800), () {
      menuItems.value = [
        FoodItem(
          id: '1',
          restaurantId: restaurant.id,
          name: 'Margherita Pizza',
          description: 'Classic pizza with tomato sauce, mozzarella, and basil',
          price: 8.99,
          imageUrl: 'https://images.unsplash.com/photo-1574071318508-1cdbab80d002?w=500',
          category: 'Pizza',
          isVegetarian: true,
          isPopular: true,
          calories: 800,
        ),
        FoodItem(
          id: '2',
          restaurantId: restaurant.id,
          name: 'Pepperoni Pizza',
          description: 'Pizza with tomato sauce, mozzarella, and pepperoni',
          price: 10.99,
          imageUrl: 'https://images.unsplash.com/photo-1628840042765-356cda07504e?w=500',
          category: 'Pizza',
          isPopular: true,
          calories: 950,
        ),
        FoodItem(
          id: '3',
          restaurantId: restaurant.id,
          name: 'Caesar Salad',
          description: 'Fresh romaine lettuce with Caesar dressing and croutons',
          price: 6.99,
          imageUrl: 'https://images.unsplash.com/photo-1546793665-c74683f339c1?w=500',
          category: 'Salads',
          isVegetarian: true,
          calories: 350,
        ),
        FoodItem(
          id: '4',
          restaurantId: restaurant.id,
          name: 'Spaghetti Carbonara',
          description: 'Classic Italian pasta with eggs, cheese, and bacon',
          price: 11.99,
          imageUrl: 'https://images.unsplash.com/photo-1612874742237-6526221588e3?w=500',
          category: 'Pasta',
          calories: 720,
        ),
        FoodItem(
          id: '5',
          restaurantId: restaurant.id,
          name: 'Tiramisu',
          description: 'Italian coffee-flavored dessert',
          price: 5.99,
          imageUrl: 'https://images.unsplash.com/photo-1571877227200-a0d98ea607e9?w=500',
          category: 'Desserts',
          isVegetarian: true,
          calories: 450,
        ),
        FoodItem(
          id: '6',
          restaurantId: restaurant.id,
          name: 'Garlic Bread',
          description: 'Toasted bread with garlic butter',
          price: 3.99,
          imageUrl: 'https://images.unsplash.com/photo-1573140401552-388e5a2f8b29?w=500',
          category: 'Sides',
          isVegetarian: true,
          calories: 280,
        ),
      ];

      categories.value = ['All', 'Pizza', 'Pasta', 'Salads', 'Sides', 'Desserts'];
      filteredMenuItems.value = menuItems;
      isLoading.value = false;
    });
  }

  void filterByCategory(String category) {
    selectedCategory.value = category;
    if (category == 'All') {
      filteredMenuItems.value = menuItems;
    } else {
      filteredMenuItems.value = menuItems
          .where((item) => item.category == category)
          .toList();
    }
  }
}

