import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../models/cinema_seat.dart';
import '../../models/movie.dart';
import '../../models/movie_show.dart';
import '../ticket/ticket_screen.dart';

class CheckoutScreen extends StatelessWidget {
  final Movie movie;
  final MovieShow show;
  final List<CinemaSeat> seats;
  final double total;

  const CheckoutScreen({
    super.key,
    required this.movie,
    required this.show,
    required this.seats,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    final seatNames =
    seats.map((seat) {
      return '${String.fromCharCode(65 + seat.row)}${seat.number}';
    }).join(', ');

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Checkout',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _movieSummary(seatNames),
          const SizedBox(height: 18),
          _paymentSection(),
          const SizedBox(height: 18),
          _totalBox(),
          const SizedBox(height: 20),
          SizedBox(
            height: 54,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => TicketScreen(
                      movie: movie,
                      show: show,
                      seats: seats,
                      total: total,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(17),
                ),
              ),
              child: const Text(
                'Pay & Confirm Booking',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _movieSummary(String seatNames) {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            width: 70,
            height: 85,
            decoration: BoxDecoration(
              color: AppColors.surfaceLight,
              borderRadius: BorderRadius.circular(13),
            ),
            child: Center(
              child: Text(
                movie.poster,
                style: const TextStyle(fontSize: 35),
              ),
            ),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  '${show.time} • ${show.hall}',
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 9,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Seats: $seatNames',
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _paymentSection() {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Payment Method',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 14),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(
              backgroundColor: Color(0xFF292934),
              child: Icon(
                Icons.credit_card,
                color: AppColors.primary,
              ),
            ),
            title: Text(
              'Visa ending in 4821',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 11,
              ),
            ),
            subtitle: Text(
              'Default payment method',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 8,
              ),
            ),
            trailing: Icon(
              Icons.check_circle,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _totalBox() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          const Expanded(
            child: Text(
              'Total Amount',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 11,
              ),
            ),
          ),
          Text(
            '\$${total.toStringAsFixed(2)}',
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}
