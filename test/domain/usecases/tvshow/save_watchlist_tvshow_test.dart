import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/movie/save_watchlist_movie.dart';
import 'package:ditonton/domain/usecases/tvshow/save_watchlist_tvshow.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/movie/dummy_movie_objects.dart';
import '../../../dummy_data/tvshow/dummy_tvshow_objects.dart';
import '../../../helpers/test_helper_movie.mocks.dart';
import '../../../helpers/test_helper_tvshow.mocks.dart';

void main() {
  late SaveWatchlistTvShow usecase;
  late MockTvShowRepository mockTvShowRepository;

  setUp(() {
    mockTvShowRepository = MockTvShowRepository();
    usecase = SaveWatchlistTvShow(mockTvShowRepository);
  });

  test('should save TvShow to the repository', () async {
    // arrange
    when(mockTvShowRepository.saveWatchlistTvShow(testTvShowDetail))
        .thenAnswer((_) async => Right('Added to Watchlist'));
    // act
    final result = await usecase.execute(testTvShowDetail);
    // assert
    verify(mockTvShowRepository.saveWatchlistTvShow(testTvShowDetail));
    expect(result, Right('Added to Watchlist'));
  });
}
