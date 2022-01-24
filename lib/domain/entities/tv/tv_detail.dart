import 'package:ditonton/domain/entities/genre.dart';
import 'package:equatable/equatable.dart';

class TVDetail extends Equatable {
  const TVDetail({
    this.backdropPath,
    this.firstAirDate='',
    this.genres=const[],
    this.id=0,
    this.originalName='',
    this.name='',
    this.originalLanguage='',
    this.overview='',
    this.popularity=0,
    this.posterPath='',
    this.voteAverage=0,
    this.voteCount
  });

  final String? backdropPath;
  final String firstAirDate;
  final List<Genre> genres;
  final int id;
  final String originalName;
  final String name;
  final String originalLanguage;
  final String overview;
  final double popularity;
  final String posterPath;
  final double voteAverage;
  final int? voteCount;

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
