import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/tv/nowplay_tv_notifier.dart';
import 'package:ditonton/presentation/widgets/card/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NowplayingTVPage extends StatefulWidget {
  static const routeName = '/playing-tv';

  const NowplayingTVPage({Key? key}) : super(key: key);

  @override
  _NowplayingTVPageState createState() => _NowplayingTVPageState();
}

class _NowplayingTVPageState extends State<NowplayingTVPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<NowPlayTVNotifier>(context, listen: false)
            .fetchNowPlayingtv());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Now Playing TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<NowPlayTVNotifier>(
          builder: (context, data, child) {
            if (data.state == RequestState.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.state == RequestState.loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = data.tv[index];
                  return TVCard(tv);
                },
                itemCount: data.tv.length,
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
