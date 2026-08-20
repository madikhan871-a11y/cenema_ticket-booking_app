import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../models/cinema_seat.dart';
import '../../models/movie.dart';
import '../../models/movie_show.dart';
import '../../widgets/seat_widget.dart';
import '../checkout/checkout_screen.dart';

class SeatSelectionScreen extends StatefulWidget {
  final Movie movie;
  final MovieShow show;

  const SeatSelectionScreen({
    super.key,
    required this.movie,
    required this.show,
  });

  @override
  State<SeatSelectionScreen> createState() =>
      _SeatSelectionScreenState();
}

class _SeatSelectionScreenState
    extends State<SeatSelectionScreen> {
  final List<CinemaSeat> seats = [];

  @override
  void initState() {
    super.initState();

    for (int row = 0; row < 6; row++) {
      for (int number = 1; number <= 8; number++) {
        final occupied =
            (row == 1 && number == 3) ||
                (row == 2 && number == 6) ||
                (row == 4 && number == 2);

        seats.add(
          CinemaSeat(
            id: '$row-$number',
            row: row,
            number: number,
            status: occupied
                ? SeatStatus.occupied
                : SeatStatus.available,
          ),
        );
      }
    }
  }

  List<CinemaSeat> get selectedSeats => seats
      .where(
        (seat) => seat.status == SeatStatus.selected,
  )
      .toList();

  void toggleSeat(CinemaSeat seat) {
    setState(() {
      seat.status =
      seat.status == SeatStatus.selected
          ? SeatStatus.available
          : SeatStatus.selected;
    });
  }

  @override
  Widget build(BuildContext context) {
    final total =
        selectedSeats.length * widget.show.price;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Choose Seats',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Text(
            widget.movie.title,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            '${widget.show.time} • ${widget.show.hall}',
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 10,
            ),
          ),
          const SizedBox(height: 25),
          _screen(),
          const SizedBox(height: 25),
          Expanded(
            child: SingleChildScrollView(
              child: _seatGrid(),
            ),
          ),
          _bottom(total),
        ],
      ),
    );
  }

  Widget _screen() {
    return Column(
      children: [
        Container(
          width: 230,
          height: 5,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(
                  alpha: .4,
                ),
                blurRadius: 18,
              ),
            ],
          ),
        ),
        const SizedBox(height: 9),
        const Text(
          'SCREEN',
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 8,
            letterSpacing: 3,
          ),
        ),
      ],
    );
  }

  Widget _seatGrid() {
    return Column(
      children: List.generate(6, (row) {
        final rowSeats =
        seats.where((seat) => seat.row == row).toList();

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 20,
              child: Text(
                String.fromCharCode(65 + row),
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 9,
                ),
              ),
            ),
            ...rowSeats.map(
                  (seat) => SeatWidget(
                seat: seat,
                onTap: () => toggleSeat(seat),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _bottom(double total) {
    return Container(
      padding: const EdgeInsets.fromLTRB(
        20,
        15,
        20,
        20,
      ),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              _legend(
                AppColors.availableSeat,
                'Available',
              ),
              _legend(
                AppColors.selectedSeat,
                'Selected',
              ),
              _legend(
                AppColors.occupiedSeat,
                'Occupied',
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Total',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 9,
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
              ),
              SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: selectedSeats.isEmpty
                      ? null
                      : () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            CheckoutScreen(
                              movie: widget.movie,
                              show: widget.show,
                              seats: selectedSeats,
                              total: total,
                            ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                    AppColors.primary,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor:
                    AppColors.surfaceLight,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(15),
                    ),
                  ),
                  child: const Text(
                    'Continue',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _legend(Color color, String text) {
    return Expanded(
      child: Row(
        children: [
          Container(
            width: 11,
            height: 11,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          const SizedBox(width: 5),
          Text(
            text,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 8,
            ),
          ),
        ],
      ),
    );
  }
}