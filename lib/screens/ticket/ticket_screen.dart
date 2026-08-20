import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../models/cinema_seat.dart';
import '../../models/movie.dart';
import '../../models/movie_show.dart';

class TicketScreen extends StatelessWidget {
  final Movie movie;
  final MovieShow show;
  final List<CinemaSeat> seats;
  final double total;

  const TicketScreen({
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
          'Your Ticket',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(25),
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(25),
                    ),
                  ),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.check_circle_rounded,
                        color: Colors.white,
                        size: 45,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Booking Confirmed!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        movie.title,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(22),
                  child: Column(
                    children: [
                      Text(
                        movie.poster,
                        style: const TextStyle(
                          fontSize: 60,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        movie.title,
                        style: const TextStyle(
                          color: AppColors.textDark,
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 20),
                      _ticketRow(
                        'Date',
                        'Today',
                      ),
                      _ticketRow(
                        'Time',
                        show.time,
                      ),
                      _ticketRow(
                        'Cinema',
                        'CineVerse Downtown',
                      ),
                      _ticketRow(
                        'Hall',
                        '${show.hall} • ${show.format}',
                      ),
                      _ticketRow(
                        'Seats',
                        seatNames,
                      ),
                      _ticketRow(
                        'Amount',
                        '\$${total.toStringAsFixed(2)}',
                      ),
                      const SizedBox(height: 20),
                      Container(
                        height: 70,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius:
                          BorderRadius.circular(12),
                        ),
                        child: const Center(
                          child: Text(
                            '▮▮ ▮▮▮ ▮ ▮▮ ▮▮ ▮▮▮ ▮',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              letterSpacing: 3,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'CINE-4829-2026',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 9,
                          letterSpacing: 2,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _ticketRow(
      String title,
      String value,
      ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 7,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 10,
              ),
            ),
          ),
          Text(
            value,
            textAlign: TextAlign.right,
            style: const TextStyle(
              color: AppColors.textDark,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}