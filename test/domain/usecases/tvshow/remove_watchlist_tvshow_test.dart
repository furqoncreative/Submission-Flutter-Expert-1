import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/movie/remove_watchlist_movie.dart';
import 'package:ditonton/domain/usecases/tvshow/remove_watchlist_tvshow.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/movie/dummy_movie_objects.dart';
import '../../../dummy_data/tvshow/dummy_tvshow_objects.dart';
import '../../../helpers/test_helper_movie.mocks.dart';
import '../../../helpers/test_helper_tvshow.mocks.dart';

void main() {
  late RemoveWatchlistTvShow usecase;
  late MockTvShowRepository mockTvShowRepository;

  setUp(() {
    mockTvShowRepository = MockTvShowRepository();
    usecase = RemoveWatchlistTvShow(mockTvShowRepository);
  });

  test('should remove watchlist TvShow from repository', () async {
    // arrange
    when(mockTvShowRepository.removeWatchlistTvShow(testTvShowDetail))
        .thenAnswer((_) async => Right('Removed from watchlist'));
    // act
    final result = await usecase.execute(testTvShowDetail);
    // assert
    verify(mockTvShowRepository.removeWatchlistTvShow(testTvShowDetail));
    expect(result, Right('Removed from watchlist'));
  });
}
