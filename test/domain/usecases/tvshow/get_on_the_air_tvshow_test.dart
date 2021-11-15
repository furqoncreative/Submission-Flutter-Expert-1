import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/movie/movie.dart';
import 'package:ditonton/domain/entities/tvshow/tvshow.dart';
import 'package:ditonton/domain/usecases/movie/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecases/tvshow/get_on_the_air_tvshow.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper_movie.mocks.dart';
import '../../../helpers/test_helper_tvshow.mocks.dart';


void main() {
  late GetOnTheAirTvShow usecase;
  late MockTvShowRepository mockTvShowRepository;

  setUp(() {
    mockTvShowRepository = MockTvShowRepository();
    usecase = GetOnTheAirTvShow(mockTvShowRepository);
  });

  final tTvShows = <TvShow>[];

  test('should get list of TvShows from the repository', () async {
    // arrange
    when(mockTvShowRepository.getOnTheAirTvShow())
        .thenAnswer((_) async => Right(tTvShows));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tTvShows));
  });
}
