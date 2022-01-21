import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/movie/nowplay_movie_notifier.dart';
import 'package:ditonton/presentation/widgets/card/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NowplayingMoviePage extends StatefulWidget {
  static const routeName = '/playing-movie';

  const NowplayingMoviePage({Key? key}) : super(key: key);

  @override
  _NowplayingMoviePageState createState() => _NowplayingMoviePageState();
}

class _NowplayingMoviePageState extends State<NowplayingMoviePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<NowPlayMovieNotifier>(context, listen: false)
            .fetchNowPlayingovies());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Now Playing Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<NowPlayMovieNotifier>(
          builder: (context, data, child) {
            if (data.state == RequestState.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.state == RequestState.loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = data.movies[index];
                  return MovieCard(movie);
                },
                itemCount: data.movies.length,
              );
            } else {
              return Center(
                key: const Key('error_message'),
                child: Text(data.message),
              );
            }
          },
        ),
      ),
    );
  }
}
