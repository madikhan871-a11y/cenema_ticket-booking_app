import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../data/movie_data.dart';
import '../../models/movie.dart';
import '../../widgets/bottom_nav.dart';
import '../../widgets/genre_chip.dart';
import '../../widgets/movie_card.dart';
import '../movie_details/movie_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() =>
      _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  String selectedGenre = 'All';

  final genres = [
    'All',
    'Action',
    'Drama',
    'Sci-Fi',
    'Adventure',
  ];

  List<Movie> get filteredMovies {
    if (selectedGenre == 'All') {
      return MovieData.movies;
    }

    return MovieData.movies.where((movie) {
      return movie.genre
          .toLowerCase()
          .contains(selectedGenre.toLowerCase());
    }).toList();
  }

  void openMovie(Movie movie) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MovieDetailsScreen(
          movie: movie,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(
                20,
                18,
                20,
                0,
              ),
              sliver: SliverToBoxAdapter(
                child: _header(),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(
                20,
                25,
                20,
                0,
              ),
              sliver: SliverToBoxAdapter(
                child: _hero(),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(
                20,
                25,
                20,
                0,
              ),
              sliver: SliverToBoxAdapter(
                child: _title(
                  'Explore Movies',
                  'See all',
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: _genres(),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(
                20,
                18,
                20,
                30,
              ),
              sliver: SliverGrid(
                delegate:
                SliverChildBuilderDelegate(
                      (context, index) {
                    final movie =
                    filteredMovies[index];

                    return MovieCard(
                      movie: movie,
                      onTap: () => openMovie(movie),
                    );
                  },
                  childCount: filteredMovies.length,
                ),
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: .68,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CinemaBottomNav(
        currentIndex: currentIndex,
        onChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }

  Widget _header() {
    return Row(
      children: [
        Container(
          width: 45,
          height: 45,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(14),
          ),
          child: const Icon(
            Icons.movie_creation_outlined,
            color: Colors.white,
          ),
        ),
        const SizedBox(width: 12),
        const Expanded(
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome back',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 10,
                ),
              ),
              SizedBox(height: 3),
              Text(
                'CineVerse',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ),
        Container(
          width: 43,
          height: 43,
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(13),
          ),
          child: const Icon(
            Icons.location_on_outlined,
            color: AppColors.primary,
            size: 20,
          ),
        ),
      ],
    );
  }

  Widget _hero() {
    return Container(
      height: 215,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF44151B),
            Color(0xFF1D1020),
          ],
        ),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: AppColors.border,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -15,
            bottom: -25,
            child: Text(
              '🎬',
              style: TextStyle(
                fontSize: 150,
                color: Colors.white.withValues(
                  alpha: .08,
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              Container(
                padding:
                const EdgeInsets.symmetric(
                  horizontal: 9,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius:
                  BorderRadius.circular(8),
                ),
                child: const Text(
                  'NOW SHOWING',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
              ),
              const SizedBox(height: 13),
              const Text(
                'Shadow Protocol',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Action • Thriller   |   2h 18m',
                style: TextStyle(
                  color: Colors.white60,
                  fontSize: 10,
                ),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () =>
                    openMovie(MovieData.movies.first),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: AppColors.primary,
                  elevation: 0,
                  padding:
                  const EdgeInsets.symmetric(
                    horizontal: 17,
                    vertical: 10,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(11),
                  ),
                ),
                child: const Text(
                  'Book Tickets',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _genres() {
    return SizedBox(
      height: 55,
      child: ListView.builder(
        padding: const EdgeInsets.fromLTRB(
          20,
          12,
          20,
          0,
        ),
        scrollDirection: Axis.horizontal,
        itemCount: genres.length,
        itemBuilder: (context, index) {
          final genre = genres[index];

          return GenreChip(
            title: genre,
            selected: selectedGenre == genre,
            onTap: () {
              setState(() {
                selectedGenre = genre;
              });
            },
          );
        },
      ),
    );
  }

  Widget _title(String title, String trailing) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 19,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        Text(
          trailing,
          style: const TextStyle(
            color: AppColors.primary,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
