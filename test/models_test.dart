import 'package:flutter_test/flutter_test.dart';
import 'package:xyz_hotel_booking/models/hotel.dart';

void main() {
  group('Hotel Model Tests', () {
    test('Hotel model should be created correctly', () {
      final hotel = Hotel(
        id: '1',
        name: 'Test Hotel',
        area: 'Test Area',
        city: 'Test City',
        rating: 4.5,
        reviewCount: 100,
        originalPrice: 1000.0,
        discountedPrice: 800.0,
        discountPercentage: 20,
        images: ['test_image.jpg'],
        perks: ['WiFi', 'Breakfast'],
        category: HotelCategory.SOLID,
        amenities: {'wifi': true, 'breakfast': true},
        description: 'Test hotel description',
        checkInTime: '14:00',
        checkOutTime: '11:00',
        isAvailable: true,
      );

      expect(hotel.id, '1');
      expect(hotel.name, 'Test Hotel');
      expect(hotel.rating, 4.5);
      expect(hotel.discountPercentage, 20);
      expect(hotel.category, HotelCategory.SOLID);
      expect(hotel.isAvailable, true);
    });

    test('Hotel model should convert to/from JSON correctly', () {
      final hotel = Hotel(
        id: '1',
        name: 'Test Hotel',
        area: 'Test Area',
        city: 'Test City',
        rating: 4.5,
        reviewCount: 100,
        originalPrice: 1000.0,
        discountedPrice: 800.0,
        discountPercentage: 20,
        images: ['test_image.jpg'],
        perks: ['WiFi', 'Breakfast'],
        category: HotelCategory.SOLID,
        amenities: {'wifi': true, 'breakfast': true},
        description: 'Test hotel description',
        checkInTime: '14:00',
        checkOutTime: '11:00',
        isAvailable: true,
      );

      final json = hotel.toJson();
      final hotelFromJson = Hotel.fromJson(json);

      expect(hotelFromJson.id, hotel.id);
      expect(hotelFromJson.name, hotel.name);
      expect(hotelFromJson.rating, hotel.rating);
      expect(hotelFromJson.category, hotel.category);
    });

    test('HotelCategory extension should return correct display name', () {
      expect(HotelCategory.LUXE.displayName, 'Luxe');
      expect(HotelCategory.HIP.displayName, 'Hip');
      expect(HotelCategory.SOLID.displayName, 'Solid');
      expect(HotelCategory.CHARMING.displayName, 'Charming');
      expect(HotelCategory.BASIC.displayName, 'Basic');
      expect(HotelCategory.CRASHPAD.displayName, 'Crashpad');
      expect(HotelCategory.HIGHROLLER.displayName, 'High Roller');
    });
  });

  group('User Model Tests', () {
    test('User model should be created correctly', () {
      final user = User(
        id: '1',
        name: 'Test User',
        email: 'test@example.com',
        phone: '+1234567890',
        profileImage: 'profile.jpg',
        memberSince: DateTime(2023, 1, 1),
        loyaltyPoints: 1000,
        stayNights: 5,
        citiesVisited: 3,
        countriesVisited: 2,
        favoriteHotels: ['hotel1', 'hotel2'],
        preferences: {'currency': 'USD'},
      );

      expect(user.id, '1');
      expect(user.name, 'Test User');
      expect(user.email, 'test@example.com');
      expect(user.loyaltyPoints, 1000);
      expect(user.stayNights, 5);
    });
  });

  group('Booking Model Tests', () {
    test('Booking model should be created correctly', () {
      final booking = Booking(
        id: '1',
        hotelId: 'hotel1',
        userId: 'user1',
        checkInDate: DateTime(2024, 1, 15),
        checkOutDate: DateTime(2024, 1, 17),
        rooms: 1,
        guests: 2,
        totalAmount: 5000.0,
        status: BookingStatus.confirmed,
        bookingDate: DateTime(2024, 1, 10),
        guestInfo: {'name': 'Test Guest'},
      );

      expect(booking.id, '1');
      expect(booking.hotelId, 'hotel1');
      expect(booking.rooms, 1);
      expect(booking.guests, 2);
      expect(booking.status, BookingStatus.confirmed);
    });
  });
}