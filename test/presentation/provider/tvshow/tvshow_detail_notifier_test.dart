import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tvshow/tvshow.dart';
import 'package:ditonton/domain/usecases/tvshow/get_tvshow_detail.dart';
import 'package:ditonton/domain/usecases/tvshow/get_tvshow_recommendations.dart';
import 'package:ditonton/domain/usecases/tvshow/get_watchlist_tvshow_status.dart';
import 'package:ditonton/domain/usecases/tvshow/remove_watchlist_tvshow.dart';
import 'package:ditonton/domain/usecases/tvshow/save_watchlist_tvshow.dart';
import 'package:ditonton/presentation/provider/TvShow/TvShow_detail_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/tvshow/dummy_tvshow_objects.dart';
import 'tvshow_detail_notifier_test.mocks.dart';

@GenerateMocks([
  GetTvShowDetail,
  GetTvShowRecommendations,
  GetWatchListTvShowStatus,
  SaveWatchlistTvShow,
  RemoveWatchlistTvShow,
])
void main() {
  late TvShowDetailNotifier provider;
  late MockGetTvShowDetail mockGetTvShowDetail;
  late MockGetTvShowRecommendations mockGetTvShowRecommendations;
  late MockGetWatchListTvShowStatus mockGetWatchlistStatus;
  late MockSaveWatchlistTvShow mockSaveWatchlist;
  late MockRemoveWatchlistTvShow mockRemoveWatchlist;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTvShowDetail = MockGetTvShowDetail();
    mockGetTvShowRecommendations = MockGetTvShowRecommendations();
    mockGetWatchlistStatus = MockGetWatchListTvShowStatus();
    mockSaveWatchlist = MockSaveWatchlistTvShow();
    mockRemoveWatchlist = MockRemoveWatchlistTvShow();
    provider = TvShowDetailNotifier(
      getTvShowDetail: mockGetTvShowDetail,
      getTvShowRecommendations: mockGetTvShowRecommendations,
      getWatchListStatus: mockGetWatchlistStatus,
      saveWatchlist: mockSaveWatchlist,
      removeWatchlist: mockRemoveWatchlist,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tId = 1;

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

  final tTvShows = <TvShow>[tTvShow];

  void _arrangeUsecase() {
    when(mockGetTvShowDetail.execute(tId))
        .thenAnswer((_) async => Right(testTvShowDetail));
    when(mockGetTvShowRecommendations.execute(tId))
        .thenAnswer((_) async => Right(tTvShows));
  }

  group('Get TvShow Detail', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvShowDetail(tId);
      // assert
      verify(mockGetTvShowDetail.execute(tId));
      verify(mockGetTvShowRecommendations.execute(tId));
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      _arrangeUsecase();
      // act
      provider.fetchTvShowDetail(tId);
      // assert
      expect(provider.tvShowState, RequestState.Loading);
      expect(listenerCallCount, 1);
    });

    test('should change TvShow when data is gotten successfully', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvShowDetail(tId);
      // assert
      expect(provider.tvShowState, RequestState.Loaded);
      expect(provider.tvShow, testTvShowDetail);
      expect(listenerCallCount, 3);
    });

    test(
        'should change recommendation TvShows when data is gotten successfully',
        () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvShowDetail(tId);
      // assert
      expect(provider.tvShowState, RequestState.Loaded);
      expect(provider.tvShowRecommendations, tTvShows);
    });
  });

  group('Get TvShow Recommendations', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvShowDetail(tId);
      // assert
      verify(mockGetTvShowRecommendations.execute(tId));
      expect(provider.tvShowRecommendations, tTvShows);
    });

    test('should update recommendation state when data is gotten successfully',
        () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvShowDetail(tId);
      // assert
      expect(provider.recommendationState, RequestState.Loaded);
      expect(provider.tvShowRecommendations, tTvShows);
    });

    test('should update error message when request in successful', () async {
      // arrange
      when(mockGetTvShowDetail.execute(tId))
          .thenAnswer((_) async => Right(testTvShowDetail));
      when(mockGetTvShowRecommendations.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Failed')));
      // act
      await provider.fetchTvShowDetail(tId);
      // assert
      expect(provider.recommendationState, RequestState.Error);
      expect(provider.message, 'Failed');
    });
  });

  group('Watchlist', () {
    test('should get the watchlist status', () async {
      // arrange
      when(mockGetWatchlistStatus.execute(1)).thenAnswer((_) async => true);
      // act
      await provider.loadWatchlistStatus(1);
      // assert
      expect(provider.isAddedToWatchlist, true);
    });

    test('should execute save watchlist when function called', () async {
      // arrange
      when(mockSaveWatchlist.execute(testTvShowDetail))
          .thenAnswer((_) async => Right('Success'));
      when(mockGetWatchlistStatus.execute(testTvShowDetail.id))
          .thenAnswer((_) async => true);
      // act
      await provider.addWatchlist(testTvShowDetail);
      // assert
      verify(mockSaveWatchlist.execute(testTvShowDetail));
    });

    test('should execute remove watchlist when function called', () async {
      // arrange
      when(mockRemoveWatchlist.execute(testTvShowDetail))
          .thenAnswer((_) async => Right('Removed'));
      when(mockGetWatchlistStatus.execute(testTvShowDetail.id))
          .thenAnswer((_) async => false);
      // act
      await provider.removeFromWatchlist(testTvShowDetail);
      // assert
      verify(mockRemoveWatchlist.execute(testTvShowDetail));
    });

    test('should update watchlist status when add watchlist success', () async {
      // arrange
      when(mockSaveWatchlist.execute(testTvShowDetail))
          .thenAnswer((_) async => Right('Added to Watchlist'));
      when(mockGetWatchlistStatus.execute(testTvShowDetail.id))
          .thenAnswer((_) async => true);
      // act
      await provider.addWatchlist(testTvShowDetail);
      // assert
      verify(mockGetWatchlistStatus.execute(testTvShowDetail.id));
      expect(provider.isAddedToWatchlist, true);
      expect(provider.watchlistMessage, 'Added to Watchlist');
      expect(listenerCallCount, 1);
    });

    test('should update watchlist message when add watchlist failed', () async {
      // arrange
      when(mockSaveWatchlist.execute(testTvShowDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
      when(mockGetWatchlistStatus.execute(testTvShowDetail.id))
          .thenAnswer((_) async => false);
      // act
      await provider.addWatchlist(testTvShowDetail);
      // assert
      expect(provider.watchlistMessage, 'Failed');
      expect(listenerCallCount, 1);
    });
  });

  group('on Error', () {
    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTvShowDetail.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      when(mockGetTvShowRecommendations.execute(tId))
          .thenAnswer((_) async => Right(tTvShows));
      // act
      await provider.fetchTvShowDetail(tId);
      // assert
      expect(provider.tvShowState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
