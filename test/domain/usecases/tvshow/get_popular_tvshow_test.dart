import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tvshow/tvshow.dart';

import 'package:ditonton/domain/usecases/tvshow/get_popular_tvshow.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper_tvshow.mocks.dart';

void main() {
  late GetPopularTvShow usecase;
  late MockTvShowRepository mockTvShowRepository;

  setUp(() {
    mockTvShowRepository = MockTvShowRepository();
    usecase = GetPopularTvShow(mockTvShowRepository);
  });

  final tTvShow = <TvShow>[];

  group('GetPopularTvShow Tests', () {
    group('execute', () {
      test(
          'should get list of TvShow from the repository when execute function is called',
          () async {
        // arrange
        when(mockTvShowRepository.getPopularTvShow())
            .thenAnswer((_) async => Right(tTvShow));
        // act
        final result = await usecase.execute();
        // assert
        expect(result, Right(tTvShow));
      });
    });
  });
}
