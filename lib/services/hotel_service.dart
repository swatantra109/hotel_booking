import 'package:flutter/material.dart';
import '../models/hotel.dart';

class HotelService extends ChangeNotifier {
  List<Hotel> _hotels = [];
  List<Hotel> _filteredHotels = [];
  List<String> _favoriteHotels = [];
  String _selectedCity = 'New Delhi';
  DateTime _selectedDate = DateTime.now();
  Map<String, bool> _filters = {
    'wifi': false,
    'breakfast': false,
    'parking': false,
    'gym': false,
    'pool': false,
    'pets': false,
    'spa': false,
  };
  String _sortBy = 'recommended';

  List<Hotel> get hotels => _filteredHotels;
  List<String> get favoriteHotels => _favoriteHotels;
  String get selectedCity => _selectedCity;
  DateTime get selectedDate => _selectedDate;
  Map<String, bool> get filters => _filters;
  String get sortBy => _sortBy;

  List<String> get availableCities => [
    'New Delhi',
    'Mumbai',
    'Bangalore',
    'Chennai',
    'Kolkata',
    'Hyderabad',
    'Pune',
    'Jaipur',
    'Goa',
    'Ahmedabad',
  ];

  HotelService() {
    _initializeMockData();
  }

  void _initializeMockData() {
    _hotels = [
      Hotel(
        id: '1',
        name: 'The Imperial Palace',
        area: 'Connaught Place',
        city: 'New Delhi',
        rating: 4.8,
        reviewCount: 1250,
        originalPrice: 15000,
        discountedPrice: 12000,
        discountPercentage: 20,
        images: [
          'https://images.unsplash.com/photo-1551882547-ff40c63fe5fa?w=800',
          'https://images.unsplash.com/photo-1564501049412-61c2a3083791?w=800',
        ],
        perks: ['Complimentary WiFi', 'Free Parking', 'Complimentary Breakfast'],
        category: HotelCategory.LUXE,
        amenities: {
          'wifi': true,
          'breakfast': true,
          'parking': true,
          'gym': true,
          'pool': true,
          'pets': false,
          'spa': true,
        },
        description: 'Luxury hotel in the heart of Delhi with world-class amenities.',
        checkInTime: '14:00',
        checkOutTime: '11:00',
        isAvailable: true,
        discountExpiry: DateTime.now().add(const Duration(hours: 6)),
      ),
      Hotel(
        id: '2',
        name: 'Urban Boutique Hotel',
        area: 'Karol Bagh',
        city: 'New Delhi',
        rating: 4.5,
        reviewCount: 890,
        originalPrice: 8000,
        discountedPrice: 6400,
        discountPercentage: 20,
        images: [
          'https://images.unsplash.com/photo-1566073771259-6a8506099945?w=800',
          'https://images.unsplash.com/photo-1631049307264-da0ec9d70304?w=800',
        ],
        perks: ['Complimentary WiFi', 'Free Laundry'],
        category: HotelCategory.HIP,
        amenities: {
          'wifi': true,
          'breakfast': false,
          'parking': true,
          'gym': true,
          'pool': false,
          'pets': true,
          'spa': false,
        },
        description: 'Modern boutique hotel with contemporary design.',
        checkInTime: '15:00',
        checkOutTime: '12:00',
        isAvailable: true,
        discountExpiry: DateTime.now().add(const Duration(hours: 12)),
      ),
      Hotel(
        id: '3',
        name: 'Comfort Inn Express',
        area: 'Janpath',
        city: 'New Delhi',
        rating: 4.2,
        reviewCount: 650,
        originalPrice: 5000,
        discountedPrice: 4000,
        discountPercentage: 20,
        images: [
          'https://images.unsplash.com/photo-1520250497591-112f2f40a3f4?w=800',
          'https://images.unsplash.com/photo-1595576508898-0ad5c879a061?w=800',
        ],
        perks: ['Complimentary WiFi', 'Free Parking'],
        category: HotelCategory.SOLID,
        amenities: {
          'wifi': true,
          'breakfast': true,
          'parking': true,
          'gym': false,
          'pool': false,
          'pets': false,
          'spa': false,
        },
        description: 'Comfortable stay with essential amenities.',
        checkInTime: '14:00',
        checkOutTime: '11:00',
        isAvailable: true,
      ),
      Hotel(
        id: '4',
        name: 'Heritage Mansion',
        area: 'Old Delhi',
        city: 'New Delhi',
        rating: 4.6,
        reviewCount: 420,
        originalPrice: 12000,
        discountedPrice: 9600,
        discountPercentage: 20,
        images: [
          'https://images.unsplash.com/photo-1571896349842-33c89424de2d?w=800',
          'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?w=800',
        ],
        perks: ['Complimentary WiFi', 'Cultural Tours', 'Traditional Cuisine'],
        category: HotelCategory.CHARMING,
        amenities: {
          'wifi': true,
          'breakfast': true,
          'parking': false,
          'gym': false,
          'pool': false,
          'pets': false,
          'spa': true,
        },
        description: 'Experience the charm of old Delhi in this heritage property.',
        checkInTime: '14:00',
        checkOutTime: '11:00',
        isAvailable: true,
      ),
      Hotel(
        id: '5',
        name: 'Budget Stay Inn',
        area: 'Paharganj',
        city: 'New Delhi',
        rating: 3.8,
        reviewCount: 340,
        originalPrice: 2500,
        discountedPrice: 2000,
        discountPercentage: 20,
        images: [
          'https://images.unsplash.com/photo-1590490360182-c33d57733427?w=800',
        ],
        perks: ['Complimentary WiFi'],
        category: HotelCategory.BASIC,
        amenities: {
          'wifi': true,
          'breakfast': false,
          'parking': false,
          'gym': false,
          'pool': false,
          'pets': false,
          'spa': false,
        },
        description: 'Budget-friendly accommodation with basic amenities.',
        checkInTime: '12:00',
        checkOutTime: '10:00',
        isAvailable: true,
      ),
    ];
    _filteredHotels = List.from(_hotels);
  }

