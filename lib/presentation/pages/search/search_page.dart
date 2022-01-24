import 'package:ditonton/common/constants.dart';
import 'package:ditonton/presentation/cubit/movie/movie_search_cubit.dart';
import 'package:ditonton/presentation/cubit/tv/tv_search_cubit.dart';
import 'package:ditonton/presentation/widgets/card/movie_card_list.dart';
import 'package:ditonton/presentation/widgets/card/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatefulWidget {
  static const routeName = '/search';

  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String? searchoption;
  bool _isVisibleTv = true;
  bool _isVisibleMovie = false;

  void showTv() {
    setState(() {
      _isVisibleTv = true;
      _isVisibleMovie = false;
    });
  }

  void showMovie() {
    setState(() {
      _isVisibleMovie = true;
      _isVisibleTv = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onSubmitted: (query) async {
                await context.read<MovieSearchCubit>().get(query);
                showMovie();
              },
              decoration: const InputDecoration(
                hintText: 'Search movie',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            const SizedBox(height: 16),
            TextField(
              onSubmitted: (query) async {
                await context.read<TVSearchCubit>().get(query);
                showTv();
              },
              decoration: const InputDecoration(
                hintText: 'Search tv',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            const SizedBox(height: 16),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            Visibility(
              visible: _isVisibleTv,
              child: BlocBuilder<TVSearchCubit, TVSearchState>(
                builder: (context, state) {
                  if (state is TVSearhLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is TVSearchLoadedState) {
                    return Expanded(
                        child: ListView.builder(
                      itemBuilder: (context, index) {
                        final tv = state.items[index];
                        return TVCard(tv: tv);
                      },
                      itemCount: state.items.length,
                    ));
                  } else if (state is TVSearchErrorState) {
                    return Center(
                      key: const Key('error_message'),
                      child: Text(state.message),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ),
            Visibility(
              visible: _isVisibleMovie,
              child: BlocBuilder<MovieSearchCubit, MovieSearchState>(
                builder: (context, state) {
                  if (state is MovieSearhLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is MovieSearchLoadedState) {
                    return Expanded(
                        child: ListView.builder(
                      itemBuilder: (context, index) {
                        final movie = state.items[index];
                        return MovieCard(movie: movie);
                      },
                      itemCount: state.items.length,
                    ));
                  } else if (state is MovieSearchErrorState) {
                    return Center(
                      key: const Key('error_message'),
                      child: Text(state.message),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
