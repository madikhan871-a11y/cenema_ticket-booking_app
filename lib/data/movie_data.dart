import '../models/movie.dart';
import '../models/movie_show.dart';

class MovieData {
  static const movies = [
    Movie(
      id: '1',
      title: 'Shadow Protocol',
      genre: 'Action • Thriller',
      duration: '2h 18m',
      rating: '16+',
      poster: '🎬',
      score: 8.9,
      description:
      'An elite agent races against time to stop a global threat before the city falls into chaos.',
    ),
    Movie(
      id: '2',
      title: 'Midnight Echo',
      genre: 'Mystery • Drama',
      duration: '1h 56m',
      rating: '13+',
      poster: '🌙',
      score: 8.5,
      description:
      'A mysterious message leads a young journalist into a hidden world of secrets.',
    ),
    Movie(
      id: '3',
      title: 'Neon City',
      genre: 'Sci-Fi',
      duration: '2h 05m',
      rating: '13+',
      poster: '🌆',
      score: 9.1,
      description:
      'In a futuristic city, one hacker discovers a secret that could change humanity forever.',
    ),
    Movie(
      id: '4',
      title: 'The Last Journey',
      genre: 'Adventure',
      duration: '2h 21m',
      rating: 'PG',
      poster: '🏔️',
      score: 8.7,
      description:
      'A breathtaking journey across unknown lands where courage becomes the only way forward.',
    ),
  ];

  static const shows = [
    MovieShow(
      time: '02:30 PM',
      hall: 'Hall 01',
      format: '2D',
      price: 8.50,
    ),
    MovieShow(
      time: '05:15 PM',
      hall: 'Hall 03',
      format: 'IMAX',
      price: 12.00,
    ),
    MovieShow(
      time: '08:45 PM',
      hall: 'Hall 02',
      format: '2D',
      price: 9.50,
    ),
    MovieShow(
      time: '11:30 PM',
      hall: 'Hall 04',
      format: '3D',
      price: 11.00,
    ),
  ];
}