  void setSelectedCity(String city) {
    _selectedCity = city;
    _applyFilters();
    notifyListeners();
  }

  void setSelectedDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  void updateFilter(String filterKey, bool value) {
    _filters[filterKey] = value;
    _applyFilters();
    notifyListeners();
  }

  void setSortBy(String sortBy) {
    _sortBy = sortBy;
    _applyFilters();
    notifyListeners();
  }

  void _applyFilters() {
    _filteredHotels = List.from(_hotels);

    // Filter by city
    _filteredHotels = _filteredHotels.where((hotel) => hotel.city == _selectedCity).toList();

    // Apply amenity filters
    _filters.forEach((key, value) {
      if (value) {
        _filteredHotels = _filteredHotels.where((hotel) => hotel.amenities[key] == true).toList();
      }
    });

    // Apply sorting
    switch (_sortBy) {
      case 'price_low':
        _filteredHotels.sort((a, b) => a.discountedPrice.compareTo(b.discountedPrice));
        break;
      case 'price_high':
        _filteredHotels.sort((a, b) => b.discountedPrice.compareTo(a.discountedPrice));
        break;
      case 'rating':
        _filteredHotels.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case 'discount':
        _filteredHotels.sort((a, b) => b.discountPercentage.compareTo(a.discountPercentage));
        break;
      default:
        // Keep original order for 'recommended'
        break;
    }
  }

  void toggleFavorite(String hotelId) {
    if (_favoriteHotels.contains(hotelId)) {
      _favoriteHotels.remove(hotelId);
    } else {
      _favoriteHotels.add(hotelId);
    }
    notifyListeners();
  }

  List<Hotel> getFavoriteHotels() {
    return _hotels.where((hotel) => _favoriteHotels.contains(hotel.id)).toList();
  }

  Hotel? getHotelById(String id) {
    try {
      return _hotels.firstWhere((hotel) => hotel.id == id);
    } catch (e) {
      return null;
    }
  }

  List<Hotel> getHotelsByCategory(HotelCategory category) {
    return _filteredHotels.where((hotel) => hotel.category == category).toList();
  }
}