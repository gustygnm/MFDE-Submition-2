import 'package:ditonton/domain/entities/movie/movie.dart';
import 'package:ditonton/domain/usecases/movie/get_movie_recommendations.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part './movie_recommendations_state.dart';

class MovieRecommendationsCubit extends Cubit<MovieRecommendationsState> {
  MovieRecommendationsCubit({
    required this.getMovieRecommendations,
  }) : super(const MovieRecommendationsInitialState());
  final GetMovieRecommendations getMovieRecommendations;

  Future<void> get(int id) async {
    emit(const MovieRecommendationsLoadingState());
    final result = await getMovieRecommendations.execute(id);
    result.fold(
      (failure) => emit(MovieRecommendationsErrorState(failure.message)),
      (values) => emit(MovieRecommendationsLoadedState(items: values)),
    );
  }
}
