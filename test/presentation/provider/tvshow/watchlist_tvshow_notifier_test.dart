import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/tvshow/get_watchlist_tvshow.dart';
import 'package:ditonton/presentation/provider/TvShow/watchlist_TvShow_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/TvShow/dummy_TvShow_objects.dart';
import 'watchlist_tvshow_notifier_test.mocks.dart';

@GenerateMocks([GetWatchlistTvShow])
void main() {
  late WatchlistTvShowNotifier provider;
  late MockGetWatchlistTvShow mockGetWatchlistTvShows;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetWatchlistTvShows = MockGetWatchlistTvShow();
    provider = WatchlistTvShowNotifier(
      getWatchlistTvShows: mockGetWatchlistTvShows,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  test('should change TvShows data when data is gotten successfully', () async {
    // arrange
    when(mockGetWatchlistTvShows.execute())
        .thenAnswer((_) async => Right([testWatchlistTvShow]));
    // act
    await provider.fetchWatchlistTvShows();
    // assert
    expect(provider.watchlistState, RequestState.Loaded);
    expect(provider.watchlistTvShows, [testWatchlistTvShow]);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetWatchlistTvShows.execute())
        .thenAnswer((_) async => Left(DatabaseFailure("Can't get data")));
    // act
    await provider.fetchWatchlistTvShows();
    // assert
    expect(provider.watchlistState, RequestState.Error);
    expect(provider.message, "Can't get data");
    expect(listenerCallCount, 2);
  });
}
