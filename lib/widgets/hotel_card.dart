import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/hotel.dart';
import '../services/hotel_service.dart';
import '../utils/app_theme.dart';

class HotelCard extends StatelessWidget {
  final Hotel hotel;

  const HotelCard({super.key, required this.hotel});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildImageSection(),
          _buildContentSection(),
          _buildPriceSection(),
        ],
      ),
    );
  }

  Widget _buildImageSection() {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          child: Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              image: hotel.images.isNotEmpty
                  ? DecorationImage(
                      image: NetworkImage(hotel.images.first),
                      fit: BoxFit.cover,
                      onError: (exception, stackTrace) {
                        // Handle image loading error
                      },
                    )
                  : null,
            ),
            child: hotel.images.isEmpty
                ? const Icon(
                    Icons.hotel,
                    size: 50,
                    color: Colors.grey,
                  )
                : null,
          ),
        ),
        Positioned(
          top: 12,
          left: 12,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: _getCategoryColor(),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              hotel.category.displayName,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        Positioned(
          top: 12,
          right: 12,
          child: Consumer<HotelService>(
            builder: (context, hotelService, child) {
              final isFavorite = hotelService.favoriteHotels.contains(hotel.id);
              return GestureDetector(
                onTap: () => hotelService.toggleFavorite(hotel.id),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : Colors.grey,
                    size: 20,
                  ),
                ),
              );
            },
          ),
        ),
        if (hotel.discountExpiry != null)
          Positioned(
            bottom: 12,
            left: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppTheme.accentColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.access_time,
                    color: Colors.white,
                    size: 12,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Limited Time',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildContentSection() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  hotel.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textPrimary,
                  ),
                ),
              ),
              _buildRatingWidget(),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(
                Icons.location_on,
                size: 14,
                color: AppTheme.textSecondary,
              ),
              const SizedBox(width: 4),
              Text(
                '${hotel.area}, ${hotel.city}',
                style: TextStyle(
                  fontSize: 12,
                  color: AppTheme.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          _buildPerksSection(),
          const SizedBox(height: 8),
          _buildAmenitiesSection(),
        ],
      ),
    );
  }

  Widget _buildRatingWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppTheme.primaryColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.thumb_up,
            color: Colors.white,
            size: 12,
          ),
          const SizedBox(width: 4),
          Text(
            '${hotel.rating}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 2),
          Text(
            '(${hotel.reviewCount})',
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPerksSection() {
    if (hotel.perks.isEmpty) return const SizedBox.shrink();

    return Wrap(
      spacing: 8,
      runSpacing: 4,
      children: hotel.perks.take(3).map((perk) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: AppTheme.secondaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppTheme.secondaryColor.withOpacity(0.3),
            ),
          ),
          child: Text(
            perk,
            style: TextStyle(
              fontSize: 10,
              color: AppTheme.secondaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildAmenitiesSection() {
    final amenityIcons = {
      'wifi': Icons.wifi,
      'breakfast': Icons.restaurant,
      'parking': Icons.local_parking,
      'gym': Icons.fitness_center,
      'pool': Icons.pool,
      'spa': Icons.spa,
    };

    final availableAmenities = hotel.amenities.entries
        .where((entry) => entry.value && amenityIcons.containsKey(entry.key))
        .take(4)
        .toList();

    if (availableAmenities.isEmpty) return const SizedBox.shrink();

    return Row(
      children: availableAmenities.map((amenity) {
        return Padding(
          padding: const EdgeInsets.only(right: 12),
          child: Icon(
            amenityIcons[amenity.key],
            size: 16,
            color: AppTheme.textSecondary,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildPriceSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPriceComparisonSection(),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (hotel.discountPercentage > 0) ...[
                      Row(
                        children: [
                          Text(
                            '₹${hotel.originalPrice.toInt()}',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppTheme.textSecondary,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: AppTheme.accentColor,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              '${hotel.discountPercentage}% OFF',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                    ],
                    Row(
                      children: [
                        Text(
                          '₹${hotel.discountedPrice.toInt()}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.textPrimary,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Text(
                          '/night',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppTheme.textSecondary,
                          ),
                        ),
                      ],
                    ),
                    const Text(
                      'Includes taxes & fees',
                      style: TextStyle(
                        fontSize: 10,
                        color: AppTheme.textHint,
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // TODO: Navigate to hotel details
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                child: const Text('Book Now'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPriceComparisonSection() {
    final comparisons = [
      {'name': 'XYZ Brand', 'price': hotel.discountedPrice},
      {'name': 'Booking.com', 'price': hotel.discountedPrice + 500},
      {'name': 'MakeMyTrip', 'price': hotel.discountedPrice + 300},
      {'name': 'Goibibo', 'price': hotel.discountedPrice + 200},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Why Book with us',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppTheme.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        ...comparisons.map((comp) {
          final isOurs = comp['name'] == 'XYZ Brand';
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    comp['name'] as String,
                    style: TextStyle(
                      fontSize: 10,
                      color: isOurs ? AppTheme.primaryColor : AppTheme.textSecondary,
                      fontWeight: isOurs ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                ),
                Text(
                  '₹${(comp['price'] as double).toInt()}',
                  style: TextStyle(
                    fontSize: 10,
                    color: isOurs ? AppTheme.primaryColor : AppTheme.textSecondary,
                    fontWeight: isOurs ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }

  Color _getCategoryColor() {
    switch (hotel.category) {
      case HotelCategory.LUXE:
        return const Color(0xFF9C27B0);
      case HotelCategory.HIP:
        return const Color(0xFF2196F3);
      case HotelCategory.SOLID:
        return const Color(0xFF4CAF50);
      case HotelCategory.CHARMING:
        return const Color(0xFFFF9800);
      case HotelCategory.BASIC:
        return const Color(0xFF607D8B);
      case HotelCategory.CRASHPAD:
        return const Color(0xFF795548);
      case HotelCategory.HIGHROLLER:
        return const Color(0xFFE91E63);
    }
  }
}