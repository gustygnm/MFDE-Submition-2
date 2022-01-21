import 'package:ditonton/domain/entities/genre.dart';
import 'package:equatable/equatable.dart';

class TVDetail extends Equatable {
  TVDetail({
    required this.backdropPath,
    required this.firstAirDate,
    required this.genres,
    required this.id,
    required this.originalName,
    required this.name,
    required this.originalLanguage,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.voteAverage,
    required this.voteCount
  });

  String? backdropPath;
  String firstAirDate;
  List<Genre> genres;
  int id;
  String originalName;
  String name;
  String originalLanguage;
  String overview;
  double popularity;
  String posterPath;
  double voteAverage;
  int? voteCount;

  @override
  List<Object?> get props => [
        backdropPath,
        firstAirDate,
        genres,
        id,
        originalName,
        name,
        originalLanguage,
        overview,
        popularity,
        posterPath,
        voteAverage,
        voteCount
      ];
}
