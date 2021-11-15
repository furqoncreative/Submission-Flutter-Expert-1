import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tvshow/tvshow.dart';
import 'package:ditonton/domain/usecases/tvshow/get_on_the_air_tvshow.dart';
import 'package:ditonton/domain/usecases/tvshow/get_popular_tvshow.dart';
import 'package:ditonton/domain/usecases/tvshow/get_top_rated_tvshow.dart';
import 'package:ditonton/presentation/provider/TvShow/TvShow_list_notifier.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tvshow_list_notifier_test.mocks.dart';

@GenerateMocks([GetOnTheAirTvShow, GetPopularTvShow, GetTopRatedTvShow])
void main() {
  late TvShowListNotifier provider;
  late MockGetOnTheAirTvShow mockGetOnTheAirTvShow;
  late MockGetPopularTvShow mockGetPopularTvShows;
  late MockGetTopRatedTvShow mockGetTopRatedTvShows;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetOnTheAirTvShow = MockGetOnTheAirTvShow();
    mockGetPopularTvShows = MockGetPopularTvShow();
    mockGetTopRatedTvShows = MockGetTopRatedTvShow();
    provider = TvShowListNotifier(
      getOnTheAirTvShow: mockGetOnTheAirTvShow,
      getPopularTvShows: mockGetPopularTvShows,
      getTopRatedTvShows: mockGetTopRatedTvShows,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tTvShow = TvShow(
    backdropPath: 'backdropPath',
    firstAirDate: 'firstAirDate',
    genreIds: [1, 2, 3],
    id: 1,
    originalName: 'originalName',
    name: 'name',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    voteAverage: 1,
    voteCount: 1,
  );

  final tTvShowList = <TvShow>[tTvShow];

  group('now playing TvShows', () {
    test('initialState should be Empty', () {
      expect(provider.onTheAirTvShowState, equals(RequestState.Empty));
    });

    test('should get data from the usecase', () async {
      // arrange
      when(mockGetOnTheAirTvShow.execute())
          .thenAnswer((_) async => Right(tTvShowList));
      // act
      provider.fetchOnTheAirTvShows();
      // assert
      verify(mockGetOnTheAirTvShow.execute());
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      when(mockGetOnTheAirTvShow.execute())
          .thenAnswer((_) async => Right(tTvShowList));
      // act
      provider.fetchOnTheAirTvShows();
      // assert
      expect(provider.onTheAirTvShowState, RequestState.Loading);
    });

    test('should change TvShows when data is gotten successfully', () async {
      // arrange
      when(mockGetOnTheAirTvShow.execute())
          .thenAnswer((_) async => Right(tTvShowList));
      // act
      await provider.fetchOnTheAirTvShows();
      // assert
      expect(provider.onTheAirTvShowState, RequestState.Loaded);
      expect(provider.onTheAirTvShows, tTvShowList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetOnTheAirTvShow.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchOnTheAirTvShows();
      // assert
      expect(provider.onTheAirTvShowState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('popular TvShows', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetPopularTvShows.execute())
          .thenAnswer((_) async => Right(tTvShowList));
      // act
      provider.fetchPopularTvShows();
      // assert
      expect(provider.popularTvShowsState, RequestState.Loading);
      // verify(provider.setState(RequestState.Loading));
    });

    test('should change TvShows data when data is gotten successfully',
        () async {
      // arrange
      when(mockGetPopularTvShows.execute())
          .thenAnswer((_) async => Right(tTvShowList));
      // act
      await provider.fetchPopularTvShows();
      // assert
      expect(provider.popularTvShowsState, RequestState.Loaded);
      expect(provider.popularTvShows, tTvShowList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetPopularTvShows.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchPopularTvShows();
      // assert
      expect(provider.popularTvShowsState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('top rated TvShows', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetTopRatedTvShows.execute())
          .thenAnswer((_) async => Right(tTvShowList));
      // act
      provider.fetchTopRatedTvShows();
      // assert
      expect(provider.topRatedTvShowsState, RequestState.Loading);
    });

    test('should change TvShows data when data is gotten successfully',
        () async {
      // arrange
      when(mockGetTopRatedTvShows.execute())
          .thenAnswer((_) async => Right(tTvShowList));
      // act
      await provider.fetchTopRatedTvShows();
      // assert
      expect(provider.topRatedTvShowsState, RequestState.Loaded);
      expect(provider.topRatedTvShows, tTvShowList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTopRatedTvShows.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTopRatedTvShows();
      // assert
      expect(provider.topRatedTvShowsState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
