import 'package:ditonton/domain/usecases/movie/get_watchlist_movie_status.dart';
import 'package:ditonton/domain/usecases/tvshow/get_watchlist_tvshow_status.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper_movie.mocks.dart';
import '../../../helpers/test_helper_tvshow.mocks.dart';

void main() {
  late GetWatchListTvShowStatus usecase;
  late MockTvShowRepository mockTvShowRepository;

  setUp(() {
    mockTvShowRepository = MockTvShowRepository();
    usecase = GetWatchListTvShowStatus(mockTvShowRepository);
  });

  test('should get watchlist status from repository', () async {
    // arrange
    when(mockTvShowRepository.isAddedToWatchlistTvShow(1))
        .thenAnswer((_) async => true);
    // act
    final result = await usecase.execute(1);
    // assert
    expect(result, true);
  });
}
