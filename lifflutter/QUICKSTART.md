# Quick Start Guide - LiFFlutter

## 🚀 Running the App

### Option 1: Windows
```bash
flutter run -d windows
```

### Option 2: Android Emulator
1. Start your Android emulator
2. Run:
```bash
flutter run
```

### Option 3: Chrome (Web)
```bash
flutter run -d chrome
```

## 📱 App Navigation Flow

```
Splash Screen (2 seconds)
    ↓
Home Screen
    ├── Browse Restaurants
    ├── Filter by Cuisine
    ├── View Restaurant Details
    │       ├── Browse Menu
    │       ├── Add to Cart
    │       └── View Item Details
    ├── Shopping Cart
    │       ├── Manage Items
    │       └── Proceed to Checkout
    │               ├── Set Address
    │               ├── Choose Payment
    │               └── Place Order
    ├── Search
    │       └── Find Restaurants
    ├── Orders
    │       └── View Order History
    └── Profile
            └── Manage Settings
```

## 🎯 Key Features to Test

### 1. Browse Restaurants
- Open app → See list of restaurants
- Tap cuisine filters (Italian, American, etc.)
- View restaurant ratings and delivery info

### 2. Restaurant Details
- Tap any restaurant card
- Browse menu categories
- Tap food item for details
- Add items to cart

### 3. Shopping Cart
- Tap cart icon (top right)
- Increase/decrease quantities
- Remove items
- See price calculations
- Proceed to checkout

### 4. Checkout
- Enter delivery address
- Select payment method
- Add delivery instructions
- Place order

### 5. Order History
- Go to Orders tab
- View past orders
- Tap order for details

### 6. Profile
- Go to Profile tab
- View user information
- Access settings

## 🔧 Troubleshooting

### Build Issues
```bash
flutter clean
flutter pub get
flutter run
```

### Import Errors
The IDE might show red lines initially. Run:
```bash
flutter pub get
```
Then restart your IDE.

### Platform-Specific Issues

**Windows:**
- Ensure Windows development is enabled:
```bash
flutter config --enable-windows-desktop
```

**Android:**
- Ensure an emulator is running or device is connected:
```bash
flutter devices
```

**Web:**
- Ensure web development is enabled:
```bash
flutter config --enable-web
```

## 📦 Mock Data

The app uses mock data for demonstration:

### Sample Restaurants:
1. **Pizza Paradise** - Italian cuisine
2. **Burger House** - American cuisine
3. **Sushi Master** - Japanese cuisine
4. **Thai Spice** - Thai cuisine
5. **Mediterranean Grill** - Mediterranean cuisine

### Sample Menu Items:
- Margherita Pizza - €8.99
- Pepperoni Pizza - €10.99
- Caesar Salad - €6.99
- Spaghetti Carbonara - €11.99
- Tiramisu - €5.99
- Garlic Bread - €3.99

## 🎨 App Theme

**Primary Color:** Orange (#FF8000) - Lieferando style
**UI Style:** Modern, clean, card-based design

## 💾 Data Persistence

The app uses **GetStorage** to save:
- Shopping cart items
- Order history
- User preferences

Data persists across app restarts!

## 🔄 State Management

Built with **GetX**:
- Reactive state updates
- Clean separation of concerns
- Easy navigation
- Dependency injection

## 📝 Code Examples

### Adding Item to Cart
```dart
final cartController = Get.find<CartController>();
cartController.addItem(foodItem, restaurantId, restaurantName);
```

### Navigation
```dart
Get.toNamed('/cart');
Get.to(() => RestaurantView());
Get.back();
```

### Reactive State
```dart
final RxInt count = 0.obs;  // Observable
Obx(() => Text('$count'));  // Auto-updates
count.value++;              // Triggers UI update
```

## 🎯 Testing Checklist

- [ ] App launches successfully
- [ ] Splash screen appears
- [ ] Home screen loads restaurants
- [ ] Filter restaurants by cuisine
- [ ] Open restaurant details
- [ ] Add items to cart
- [ ] Cart badge shows item count
- [ ] View cart
- [ ] Update quantities
- [ ] Proceed to checkout
- [ ] Place order
- [ ] View order in history
- [ ] Navigate between tabs
- [ ] Search functionality
- [ ] Profile settings

## 🚀 Performance Tips

1. **Images are cached** - Uses cached_network_image
2. **Lazy loading** - Controllers loaded on demand
3. **Efficient state** - Only rebuilds affected widgets
4. **Local storage** - Fast GetStorage

## 📱 Screenshots

The app features:
- Restaurant cards with images
- Ratings and reviews
- Delivery time and fees
- Shopping cart with controls
- Order tracking
- User profile

## 🌟 Next Steps

1. **Backend Integration**
   - Connect to real API
   - User authentication
   - Real payment processing

2. **Enhanced Features**
   - Google Maps for location
   - Push notifications
   - Real-time order tracking
   - Restaurant favorites
   - Reviews and ratings

3. **Production Ready**
   - Error handling
   - Loading states
   - Empty states
   - Network connectivity checks
   - Analytics integration

## 📞 Support

For issues or questions:
1. Check Flutter doctor: `flutter doctor`
2. Clean and rebuild: `flutter clean && flutter pub get`
3. Check Flutter version: `flutter --version`

## ✅ Verification

App is working if you can:
1. ✅ See splash screen with orange logo
2. ✅ Browse restaurants on home screen
3. ✅ Filter by cuisine types
4. ✅ Open restaurant and view menu
5. ✅ Add items to cart
6. ✅ See cart badge with item count
7. ✅ Checkout and place order
8. ✅ View order in Orders tab

---

**Happy Coding! 🎉**

Built with ❤️ using Flutter + GetX

