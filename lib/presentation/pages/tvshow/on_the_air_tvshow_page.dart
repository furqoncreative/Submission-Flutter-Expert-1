import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/tvshow/on_the_air_tvshow_notifier.dart';
import 'package:ditonton/presentation/widgets/tvshow_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OnTheAirTvShowsPage extends StatefulWidget {
  static const ROUTE_NAME = '/on-the-air-tvshow';

  @override
  _OnTheAirTvShowsPageState createState() => _OnTheAirTvShowsPageState();
}

class _OnTheAirTvShowsPageState extends State<OnTheAirTvShowsPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<OnTheAirTvShowsNotifier>(context, listen: false)
            .fetchOnTheAirTvShows());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('On The Air Tv Shows'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<OnTheAirTvShowsNotifier>(
          builder: (context, data, child) {
            if (data.state == RequestState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.state == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvShow = data.tvShows[index];
                  return TvShowCard(tvShow);
                },
                itemCount: data.tvShows.length,
              );
            } else {
              return Center(
                key: Key('error_message'),
                child: Text(data.message),
              );
            }
          },
        ),
      ),
    );
  }
}
