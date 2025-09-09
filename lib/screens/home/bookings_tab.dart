import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../utils/app_theme.dart';
import '../../models/hotel.dart';

class BookingsTab extends StatefulWidget {
  const BookingsTab({super.key});

  @override
  State<BookingsTab> createState() => _BookingsTabState();
}

class _BookingsTabState extends State<BookingsTab> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('My Bookings'),
        backgroundColor: Colors.white,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppTheme.primaryColor,
          unselectedLabelColor: AppTheme.textSecondary,
          indicatorColor: AppTheme.primaryColor,
          tabs: const [
            Tab(text: 'Current'),
            Tab(text: 'Previous'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildCurrentBookings(),
          _buildPreviousBookings(),
        ],
      ),
    );
  }

  Widget _buildCurrentBookings() {
    // Mock current bookings
    final currentBookings = [
      Booking(
        id: '1',
        hotelId: '1',
        userId: '1',
        checkInDate: DateTime.now().add(const Duration(days: 2)),
        checkOutDate: DateTime.now().add(const Duration(days: 4)),
        rooms: 1,
        guests: 2,
        totalAmount: 12000,
        status: BookingStatus.confirmed,
        bookingDate: DateTime.now().subtract(const Duration(days: 1)),
        guestInfo: {'name': 'John Doe', 'phone': '+1234567890'},
      ),
    ];

    if (currentBookings.isEmpty) {
      return _buildEmptyState('No current bookings', 'Book your next stay!');
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: currentBookings.length,
      itemBuilder: (context, index) {
        return _buildBookingCard(currentBookings[index], true);
      },
    );
  }

  Widget _buildPreviousBookings() {
    // Mock previous bookings
    final previousBookings = [
      Booking(
        id: '2',
        hotelId: '2',
        userId: '1',
        checkInDate: DateTime.now().subtract(const Duration(days: 30)),
        checkOutDate: DateTime.now().subtract(const Duration(days: 28)),
        rooms: 1,
        guests: 1,
        totalAmount: 6400,
        status: BookingStatus.completed,
        bookingDate: DateTime.now().subtract(const Duration(days: 35)),
        guestInfo: {'name': 'John Doe', 'phone': '+1234567890'},
      ),
    ];

    if (previousBookings.isEmpty) {
      return _buildEmptyState('No previous bookings', 'Your booking history will appear here');
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: previousBookings.length,
      itemBuilder: (context, index) {
        return _buildBookingCard(previousBookings[index], false);
      },
    );
  }

  Widget _buildEmptyState(String title, String subtitle) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.book_outlined,
            size: 80,
            color: AppTheme.textHint,
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppTheme.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              color: AppTheme.textHint,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookingCard(Booking booking, bool isCurrent) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Booking #${booking.id}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'The Imperial Palace', // Mock hotel name
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                _buildStatusChip(booking.status),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildDateInfo(
                    'Check-in',
                    booking.checkInDate,
                  ),
                ),
                Expanded(
                  child: _buildDateInfo(
                    'Check-out',
                    booking.checkOutDate,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Text(
                    '${booking.rooms} Room • ${booking.guests} Guests',
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ),
                Text(
                  '₹${booking.totalAmount.toInt()}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                if (isCurrent) ...[
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        // TODO: Modify booking
                      },
                      child: const Text('Modify'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // TODO: View details
                      },
                      child: const Text('View Details'),
                    ),
                  ),
                ] else ...[
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        // TODO: Write review
                      },
                      child: const Text('Write Review'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // TODO: Book again
                      },
                      child: const Text('Book Again'),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(BookingStatus status) {
    Color backgroundColor;
    Color textColor;
    String label;

    switch (status) {
      case BookingStatus.confirmed:
        backgroundColor = AppTheme.primaryColor;
        textColor = Colors.white;
        label = 'Confirmed';
        break;
      case BookingStatus.pending:
        backgroundColor = Colors.orange;
        textColor = Colors.white;
        label = 'Pending';
        break;
      case BookingStatus.cancelled:
        backgroundColor = AppTheme.errorColor;
        textColor = Colors.white;
        label = 'Cancelled';
        break;
      case BookingStatus.completed:
        backgroundColor = AppTheme.secondaryColor;
        textColor = Colors.white;
        label = 'Completed';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildDateInfo(String label, DateTime date) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: AppTheme.textHint,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          DateFormat('MMM dd, yyyy').format(date),
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppTheme.textPrimary,
          ),
        ),
        Text(
          DateFormat('EEEE').format(date),
          style: const TextStyle(
            fontSize: 12,
            color: AppTheme.textSecondary,
          ),
        ),
      ],
    );
  }
}