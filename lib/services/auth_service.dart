import 'package:flutter/material.dart';
import '../models/hotel.dart';

class AuthService extends ChangeNotifier {
  User? _currentUser;
  bool _isAuthenticated = false;
  bool _isLoading = false;

  User? get currentUser => _currentUser;
  bool get isAuthenticated => _isAuthenticated;
  bool get isLoading => _isLoading;

  Future<bool> signInWithEmail(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    // Mock successful authentication
    _currentUser = User(
      id: '1',
      name: 'John Doe',
      email: email,
      phone: '+1234567890',
      profileImage: '',
      memberSince: DateTime.now().subtract(const Duration(days: 365)),
      loyaltyPoints: 1250,
      stayNights: 15,
      citiesVisited: 8,
      countriesVisited: 3,
      favoriteHotels: [],
      preferences: {
        'currency': 'USD',
        'language': 'English',
        'notifications': true,
      },
    );

    _isAuthenticated = true;
    _isLoading = false;
    notifyListeners();
    return true;
  }

  Future<bool> signInWithPhone(String phone, String otp) async {
    _isLoading = true;
    notifyListeners();

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    // Mock successful authentication
    _currentUser = User(
      id: '1',
      name: 'John Doe',
      email: 'john.doe@example.com',
      phone: phone,
      profileImage: '',
      memberSince: DateTime.now().subtract(const Duration(days: 365)),
      loyaltyPoints: 1250,
      stayNights: 15,
      citiesVisited: 8,
      countriesVisited: 3,
      favoriteHotels: [],
      preferences: {
        'currency': 'USD',
        'language': 'English',
        'notifications': true,
      },
    );

    _isAuthenticated = true;
    _isLoading = false;
    notifyListeners();
    return true;
  }

  Future<bool> signInWithFaceID() async {
    _isLoading = true;
    notifyListeners();

    try {
      // Simulate Face ID authentication
      await Future.delayed(const Duration(seconds: 1));
      
      // Mock successful authentication
      _currentUser = User(
        id: '1',
        name: 'John Doe',
        email: 'john.doe@example.com',
        phone: '+1234567890',
        profileImage: '',
        memberSince: DateTime.now().subtract(const Duration(days: 365)),
        loyaltyPoints: 1250,
        stayNights: 15,
        citiesVisited: 8,
        countriesVisited: 3,
        favoriteHotels: [],
        preferences: {
          'currency': 'USD',
          'language': 'English',
          'notifications': true,
        },
      );

      _isAuthenticated = true;
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> signOut() async {
    _currentUser = null;
    _isAuthenticated = false;
    notifyListeners();
  }

  Future<bool> sendOTP(String phone) async {
    // Simulate sending OTP
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }

  Future<bool> verifyOTP(String phone, String otp) async {
    // Simulate OTP verification
    await Future.delayed(const Duration(seconds: 1));
    return otp == '123456'; // Mock OTP
  }
}