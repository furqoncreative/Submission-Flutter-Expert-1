import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tvshow/tvshow.dart';
import 'package:ditonton/domain/usecases/tvshow/get_on_the_air_tvshow.dart';
import 'package:flutter/foundation.dart';

class OnTheAirTvShowsNotifier extends ChangeNotifier {
  final GetOnTheAirTvShow getOnTheAirTvShows;

  OnTheAirTvShowsNotifier(this.getOnTheAirTvShows);

  RequestState _state = RequestState.Empty;

  RequestState get state => _state;

  List<TvShow> _tvShows = [];

  List<TvShow> get tvShows => _tvShows;

  String _message = '';

  String get message => _message;

  Future<void> fetchOnTheAirTvShows() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getOnTheAirTvShows.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (tvShowsData) {
        _tvShows = tvShowsData;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
