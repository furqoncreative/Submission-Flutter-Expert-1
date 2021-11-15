import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/movie/movie.dart';
import 'package:ditonton/domain/entities/tvshow/tvshow.dart';
import 'package:ditonton/domain/usecases/movie/search_movies.dart';
import 'package:ditonton/domain/usecases/tvshow/search_tvshow.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper_movie.mocks.dart';
import '../../../helpers/test_helper_tvshow.mocks.dart';

void main() {
  late SearchTvShow usecase;
  late MockTvShowRepository mockTvShowRepository;

  setUp(() {
    mockTvShowRepository = MockTvShowRepository();
    usecase = SearchTvShow(mockTvShowRepository);
  });

  final tTvShows = <TvShow>[];
  final tQuery = 'Chucky';

  test('should get list of TvShows from the repository', () async {
    // arrange
    when(mockTvShowRepository.searchTvShow(tQuery))
        .thenAnswer((_) async => Right(tTvShows));
    // act
    final result = await usecase.execute(tQuery);
    // assert
    expect(result, Right(tTvShows));
  });
}
