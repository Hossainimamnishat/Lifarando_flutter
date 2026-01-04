import 'package:get/get.dart';
import '../../../data/models/restaurant_model.dart';

class HomeController extends GetxController {
  final RxList<Restaurant> restaurants = <Restaurant>[].obs;
  final RxList<Restaurant> filteredRestaurants = <Restaurant>[].obs;
  final RxList<String> cuisineFilters = <String>[].obs;
  final RxString selectedFilter = 'All'.obs;
  final RxBool isLoading = false.obs;
  final RxInt currentIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadRestaurants();
  }

  void loadRestaurants() {
    isLoading.value = true;

    // Mock data - In real app, this would be an API call
    Future.delayed(const Duration(seconds: 1), () {
      restaurants.value = [
        Restaurant(
          id: '1',
          name: 'Pizza Paradise',
          description: 'Authentic Italian pizza with fresh ingredients',
          imageUrl: 'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=500',
          rating: 4.5,
          reviewCount: 250,
          cuisine: 'Italian',
          deliveryTime: 30,
          deliveryFee: 2.99,
          minimumOrder: 15.0,
          isOpen: true,
          address: '123 Main St, Berlin',
          tags: ['Pizza', 'Italian', 'Pasta'],
          distance: 1.2,
        ),
        Restaurant(
          id: '2',
          name: 'Burger House',
          description: 'Juicy burgers and crispy fries',
          imageUrl: 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=500',
          rating: 4.3,
          reviewCount: 189,
          cuisine: 'American',
          deliveryTime: 25,
          deliveryFee: 1.99,
          minimumOrder: 10.0,
          isOpen: true,
          address: '456 Oak Ave, Berlin',
          tags: ['Burgers', 'Fast Food', 'American'],
          distance: 0.8,
        ),
        Restaurant(
          id: '3',
          name: 'Sushi Master',
          description: 'Fresh sushi and Japanese cuisine',
          imageUrl: 'https://images.unsplash.com/photo-1579584425555-c3ce17fd4351?w=500',
          rating: 4.7,
          reviewCount: 320,
          cuisine: 'Japanese',
          deliveryTime: 35,
          deliveryFee: 3.49,
          minimumOrder: 20.0,
          isOpen: true,
          address: '789 Park Rd, Berlin',
          tags: ['Sushi', 'Japanese', 'Asian'],
          distance: 2.1,
        ),
        Restaurant(
          id: '4',
          name: 'Thai Spice',
          description: 'Authentic Thai flavors and curry',
          imageUrl: 'https://images.unsplash.com/photo-1559314809-0d155014e29e?w=500',
          rating: 4.4,
          reviewCount: 156,
          cuisine: 'Thai',
          deliveryTime: 40,
          deliveryFee: 2.49,
          minimumOrder: 15.0,
          isOpen: true,
          address: '321 River St, Berlin',
          tags: ['Thai', 'Asian', 'Spicy'],
          distance: 1.5,
        ),
        Restaurant(
          id: '5',
          name: 'Mediterranean Grill',
          description: 'Healthy Mediterranean dishes',
          imageUrl: 'https://images.unsplash.com/photo-1544025162-d76694265947?w=500',
          rating: 4.6,
          reviewCount: 278,
          cuisine: 'Mediterranean',
          deliveryTime: 30,
          deliveryFee: 2.99,
          minimumOrder: 12.0,
          isOpen: true,
          address: '654 Beach Blvd, Berlin',
          tags: ['Mediterranean', 'Healthy', 'Salads'],
          distance: 1.8,
        ),
      ];

      filteredRestaurants.value = restaurants;
      cuisineFilters.value = ['All', 'Italian', 'American', 'Japanese', 'Thai', 'Mediterranean'];
      isLoading.value = false;
    });
  }

  void filterByCuisine(String filter) {
    selectedFilter.value = filter;
    if (filter == 'All') {
      filteredRestaurants.value = restaurants;
    } else {
      filteredRestaurants.value = restaurants
          .where((restaurant) => restaurant.cuisine == filter)
          .toList();
    }
  }

  void changeTab(int index) {
    currentIndex.value = index;
  }
}

