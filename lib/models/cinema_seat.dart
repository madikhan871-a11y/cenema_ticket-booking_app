enum SeatStatus {
  available,
  selected,
  occupied,
}

class CinemaSeat {
  final String id;
  final int row;
  final int number;
  SeatStatus status;

  CinemaSeat({
    required this.id,
    required this.row,
    required this.number,
    this.status = SeatStatus.available,
  });
}