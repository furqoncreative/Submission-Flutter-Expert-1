import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tvshow/tvshow.dart';
import 'package:ditonton/domain/usecases/tvshow/get_on_the_air_tvshow.dart';
import 'package:ditonton/domain/usecases/tvshow/get_popular_tvshow.dart';
import 'package:ditonton/domain/usecases/tvshow/get_top_rated_tvshow.dart';
import 'package:flutter/material.dart';

class TvShowListNotifier extends ChangeNotifier {
  var _onTheAirTvShows = <TvShow>[];

  List<TvShow> get onTheAirTvShows => _onTheAirTvShows;

  RequestState _onTheAirTvShowState = RequestState.Empty;

  RequestState get onTheAirTvShowState => _onTheAirTvShowState;

  var _popularTvShows = <TvShow>[];

  List<TvShow> get popularTvShows => _popularTvShows;

  RequestState _popularTvShowsState = RequestState.Empty;

  RequestState get popularTvShowsState => _popularTvShowsState;

  var _topRatedTvShows = <TvShow>[];

  List<TvShow> get topRatedTvShows => _topRatedTvShows;

  RequestState _topRatedTvShowsState = RequestState.Empty;

  RequestState get topRatedTvShowsState => _topRatedTvShowsState;

  String _message = '';

  String get message => _message;

  TvShowListNotifier({
    required this.getOnTheAirTvShow,
    required this.getPopularTvShows,
    required this.getTopRatedTvShows,
  });

  final GetOnTheAirTvShow getOnTheAirTvShow;
  final GetPopularTvShow getPopularTvShows;
  final GetTopRatedTvShow getTopRatedTvShows;

  Future<void> fetchOnTheAirTvShows() async {
    _onTheAirTvShowState = RequestState.Loading;
    notifyListeners();

    final result = await getOnTheAirTvShow.execute();
    result.fold(
      (failure) {
        _onTheAirTvShowState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvShowsData) {
        _onTheAirTvShowState = RequestState.Loaded;
        _onTheAirTvShows = tvShowsData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchPopularTvShows() async {
    _popularTvShowsState = RequestState.Loading;
    notifyListeners();

    final result = await getPopularTvShows.execute();
    result.fold(
      (failure) {
        _popularTvShowsState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvShowsData) {
        _popularTvShowsState = RequestState.Loaded;
        _popularTvShows = tvShowsData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTopRatedTvShows() async {
    _topRatedTvShowsState = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedTvShows.execute();
    result.fold(
      (failure) {
        _topRatedTvShowsState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvShowsData) {
        _topRatedTvShowsState = RequestState.Loaded;
        _topRatedTvShows = tvShowsData;
        notifyListeners();
      },
    );
  }
}
