import 'package:get/get.dart';
import '../../../data/models/restaurant_model.dart';

class SearchPageController extends GetxController {
  final RxList<Restaurant> searchResults = <Restaurant>[].obs;
  final RxString searchQuery = ''.obs;
  final RxBool isSearching = false.obs;

  void search(String query) {
    searchQuery.value = query;
    if (query.isEmpty) {
      searchResults.clear();
      return;
    }

    isSearching.value = true;

    // Mock search - In real app, this would be an API call
    Future.delayed(const Duration(milliseconds: 500), () {
      // This would search through restaurants and food items
      searchResults.value = [];
      isSearching.value = false;
    });
  }
}

