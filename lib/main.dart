import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/cubit/movie/movie_detail_cubit.dart';
import 'package:ditonton/presentation/cubit/movie/movie_now_playing_cubit.dart';
import 'package:ditonton/presentation/cubit/movie/movie_popular_cubit.dart';
import 'package:ditonton/presentation/cubit/movie/movie_recommendations_cubit.dart';
import 'package:ditonton/presentation/cubit/movie/movie_search_cubit.dart';
import 'package:ditonton/presentation/cubit/movie/movie_top_rated_cubit.dart';
import 'package:ditonton/presentation/cubit/movie/movie_watchlist_cubit.dart';
import 'package:ditonton/presentation/cubit/tv/tv_detail_cubit.dart';
import 'package:ditonton/presentation/cubit/tv/tv_now_playing_cubit.dart';
import 'package:ditonton/presentation/cubit/tv/tv_popular_cubit.dart';
import 'package:ditonton/presentation/cubit/tv/tv_recommendations_cubit.dart';
import 'package:ditonton/presentation/cubit/tv/tv_search_cubit.dart';
import 'package:ditonton/presentation/cubit/tv/tv_top_rated_cubit.dart';
import 'package:ditonton/presentation/cubit/tv/tv_watchlist_cubit.dart';
import 'package:ditonton/presentation/pages/about/about_page.dart';
import 'package:ditonton/presentation/pages/movie/movie_detail_page.dart';
import 'package:ditonton/presentation/pages/home/home_page.dart';
import 'package:ditonton/presentation/pages/movie/nowplaying_movies_page.dart';
import 'package:ditonton/presentation/pages/tv/nowplaying_tv_page.dart';
import 'package:ditonton/presentation/pages/movie/popular_movies_page.dart';
import 'package:ditonton/presentation/pages/tv/popular_tv_page.dart';
import 'package:ditonton/presentation/pages/search/search_page.dart';
import 'package:ditonton/presentation/pages/movie/top_rated_movies_page.dart';
import 'package:ditonton/presentation/pages/tv/top_rated_tv_page.dart';
import 'package:ditonton/presentation/pages/tv/tv_detail_page.dart';
import 'package:ditonton/presentation/pages/movie/watchlist_movies_page.dart';
import 'package:ditonton/presentation/pages/tv/watchlist_tv_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:ditonton/injection.dart' as di;

import 'common/http_ssl_pinning.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await HttpSSLPinning.init();
  await initializeDateFormatting();
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider<MovieWatchlistCubit>(
          create: (context) => di.locator<MovieWatchlistCubit>(),
        ),
        BlocProvider<MovieNowPlayingCubit>(
          create: (context) => di.locator<MovieNowPlayingCubit>(),
        ),
        BlocProvider<MoviePopularCubit>(
          create: (context) => di.locator<MoviePopularCubit>(),
        ),
        BlocProvider<MovieTopRatedCubit>(
          create: (context) => di.locator<MovieTopRatedCubit>(),
        ),
        BlocProvider<MovieRecommendationsCubit>(
          create: (context) => di.locator<MovieRecommendationsCubit>(),
        ),
        BlocProvider<MovieDetailCubit>(
          create: (context) => di.locator<MovieDetailCubit>(),
        ),
        //  TV Series
        BlocProvider<TVWatchlistCubit>(
          create: (context) => di.locator<TVWatchlistCubit>(),
        ),
        BlocProvider<TVNowPlayingCubit>(
          create: (context) => di.locator<TVNowPlayingCubit>(),
        ),
        BlocProvider<TVPopularCubit>(
          create: (context) => di.locator<TVPopularCubit>(),
        ),
        BlocProvider<TVTopRatedCubit>(
          create: (context) => di.locator<TVTopRatedCubit>(),
        ),
        BlocProvider<TVRecommendationsCubit>(
          create: (context) => di.locator<TVRecommendationsCubit>(),
        ),
        BlocProvider<TVDetailCubit>(
          create: (context) => di.locator<TVDetailCubit>(),
        ),
        BlocProvider<MovieSearchCubit>(
          create: (context) => di.locator<MovieSearchCubit>(),
        ),
        BlocProvider<TVSearchCubit>(
          create: (context) => di.locator<TVSearchCubit>(),
        ),
      ],
      child: MaterialApp(
        title: 'ditonton',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
          colorScheme: kColorScheme.copyWith(secondary: kMikadoYellow),
        ),
        home: const HomeMoviePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (_) => const HomeMoviePage());
            case TVDetailPage.routeName:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TVDetailPage(id: id),
                settings: settings,
              );
            case NowplayingTVPage.routeName:
              return CupertinoPageRoute(
                  builder: (_) => const NowplayingTVPage());
            case PopularTVPage.routeName:
              return CupertinoPageRoute(builder: (_) => const PopularTVPage());
            case TopRatedTVPage.routeName:
              return CupertinoPageRoute(builder: (_) => const TopRatedTVPage());
            case WatchlistTVPage.routeName:
              return MaterialPageRoute(builder: (_) => const WatchlistTVPage());
            case NowplayingMoviePage.routeName:
              return CupertinoPageRoute(
                  builder: (_) => const NowplayingMoviePage());
            case PopularMoviesPage.routeName:
              return CupertinoPageRoute(
                  builder: (_) => const PopularMoviesPage());
            case TopRatedMoviesPage.routeName:
              return CupertinoPageRoute(
                  builder: (_) => const TopRatedMoviesPage());
            case MovieDetailPage.routeName:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case SearchPage.routeName:
              return CupertinoPageRoute(builder: (_) => const SearchPage());
            case WatchlistMoviesPage.routeName:
              return MaterialPageRoute(
                  builder: (_) => const WatchlistMoviesPage());
            case AboutPage.routeName:
              return MaterialPageRoute(builder: (_) => const AboutPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return const Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
