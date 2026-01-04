## Color Palette

- **Primary Orange** (`#FF8000`): Used for primary actions, main buttons, and key highlights.
- **Primary Dark** (`#E67300`): Used for pressed/disabled states and darker variants of primary elements.
- **Accent** (`#FFB84D`): Used for secondary actions, accent elements, and subtle highlights.
- **Background** (`#F5F5F5`): Used as the main app background color.
- **Text Primary** (`#2E3333`): Used for main body text and primary labels.
- **Text Secondary** (`#757575`): Used for secondary text, captions, and less prominent labels.*Home Screen** - Browse nearby restaurants with filters
-  **Search** - Find restaurants and dishes
-  **Restaurant Details** - View menu items with categories
-  **Shopping Cart** - Add items, manage quantities
-  **Checkout** - Place orders with delivery details
-  **Order History** - Track your past orders
-  **Profile** - Manage user settings

###  UI Features
- Clean, modern Lieferando-inspired design
- Orange theme (#FF8000)
- Responsive layouts
- Smooth animations and transitions
- Bottom navigation bar
- Image caching
- Shimmer loading effects

###  Architecture
- **GetX** - State management, routing, dependency injection
- **Get CLI** - Clean architecture pattern
- **MVVM** - Model-View-ViewModel pattern
- **GetStorage** - Local data persistence
- **Modular** - Feature-based module structure

## Project Structure

```
lib/
├── app/
│   ├── core/
│   │   └── theme/          # App theming (colors, theme)
│   ├── data/
│   │   └── models/         # Data models
│   ├── modules/
│   │   ├── splash/         # Splash screen
│   │   ├── home/           # Home screen with restaurant list
│   │   ├── restaurant/     # Restaurant details & menu
│   │   ├── cart/           # Shopping cart
│   │   ├── checkout/       # Order checkout
│   │   ├── orders/         # Order history
│   │   ├── search/         # Search functionality
│   │   └── profile/        # User profile
│   └── routes/             # App routing
└── main.dart              # App entry point
```

Each module follows the structure:
```
module/
├── bindings/      # Dependency injection
├── controllers/   # Business logic
└── views/         # UI screens
```

## Dependencies

```yaml
# State Management
get: ^4.6.6

# HTTP & API
http: ^1.2.0
dio: ^5.4.0

# Storage
get_storage: ^2.1.1

# UI Components
cached_network_image: ^3.3.1
flutter_rating_bar: ^4.0.1
shimmer: ^3.0.0

# Location
geolocator: ^11.0.0
geocoding: ^3.0.0
google_maps_flutter: ^2.5.3

# Icons
font_awesome_flutter: ^10.7.0

# Utils
intl: ^0.19.0
url_launcher: ^6.2.4
```

## Getting Started

### Prerequisites
- Flutter SDK (3.7.2 or higher)
- Dart SDK
- Android Studio / VS Code
- Android Emulator or iOS Simulator

### Installation

1. **Clone the repository**
```bash
cd C:\Users\hossa\AndroidStudioProjects\lifflutter
```

2. **Install dependencies**
```bash
flutter pub get
```

3. **Run the app**
```bash
flutter run
```

## Modules Overview

### 1. Splash Module
- App startup screen
- Auto-navigates to home after 2 seconds
- Displays app logo and name

### 2. Home Module
- Restaurant listing with images
- Cuisine filters (Italian, American, Japanese, etc.)
- Search bar
- Restaurant cards with ratings, delivery time, fees
- Bottom navigation
- Cart badge counter

### 3. Restaurant Module
- Restaurant header with image
- Menu categories
- Food items with details
- Add to cart functionality
- Item details bottom sheet
- Vegetarian/Vegan indicators
- Calorie information

### 4. Cart Module
- Item list with images
- Quantity controls (+/-)
- Item removal
- Price calculations
- Delivery fee
- Clear cart option
- Proceed to checkout

### 5. Checkout Module
- Delivery address selection
- Payment method (Cash, Card, PayPal)
- Delivery instructions
- Order summary
- Place order button
- Order confirmation

### 6. Orders Module
- Order history list
- Order status tracking
- Order details
- Date and time stamps
- Restaurant information

### 7. Search Module
- Search input field
- Popular searches
- Search results (to be implemented with API)

### 8. Profile Module
- User information
- Account settings
- Payment methods
- Addresses
- Notifications
- Help & Support
- Logout functionality

## Data Models

### Restaurant Model
- ID, name, description
- Images, rating, reviews
- Cuisine type
- Delivery time and fee
- Minimum order
- Address and location

### Food Item Model
- ID, name, description
- Price, image
- Category
- Dietary information (vegetarian, vegan)
- Allergens, calories

### Cart Item Model
- Food item reference
- Quantity
- Special instructions
- Total price calculation

### Order Model
- Order ID
- Restaurant details
- Items list
- Pricing breakdown
- Status tracking
- Delivery information

## State Management

Using **GetX** for:
- **Reactive State**: Observables with `.obs`
- **Controllers**: Business logic separation
- **Bindings**: Dependency injection
- **Navigation**: Named routes
- **Storage**: Persistent data

## Color Scheme

```text
- Primary Orange: `#FF8000`
- Primary Dark: `#E67300`
- Accent: `#FFB84D`
- Background: `#F5F5F5`
- Text Primary: `#2E3333`
- Text Secondary: `#757575`
```

## Next Steps / TODO

- [ ] Integrate real API backend
- [ ] Add authentication (login/register)
- [ ] Implement real-time order tracking
- [ ] Add Google Maps integration for delivery
- [ ] Implement push notifications
- [ ] Add favorites functionality
- [ ] Add restaurant reviews and ratings
- [ ] Implement real payment gateway
- [ ] Add filters (price, rating, delivery time)
- [ ] Add promotional codes/coupons
- [ ] Multi-language support
- [ ] Dark mode theme

## Testing

Run tests:
```bash
flutter test
```

## Build

### Android
```bash
flutter build apk --release
```

### iOS
```bash
flutter build ios --release
```

## Contributing

This is a demo project built for learning purposes.

## License

This project is created for educational purposes.

## Acknowledgments

- Inspired by Lieferando food delivery app
- Built with Flutter & GetX
- Uses Unsplash for demo images

---

**Note**: This is a clone/demo project with mock data. For production use, integrate with a real backend API and implement proper authentication, security, and payment systems.
