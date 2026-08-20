import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../data/movie_data.dart';
import '../../models/movie.dart';
import '../../widgets/showtime_chip.dart';
import '../seat_selection/seat_selection_screen.dart';

class MovieDetailsScreen extends StatefulWidget {
  final Movie movie;

  const MovieDetailsScreen({
    super.key,
    required this.movie,
  });

  @override
  State<MovieDetailsScreen> createState() =>
      _MovieDetailsScreenState();
}

class _MovieDetailsScreenState
    extends State<MovieDetailsScreen> {
  int selectedShow = 0;

  @override
  Widget build(BuildContext context) {
    final movie = widget.movie;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Movie Details'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.favorite_border_rounded,
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(
          20,
          10,
          20,
          30,
        ),
        children: [
          Container(
            height: 270,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF44151B),
                  Color(0xFF17111D),
                ],
              ),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Center(
              child: Text(
                movie.poster,
                style: const TextStyle(
                  fontSize: 110,
                ),
              ),
            ),
          ),
          const SizedBox(height: 22),
          Text(
            movie.title,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 27,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              _info(movie.genre),
              _dot(),
              _info(movie.duration),
              _dot(),
              _info(movie.rating),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              const Icon(
                Icons.star_rounded,
                color: AppColors.gold,
                size: 21,
              ),
              const SizedBox(width: 5),
              Text(
                '${movie.score} / 10',
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          const Text(
            'Synopsis',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            movie.description,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 11,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 25),
          const Text(
            'Choose Showtime',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 65,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: MovieData.shows.length,
              itemBuilder: (context, index) {
                final show = MovieData.shows[index];

                return ShowtimeChip(
                  time: show.time,
                  format: show.format,
                  selected: selectedShow == index,
                  onTap: () {
                    setState(() {
                      selectedShow = index;
                    });
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 25),
          SizedBox(
            height: 55,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        SeatSelectionScreen(
                          movie: movie,
                          show: MovieData.shows[selectedShow],
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
                'Select Seats  →',
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

  Widget _info(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: AppColors.textSecondary,
        fontSize: 9,
      ),
    );
  }

  Widget _dot() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 7),
      child: Text(
        '•',
        style: TextStyle(
          color: AppColors.primary,
        ),
      ),
    );
  }
}