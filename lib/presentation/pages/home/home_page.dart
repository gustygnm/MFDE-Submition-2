import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/movie/movie.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/presentation/cubit/movie/movie_now_playing_cubit.dart';
import 'package:ditonton/presentation/cubit/movie/movie_popular_cubit.dart';
import 'package:ditonton/presentation/cubit/movie/movie_top_rated_cubit.dart';
import 'package:ditonton/presentation/cubit/tv/tv_now_playing_cubit.dart';
import 'package:ditonton/presentation/cubit/tv/tv_popular_cubit.dart';
import 'package:ditonton/presentation/cubit/tv/tv_top_rated_cubit.dart';
import 'package:ditonton/presentation/pages/about/about_page.dart';
import 'package:ditonton/presentation/pages/movie/movie_detail_page.dart';
import 'package:ditonton/presentation/pages/movie/popular_movies_page.dart';
import 'package:ditonton/presentation/pages/tv/nowplaying_tv_page.dart';
import 'package:ditonton/presentation/pages/tv/popular_tv_page.dart';
import 'package:ditonton/presentation/pages/search/search_page.dart';
import 'package:ditonton/presentation/pages/movie/top_rated_movies_page.dart';
import 'package:ditonton/presentation/pages/tv/top_rated_tv_page.dart';
import 'package:ditonton/presentation/pages/tv/tv_detail_page.dart';
import 'package:ditonton/presentation/pages/movie/watchlist_movies_page.dart';
import 'package:ditonton/presentation/pages/tv/watchlist_tv_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../movie/nowplaying_movies_page.dart';
import '../tv/nowplaying_tv_page.dart';

class HomeMoviePage extends StatefulWidget {
  const HomeMoviePage({Key? key}) : super(key: key);

  @override
  _HomeMoviePageState createState() => _HomeMoviePageState();
}

class _HomeMoviePageState extends State<HomeMoviePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<MovieNowPlayingCubit>().get();
      context.read<MoviePopularCubit>().get();
      context.read<MovieTopRatedCubit>().get();
    });

    Future.microtask(() {
      context.read<TVNowPlayingCubit>().get();
      context.read<TVPopularCubit>().get();
      context.read<TVTopRatedCubit>().get();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            const UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
              ),
              accountName: Text('Ditonton'),
              accountEmail: Text('ditonton@dicoding.com'),
            ),
            ListTile(
              leading: const Icon(Icons.save_alt),
              title: const Text('TV Watchlist'),
              onTap: () {
                Navigator.pushNamed(context, WatchlistTVPage.routeName);
              },
            ),
            ListTile(
              leading: const Icon(Icons.save_alt),
              title: const Text('Movie Watchlist'),
              onTap: () {
                Navigator.pushNamed(context, WatchlistMoviesPage.routeName);
              },
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, AboutPage.routeName);
              },
              leading: const Icon(Icons.info_outline),
              title: const Text('About'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Ditonton'),
        actions: [
          IconButton(
            onPressed: () {
              // FirebaseCrashlytics.instance.crash();
              Navigator.pushNamed(context, SearchPage.routeName);
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //TV Area
              _buildSubHeading(
                title: 'Now Playing TV Series',
                onTap: () =>
                    Navigator.pushNamed(context, NowplayingTVPage.routeName),
              ),
              BlocBuilder<TVNowPlayingCubit, TVNowPlayingState>(
                builder: (context, state) {
                  if (state is TVNowPlayingLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is TVNowPlayingLoadedState) {
                    return TVList(tv: state.items);
                  } else if (state is TVNowPlayingErrorState) {
                    return Center(child: Text(state.message));
                  } else {
                    return const SizedBox();
                  }
                },
              ),
              _buildSubHeading(
                title: 'Popular TV Series',
                onTap: () =>
                    Navigator.pushNamed(context, PopularTVPage.routeName),
              ),
              BlocBuilder<TVNowPlayingCubit, TVNowPlayingState>(
                builder: (context, state) {
                  if (state is TVNowPlayingLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is TVNowPlayingLoadedState) {
                    return TVList(tv: state.items);
                  } else if (state is TVNowPlayingErrorState) {
                    return Center(child: Text(state.message));
                  } else {
                    return const SizedBox();
                  }
                },
              ),
              _buildSubHeading(
                title: 'Top Rated TV Series',
                onTap: () =>
                    Navigator.pushNamed(context, TopRatedTVPage.routeName),
              ),
              BlocBuilder<TVTopRatedCubit, TVTopRatedState>(
                builder: (context, state) {
                  if (state is TVTopRatedLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is TVTopRatedLoadedState) {
                    return TVList(tv: state.items);
                  } else if (state is TVTopRatedErrorState) {
                    return Center(child: Text(state.message));
                  } else {
                    return const SizedBox();
                  }
                },
              ),
              //End TV Area
              _buildSubHeading(
                title: 'Now Playing Movies',
                onTap: () => Navigator.pushNamed(
                    context, NowplayingMoviePage.routeName),
              ),
              BlocBuilder<MovieNowPlayingCubit, MovieNowPlayingState>(
                builder: (context, state) {
                  if (state is MovieNowPlayingLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is MovieNowPlayingLoadedState) {
                    return MovieList(movies: state.items);
                  } else if (state is MovieNowPlayingErrorState) {
                    return Center(child: Text(state.message));
                  } else {
                    return const SizedBox();
                  }
                },
              ),
              _buildSubHeading(
                title: 'Popular Movies',
                onTap: () =>
                    Navigator.pushNamed(context, PopularMoviesPage.routeName),
              ),

              BlocBuilder<MoviePopularCubit, MoviePopularState>(
                builder: (context, state) {
                  if (state is MoviePopularLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is MoviePopularLoadedState) {
                    return MovieList(movies: state.items);
                  } else if (state is MoviePopularErrorState) {
                    return Center(child: Text(state.message));
                  } else {
                    return const SizedBox();
                  }
                },
              ),
              _buildSubHeading(
                title: 'Top Rated Movies',
                onTap: () => Navigator.pushNamed(
                    context, TopRatedMoviesPage.routeName),
              ),
              BlocBuilder<MovieTopRatedCubit, MovieTopRatedState>(
                builder: (context, state) {
                  if (state is MovieTopRatedLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is MovieTopRatedLoadedState) {
                    return MovieList(movies: state.items);
                  } else if (state is MovieTopRatedErrorState) {
                    return Center(child: Text(state.message));
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: const [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  const MovieList({Key? key, required this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  MovieDetailPage.routeName,
                  arguments: movie.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$baseImageurl${movie.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}

class TVList extends StatelessWidget {
  final List<TV> tv;

  const TVList({Key? key, required this.tv}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = tv[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TVDetailPage.routeName,
                  arguments: movie.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$baseImageurl${movie.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tv.length,
      ),
    );
  }
}
