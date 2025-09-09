import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/hotel_service.dart';
import '../utils/app_theme.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  late Map<String, bool> _filters;
  String _sortBy = 'recommended';

  @override
  void initState() {
    super.initState();
    final hotelService = Provider.of<HotelService>(context, listen: false);
    _filters = Map.from(hotelService.filters);
    _sortBy = hotelService.sortBy;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle bar
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),
          
          // Title
          Row(
            children: [
              const Text(
                'Filters & Sort',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textPrimary,
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: _resetFilters,
                child: Text(
                  'Reset',
                  style: TextStyle(
                    color: AppTheme.primaryColor,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // Sort Section
          const Text(
            'Sort by',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          _buildSortOptions(),
          
          const SizedBox(height: 24),
          
          // Filter Section
          const Text(
            'Amenities',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          _buildAmenityFilters(),
          
          const SizedBox(height: 24),
          
          // Apply Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _applyFilters,
              child: const Text('Apply Filters'),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildSortOptions() {
    final sortOptions = [
      {'key': 'recommended', 'label': 'Recommended'},
      {'key': 'price_low', 'label': 'Price: Low to High'},
      {'key': 'price_high', 'label': 'Price: High to Low'},
      {'key': 'rating', 'label': 'Highest Rated'},
      {'key': 'discount', 'label': 'Best Discount'},
    ];

    return Column(
      children: sortOptions.map((option) {
        return RadioListTile<String>(
          title: Text(
            option['label']!,
            style: const TextStyle(fontSize: 14),
          ),
          value: option['key']!,
          groupValue: _sortBy,
          onChanged: (value) {
            setState(() {
              _sortBy = value!;
            });
          },
          activeColor: AppTheme.primaryColor,
          dense: true,
          contentPadding: EdgeInsets.zero,
        );
      }).toList(),
    );
  }

  Widget _buildAmenityFilters() {
    final amenities = [
      {'key': 'wifi', 'label': 'WiFi', 'icon': Icons.wifi},
      {'key': 'breakfast', 'label': 'Breakfast', 'icon': Icons.restaurant},
      {'key': 'parking', 'label': 'Parking', 'icon': Icons.local_parking},
      {'key': 'gym', 'label': 'Gym', 'icon': Icons.fitness_center},
      {'key': 'pool', 'label': 'Pool', 'icon': Icons.pool},
      {'key': 'pets', 'label': 'Pet Friendly', 'icon': Icons.pets},
      {'key': 'spa', 'label': 'Spa', 'icon': Icons.spa},
    ];

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: amenities.map((amenity) {
        final isSelected = _filters[amenity['key']] ?? false;
        return FilterChip(
          label: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                amenity['icon'] as IconData,
                size: 16,
                color: isSelected ? Colors.white : AppTheme.textSecondary,
              ),
              const SizedBox(width: 4),
              Text(
                amenity['label']!,
                style: TextStyle(
                  fontSize: 12,
                  color: isSelected ? Colors.white : AppTheme.textPrimary,
                ),
              ),
            ],
          ),
          selected: isSelected,
          onSelected: (selected) {
            setState(() {
              _filters[amenity['key']!] = selected;
            });
          },
          selectedColor: AppTheme.primaryColor,
          backgroundColor: Colors.grey.shade100,
          side: BorderSide(
            color: isSelected ? AppTheme.primaryColor : Colors.grey.shade300,
          ),
          showCheckmark: false,
        );
      }).toList(),
    );
  }

  void _resetFilters() {
    setState(() {
      _filters = {
        'wifi': false,
        'breakfast': false,
        'parking': false,
        'gym': false,
        'pool': false,
        'pets': false,
        'spa': false,
      };
      _sortBy = 'recommended';
    });
  }

  void _applyFilters() {
    final hotelService = Provider.of<HotelService>(context, listen: false);
    
    // Apply all filters
    _filters.forEach((key, value) {
      hotelService.updateFilter(key, value);
    });
    
    // Apply sort
    hotelService.setSortBy(_sortBy);
    
    Navigator.pop(context);
  }
}