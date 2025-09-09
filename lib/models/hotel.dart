class Hotel {
  final String id;
  final String name;
  final String area;
  final String city;
  final double rating;
  final int reviewCount;
  final double originalPrice;
  final double discountedPrice;
  final int discountPercentage;
  final List<String> images;
  final List<String> perks;
  final HotelCategory category;
  final Map<String, bool> amenities;
  final String description;
  final String checkInTime;
  final String checkOutTime;
  final bool isAvailable;
  final DateTime? discountExpiry;

  Hotel({
    required this.id,
    required this.name,
    required this.area,
    required this.city,
    required this.rating,
    required this.reviewCount,
    required this.originalPrice,
    required this.discountedPrice,
    required this.discountPercentage,
    required this.images,
    required this.perks,
    required this.category,
    required this.amenities,
    required this.description,
    required this.checkInTime,
    required this.checkOutTime,
    required this.isAvailable,
    this.discountExpiry,
  });

  factory Hotel.fromJson(Map<String, dynamic> json) {
    return Hotel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      area: json['area'] ?? '',
      city: json['city'] ?? '',
      rating: (json['rating'] ?? 0.0).toDouble(),
      reviewCount: json['reviewCount'] ?? 0,
      originalPrice: (json['originalPrice'] ?? 0.0).toDouble(),
      discountedPrice: (json['discountedPrice'] ?? 0.0).toDouble(),
      discountPercentage: json['discountPercentage'] ?? 0,
      images: List<String>.from(json['images'] ?? []),
      perks: List<String>.from(json['perks'] ?? []),
      category: HotelCategory.values.firstWhere(
        (e) => e.toString().split('.').last == json['category'],
        orElse: () => HotelCategory.SOLID,
      ),
      amenities: Map<String, bool>.from(json['amenities'] ?? {}),
      description: json['description'] ?? '',
      checkInTime: json['checkInTime'] ?? '14:00',
      checkOutTime: json['checkOutTime'] ?? '11:00',
      isAvailable: json['isAvailable'] ?? true,
      discountExpiry: json['discountExpiry'] != null 
          ? DateTime.parse(json['discountExpiry']) 
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'area': area,
      'city': city,
      'rating': rating,
      'reviewCount': reviewCount,
      'originalPrice': originalPrice,
      'discountedPrice': discountedPrice,
      'discountPercentage': discountPercentage,
      'images': images,
      'perks': perks,
      'category': category.toString().split('.').last,
      'amenities': amenities,
      'description': description,
      'checkInTime': checkInTime,
      'checkOutTime': checkOutTime,
      'isAvailable': isAvailable,
      'discountExpiry': discountExpiry?.toIso8601String(),
    };
  }
}

enum HotelCategory {
  LUXE,
  HIP,
  SOLID,
  CHARMING,
  BASIC,
  CRASHPAD,
  HIGHROLLER,
}

extension HotelCategoryExtension on HotelCategory {
  String get displayName {
    switch (this) {
      case HotelCategory.LUXE:
        return 'Luxe';
      case HotelCategory.HIP:
        return 'Hip';
      case HotelCategory.SOLID:
        return 'Solid';
      case HotelCategory.CHARMING:
        return 'Charming';
      case HotelCategory.BASIC:
        return 'Basic';
      case HotelCategory.CRASHPAD:
        return 'Crashpad';
      case HotelCategory.HIGHROLLER:
        return 'High Roller';
    }
  }
}

class User {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String profileImage;
  final DateTime memberSince;
  final int loyaltyPoints;
  final int stayNights;
  final int citiesVisited;
  final int countriesVisited;
  final List<String> favoriteHotels;
  final Map<String, dynamic> preferences;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.profileImage,
    required this.memberSince,
    required this.loyaltyPoints,
    required this.stayNights,
    required this.citiesVisited,
    required this.countriesVisited,
    required this.favoriteHotels,
    required this.preferences,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      profileImage: json['profileImage'] ?? '',
      memberSince: DateTime.parse(json['memberSince'] ?? DateTime.now().toIso8601String()),
      loyaltyPoints: json['loyaltyPoints'] ?? 0,
      stayNights: json['stayNights'] ?? 0,
      citiesVisited: json['citiesVisited'] ?? 0,
      countriesVisited: json['countriesVisited'] ?? 0,
      favoriteHotels: List<String>.from(json['favoriteHotels'] ?? []),
      preferences: Map<String, dynamic>.from(json['preferences'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'profileImage': profileImage,
      'memberSince': memberSince.toIso8601String(),
      'loyaltyPoints': loyaltyPoints,
      'stayNights': stayNights,
      'citiesVisited': citiesVisited,
      'countriesVisited': countriesVisited,
      'favoriteHotels': favoriteHotels,
      'preferences': preferences,
    };
  }
}

class Booking {
  final String id;
  final String hotelId;
  final String userId;
  final DateTime checkInDate;
  final DateTime checkOutDate;
  final int rooms;
  final int guests;
  final double totalAmount;
  final BookingStatus status;
  final DateTime bookingDate;
  final Map<String, dynamic> guestInfo;

  Booking({
    required this.id,
    required this.hotelId,
    required this.userId,
    required this.checkInDate,
    required this.checkOutDate,
    required this.rooms,
    required this.guests,
    required this.totalAmount,
    required this.status,
    required this.bookingDate,
    required this.guestInfo,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'] ?? '',
      hotelId: json['hotelId'] ?? '',
      userId: json['userId'] ?? '',
      checkInDate: DateTime.parse(json['checkInDate']),
      checkOutDate: DateTime.parse(json['checkOutDate']),
      rooms: json['rooms'] ?? 1,
      guests: json['guests'] ?? 1,
      totalAmount: (json['totalAmount'] ?? 0.0).toDouble(),
      status: BookingStatus.values.firstWhere(
        (e) => e.toString().split('.').last == json['status'],
        orElse: () => BookingStatus.confirmed,
      ),
      bookingDate: DateTime.parse(json['bookingDate']),
      guestInfo: Map<String, dynamic>.from(json['guestInfo'] ?? {}),
    );
  }
}

enum BookingStatus {
  pending,
  confirmed,
  cancelled,
  completed,
}