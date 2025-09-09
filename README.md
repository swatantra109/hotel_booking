# XYZ Hotel Booking App

A comprehensive Flutter application for hotel booking with modern UI/UX, loyalty programs, and complete user management.

## Features

### 🔐 Authentication
- Email and password sign-in
- Mobile number with OTP verification
- Face ID authentication support
- Secure user session management

### 🏨 Hotel Booking
- **Hotel Listings**: Browse hotels with real-time availability
- **Smart Filters**: Filter by amenities (WiFi, Breakfast, Parking, Gym, Pool, Spa, Pet-friendly)
- **Hotel Categories**: LUXE, HIP, SOLID, CHARMING, BASIC, CRASHPAD, HIGHROLLER
- **Price Comparison**: Compare prices with competitors (Booking.com, MakeMyTrip, Goibibo, Agoda)
- **City Selection**: Choose from 10+ major cities
- **Date Selection**: Tonight bookings or calendar selection
- **Perks & Deals**: Special offers and limited-time discounts

### 💎 Hotel Categories
- **LUXE**: Premium luxury hotels
- **HIP**: Modern boutique hotels  
- **SOLID**: Reliable mid-range hotels
- **CHARMING**: Heritage and unique properties
- **BASIC**: Budget-friendly accommodations
- **CRASHPAD**: Backpacker hostels
- **HIGHROLLER**: Elite luxury properties

### ⭐ User Experience
- **Favorites**: Save preferred hotels
- **Booking Management**: Current and previous bookings
- **Loyalty Program**: Earn points and redeem rewards
- **Customer Support**: Live chat, FAQ, contact options
- **Wallet Integration**: Payment management
- **Referral Program**: Invite friends and earn rewards

### 📱 Modern UI/UX
- Material Design 3 with custom theme
- Smooth animations and transitions
- Responsive design for all screen sizes
- Intuitive navigation with bottom tabs

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── models/                   # Data models
│   └── hotel.dart           # Hotel, User, Booking models
├── screens/                  # UI screens
│   ├── auth/                # Authentication screens
│   ├── home/                # Main app tabs
│   ├── hotel/               # Hotel details
│   ├── profile/             # User profile
│   └── booking/             # Booking flow
├── services/                 # Business logic
│   ├── auth_service.dart    # Authentication service
│   └── hotel_service.dart   # Hotel data service
├── widgets/                  # Reusable components
│   ├── hotel_card.dart      # Hotel listing card
│   └── filter_bottom_sheet.dart # Filtering UI
└── utils/                    # Utilities
    └── app_theme.dart       # App theming
```

## Key Features Implementation

### Hotel Price Comparison
The app shows competitive pricing with a "Why Book with us" section:
- XYZ Brand (Best Price)
- Booking.com comparison
- MakeMyTriip comparison  
- Goibibo comparison
- Agoda comparison

### Loyalty Program
- **Points System**: Earn points for bookings, reviews, referrals
- **Tier Levels**: Silver, Gold, Platinum membership
- **Rewards**: Free nights, discounts, airport lounge access, spa vouchers
- **Achievement Tracking**: Stay nights, cities visited, countries explored

### Smart Filtering & Sorting
- **Sort Options**: Recommended, Price (Low to High/High to Low), Highest Rated, Best Discount
- **Amenity Filters**: WiFi, Breakfast, Parking, Gym, Pool, Pets, Spa
- **Real-time Updates**: Instant filtering without page reload

### Booking Management
- **Current Bookings**: Upcoming reservations with modification options
- **Booking History**: Past stays with review and re-booking options
- **Status Tracking**: Pending, Confirmed, Cancelled, Completed
- **Guest Information**: Secure storage of guest details

## Getting Started

### Prerequisites
- Flutter SDK (>=3.10.0)
- Dart SDK (>=3.0.0)
- Android Studio / VS Code
- iOS Simulator / Android Emulator

### Installation

1. **Clone the repository**
```bash
git clone https://github.com/swatantra109/hotel_booking.git
cd hotel_booking
```

2. **Install dependencies**
```bash
flutter pub get
```

3. **Run the app**
```bash
flutter run
```

## Dependencies

```yaml
dependencies:
  flutter: sdk: flutter
  cupertino_icons: ^1.0.6
  http: ^1.1.0                    # API calls
  shared_preferences: ^2.2.2      # Local storage
  provider: ^6.1.1                # State management
  intl: ^0.19.0                   # Internationalization
  image_picker: ^1.0.4            # Image selection
  local_auth: ^2.1.7              # Face ID/Fingerprint
  url_launcher: ^6.2.1            # External links
  cached_network_image: ^3.3.0    # Image caching
  carousel_slider: ^4.2.1         # Image carousel
  flutter_rating_bar: ^4.0.1      # Rating display
  date_picker_timeline: ^1.2.6    # Date selection
  flutter_staggered_grid_view: ^0.7.0 # Grid layouts
```

## API Integration (Planned)

### Hotel APIs
- Real-time hotel availability
- Pricing and room details
- Booking confirmation
- Cancellation management

### Payment Gateway
- Credit/Debit card processing
- UPI payments
- Digital wallet integration
- International payment support

### Competitor Price API
- Booking.com price comparison
- MakeMyTrip integration
- Goibibo price fetching
- Agoda rate comparison

## Backend Requirements

### User Management
- User authentication and authorization
- Profile management
- Loyalty point tracking
- Booking history storage

### Hotel Management
- Hotel inventory management
- Real-time availability updates
- Pricing and discount management
- Review and rating system

### Booking Engine
- Reservation processing
- Payment handling
- Confirmation and notification
- Cancellation and modification

## Security Features

- **Data Encryption**: All sensitive data encrypted
- **Secure Authentication**: JWT tokens with refresh mechanism
- **PCI Compliance**: Payment data security standards
- **Privacy Protection**: GDPR compliant data handling

## Performance Optimizations

- **Image Caching**: Efficient image loading and caching
- **Lazy Loading**: Hotels loaded on demand
- **State Management**: Efficient app state handling
- **Network Optimization**: Minimal API calls with caching

## Testing

```bash
# Run unit tests
flutter test

# Run integration tests
flutter test integration_test/

# Generate test coverage
flutter test --coverage
```

## Building for Production

### Android
```bash
flutter build apk --release
flutter build appbundle --release
```

### iOS
```bash
flutter build ios --release
```

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support

For support and questions:
- 📧 Email: support@xyzhotel.com
- 📞 Phone: +1-800-XYZ-HOTEL
- 💬 Live Chat: Available 24/7 in the app

## Roadmap

- [ ] Real API integration
- [ ] Push notifications
- [ ] Offline mode support
- [ ] AR hotel room preview
- [ ] Voice search
- [ ] Multi-language support
- [ ] Dark mode theme
- [ ] Apple Pay / Google Pay integration

---

**XYZ Hotel Booking** - Your perfect stay awaits! 🏨✨