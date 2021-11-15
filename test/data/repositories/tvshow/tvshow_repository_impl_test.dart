import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/data/models/genre/genre_model.dart';
import 'package:ditonton/data/models/tvshow/tvshow_detail_model.dart';
import 'package:ditonton/data/models/tvshow/tvshow_model.dart';
import 'package:ditonton/data/repositories/tvshow_repository_impl.dart';
import 'package:ditonton/domain/entities/tvshow/tvshow.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/tvshow/dummy_tvshow_objects.dart';
import '../../../helpers/test_helper_tvshow.mocks.dart';

void main() {
  late TvShowRepositoryImpl repository;
  late MockTvShowRemoteDataSource mockRemoteDataSource;
  late MockTvShowLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockTvShowRemoteDataSource();
    mockLocalDataSource = MockTvShowLocalDataSource();
    repository = TvShowRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });

  final tTvShowModel = TvShowModel(
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
    id: 557,
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    voteAverage: 7.2,
    voteCount: 13507,
    firstAirDate: '',
    originCountry: [],
    originalName: '',
    originalLanguage: '',
    name: '',
  );

  final tTvShow = TvShow(
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
    id: 557,
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    voteAverage: 7.2,
    voteCount: 13507,
    firstAirDate: '',
    originalName: '',
    name: '',
  );

  final tTvShowModelList = <TvShowModel>[tTvShowModel];
  final tTvShowList = <TvShow>[tTvShow];

  group('Now Playing TvShows', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getOnTheAirTvShow())
          .thenAnswer((_) async => tTvShowModelList);
      // act
      final result = await repository.getOnTheAirTvShow();
      // assert
      verify(mockRemoteDataSource.getOnTheAirTvShow());
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvShowList);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getOnTheAirTvShow())
          .thenThrow(ServerException());
      // act
      final result = await repository.getOnTheAirTvShow();
      // assert
      verify(mockRemoteDataSource.getOnTheAirTvShow());
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getOnTheAirTvShow())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getOnTheAirTvShow();
      // assert
      verify(mockRemoteDataSource.getOnTheAirTvShow());
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Popular TvShows', () {
    test('should return TvShow list when call to data source is success',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularTvShow())
          .thenAnswer((_) async => tTvShowModelList);
      // act
      final result = await repository.getPopularTvShow();
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvShowList);
    });

    test(
        'should return server failure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularTvShow())
          .thenThrow(ServerException());
      // act
      final result = await repository.getPopularTvShow();
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return connection failure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularTvShow())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getPopularTvShow();
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Top Rated TvShows', () {
    test('should return TvShow list when call to data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTvShow())
          .thenAnswer((_) async => tTvShowModelList);
      // act
      final result = await repository.getTopRatedTvShow();
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvShowList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTvShow())
          .thenThrow(ServerException());
      // act
      final result = await repository.getTopRatedTvShow();
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTvShow())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTopRatedTvShow();
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Get TvShow Detail', () {
    final tId = 1;
    final tTvShowResponse = TvShowDetailResponse(
      backdropPath: 'backdropPath',
      genres: [GenreModel(id: 1, name: 'Action')],
      id: 1,
      overview: 'overview',
      posterPath: 'posterPath',
      voteAverage: 1,
      voteCount: 1,
      originalName: 'originalName',
      numberOfSeasons: 1,
      name: 'name',
      firstAirDate: 'firstAirDate'
    );

    test(
        'should return TvShow data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvShowDetail(tId))
          .thenAnswer((_) async => tTvShowResponse);
      // act
      final result = await repository.getTvShowDetail(tId);
      // assert
      verify(mockRemoteDataSource.getTvShowDetail(tId));
      expect(result, equals(Right(testTvShowDetail)));
    });

    test(
        'should return Server Failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvShowDetail(tId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getTvShowDetail(tId);
      // assert
      verify(mockRemoteDataSource.getTvShowDetail(tId));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvShowDetail(tId))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTvShowDetail(tId);
      // assert
      verify(mockRemoteDataSource.getTvShowDetail(tId));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Get TvShow Recommendations', () {
    final tTvShowList = <TvShowModel>[];
    final tId = 1;

    test('should return data (TvShow list) when the call is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvShowRecommendations(tId))
          .thenAnswer((_) async => tTvShowList);
      // act
      final result = await repository.getTvShowRecommendations(tId);
      // assert
      verify(mockRemoteDataSource.getTvShowRecommendations(tId));
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, equals(tTvShowList));
    });

    test(
        'should return server failure when call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvShowRecommendations(tId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getTvShowRecommendations(tId);
      // assertbuild runner
      verify(mockRemoteDataSource.getTvShowRecommendations(tId));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvShowRecommendations(tId))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTvShowRecommendations(tId);
      // assert
      verify(mockRemoteDataSource.getTvShowRecommendations(tId));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Seach TvShows', () {
    final tQuery = 'spiderman';

    test('should return TvShow list when call to data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTvShow(tQuery))
          .thenAnswer((_) async => tTvShowModelList);
      // act
      final result = await repository.searchTvShow(tQuery);
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvShowList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTvShow(tQuery))
          .thenThrow(ServerException());
      // act
      final result = await repository.searchTvShow(tQuery);
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTvShow(tQuery))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.searchTvShow(tQuery);
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('save watchlist', () {
    test('should return success message when saving successful', () async {
      // arrange
      when(mockLocalDataSource.insertWatchlistTvShow(testTvShowTable))
          .thenAnswer((_) async => 'Added to Watchlist');
      // act
      final result = await repository.saveWatchlistTvShow(testTvShowDetail);
      // assert
      expect(result, Right('Added to Watchlist'));
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.insertWatchlistTvShow(testTvShowTable))
          .thenThrow(DatabaseException('Failed to add watchlist'));
      // act
      final result = await repository.saveWatchlistTvShow(testTvShowDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove successful', () async {
      // arrange
      when(mockLocalDataSource.removeWatchlistTvShow(testTvShowTable))
          .thenAnswer((_) async => 'Removed from watchlist');
      // act
      final result = await repository.removeWatchlistTvShow(testTvShowDetail);
      // assert
      expect(result, Right('Removed from watchlist'));
    });

    test('should return DatabaseFailure when remove unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.removeWatchlistTvShow(testTvShowTable))
          .thenThrow(DatabaseException('Failed to remove watchlist'));
      // act
      final result = await repository.removeWatchlistTvShow(testTvShowDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });

  group('get watchlist status', () {
    test('should return watch status whether data is found', () async {
      // arrange
      final tId = 1;
      when(mockLocalDataSource.getTvShowById(tId))
          .thenAnswer((_) async => null);
      // act
      final result = await repository.isAddedToWatchlistTvShow(tId);
      // assert
      expect(result, false);
    });
  });

  group('get watchlist TvShows', () {
    test('should return list of TvShows', () async {
      // arrange
      when(mockLocalDataSource.getWatchlistTvShow())
          .thenAnswer((_) async => [testTvShowTable]);
      // act
      final result = await repository.getWatchlistTvShow();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testWatchlistTvShow]);
    });
  });
}
