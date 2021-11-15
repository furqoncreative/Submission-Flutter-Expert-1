import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tvshow/tvshow.dart';
import 'package:ditonton/domain/usecases/tvshow/search_tvshow.dart';
import 'package:ditonton/presentation/provider/TvShow/TvShow_search_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tvshow_search_notifier_test.mocks.dart';

@GenerateMocks([SearchTvShow])
void main() {
  late TvShowSearchNotifier provider;
  late MockSearchTvShow mockSearchTvShows;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockSearchTvShows = MockSearchTvShow();
    provider = TvShowSearchNotifier(searchTvShows: mockSearchTvShows)
      ..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tTvShowModel = TvShow(
      backdropPath: "/xAKMj134XHQVNHLC6rWsccLMenG.jpg",
      firstAirDate: "2021-10-12",
      genreIds: [10765, 35, 80],
      id: 90462,
      name: "Chucky",
      originalName: "Chucky",
      overview:
          "After a vintage Chucky doll turns up at a suburban yard sale, an idyllic American town is thrown into chaos as a series of horrifying murders begin to expose the town’s hypocrisies and secrets. Meanwhile, the arrival of enemies — and allies — from Chucky’s past threatens to expose the truth behind the killings, as well as the demon doll’s untold origins.",
      popularity: 6858.77,
      posterPath: "/iF8ai2QLNiHV4anwY1TuSGZXqfN.jpg",
      voteAverage: 8,
      voteCount: 1418);

  final tTvShowList = <TvShow>[tTvShowModel];
  final tQuery = 'spiderman';

  group('search TvShows', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockSearchTvShows.execute(tQuery))
          .thenAnswer((_) async => Right(tTvShowList));
      // act
      provider.fetchTvShowSearch(tQuery);
      // assert
      expect(provider.state, RequestState.Loading);
    });

    test('should change search result data when data is gotten successfully',
        () async {
      // arrange
      when(mockSearchTvShows.execute(tQuery))
          .thenAnswer((_) async => Right(tTvShowList));
      // act
      await provider.fetchTvShowSearch(tQuery);
      // assert
      expect(provider.state, RequestState.Loaded);
      expect(provider.searchResult, tTvShowList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockSearchTvShows.execute(tQuery))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTvShowSearch(tQuery);
      // assert
      expect(provider.state, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
