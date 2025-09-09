import 'package:flutter_test/flutter_test.dart';
import 'package:xyz_hotel_booking/services/hotel_service.dart';
import 'package:xyz_hotel_booking/models/hotel.dart';

void main() {
  group('HotelService Tests', () {
    late HotelService hotelService;

    setUp(() {
      hotelService = HotelService();
    });

    test('Initial state should be correct', () {
      expect(hotelService.selectedCity, 'New Delhi');
      expect(hotelService.hotels.isNotEmpty, true);
      expect(hotelService.favoriteHotels.isEmpty, true);
      expect(hotelService.sortBy, 'recommended');
    });

    test('Should set selected city correctly', () {
      hotelService.setSelectedCity('Mumbai');
      expect(hotelService.selectedCity, 'Mumbai');
    });

    test('Should set selected date correctly', () {
      final testDate = DateTime(2024, 6, 15);
      hotelService.setSelectedDate(testDate);
      expect(hotelService.selectedDate, testDate);
    });

    test('Should update filters correctly', () {
      hotelService.updateFilter('wifi', true);
      expect(hotelService.filters['wifi'], true);
      
      hotelService.updateFilter('wifi', false);
      expect(hotelService.filters['wifi'], false);
    });

    test('Should toggle favorites correctly', () {
      const hotelId = '1';
      
      // Add to favorites
      hotelService.toggleFavorite(hotelId);
      expect(hotelService.favoriteHotels.contains(hotelId), true);
      
      // Remove from favorites
      hotelService.toggleFavorite(hotelId);
      expect(hotelService.favoriteHotels.contains(hotelId), false);
    });

    test('Should get hotel by ID correctly', () {
      final hotel = hotelService.getHotelById('1');
      expect(hotel, isNotNull);
      expect(hotel?.id, '1');
      
      final nonExistentHotel = hotelService.getHotelById('999');
      expect(nonExistentHotel, isNull);
    });

    test('Should filter hotels by category correctly', () {
      final luxeHotels = hotelService.getHotelsByCategory(HotelCategory.LUXE);
      expect(luxeHotels.every((hotel) => hotel.category == HotelCategory.LUXE), true);
    });

    test('Should set sort option correctly', () {
      hotelService.setSortBy('price_low');
      expect(hotelService.sortBy, 'price_low');
    });

    test('Available cities should contain expected cities', () {
      final cities = hotelService.availableCities;
      expect(cities.contains('New Delhi'), true);
      expect(cities.contains('Mumbai'), true);
      expect(cities.contains('Bangalore'), true);
      expect(cities.length, greaterThan(5));
    });
  });
}