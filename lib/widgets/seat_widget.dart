import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';
import '../models/cinema_seat.dart';

class SeatWidget extends StatelessWidget {
  final CinemaSeat seat;
  final VoidCallback onTap;

  const SeatWidget({
    super.key,
    required this.seat,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color color;

    switch (seat.status) {
      case SeatStatus.available:
        color = AppColors.availableSeat;
        break;
      case SeatStatus.selected:
        color = AppColors.selectedSeat;
        break;
      case SeatStatus.occupied:
        color = AppColors.occupiedSeat;
        break;
    }

    return GestureDetector(
      onTap: seat.status == SeatStatus.occupied
          ? null
          : onTap,
      child: Container(
        width: 27,
        height: 25,
        margin: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(7),
          ),
          border: Border.all(
            color: seat.status == SeatStatus.selected
                ? Colors.white24
                : Colors.transparent,
          ),
        ),
        child: seat.status == SeatStatus.selected
            ? const Icon(
          Icons.check,
          color: Colors.white,
          size: 13,
        )
            : null,
      ),
    );
  }
}