import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/movie/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/tvshow/get_watchlist_tvshow.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/movie/dummy_movie_objects.dart';
import '../../../dummy_data/tvshow/dummy_tvshow_objects.dart';
import '../../../helpers/test_helper_movie.mocks.dart';
import '../../../helpers/test_helper_tvshow.mocks.dart';

void main() {
  late GetWatchlistTvShow usecase;
  late MockTvShowRepository mockTvShowRepository;

  setUp(() {
    mockTvShowRepository = MockTvShowRepository();
    usecase = GetWatchlistTvShow(mockTvShowRepository);
  });

  test('should get list of TvShows from the repository', () async {
    // arrange
    when(mockTvShowRepository.getWatchlistTvShow())
        .thenAnswer((_) async => Right(testTvShowList));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(testTvShowList));
  });
}
