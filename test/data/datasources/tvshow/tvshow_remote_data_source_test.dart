import 'dart:convert';
import 'dart:io';

import 'package:ditonton/data/datasources/remote/tvshow_remote_data_source.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/models/tvshow/tvshow_detail_model.dart';
import 'package:ditonton/data/models/tvshow/tvshow_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper_tvshow.mocks.dart';
import '../../../json_reader.dart';

void main() {
  const API_KEY = 'api_key=e54d3aed27284a12d12c0a33ed79f7d9';
  const BASE_URL = 'https://api.themoviedb.org/3';

  late TvShowRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = TvShowRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('get On The Air TvShows', () {
    final tTvShowList = TvShowResponse.fromJson(
            json.decode(readJson('dummy_data/tvshow/tvshow_on_the_air.json')))
        .tvShowList;

    test('should return list of TvShow Model when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/tvshow/tvshow_on_the_air.json'), 200));
      // act
      final result = await dataSource.getOnTheAirTvShow();
      // assert
      expect(result, equals(tTvShowList));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getOnTheAirTvShow();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Popular TvShows', () {
    final tTvShowList = TvShowResponse.fromJson(
            json.decode(readJson('dummy_data/tvshow/tvshow_popular.json')))
        .tvShowList;

    test('should return list of TvShows when response is success (200)',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/tvshow/tvshow_popular.json'), 200));
      // act
      final result = await dataSource.getPopularTvShow();
      // assert
      expect(result, tTvShowList);
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getPopularTvShow();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Top Rated TvShows', () {
    final tTvShowList = TvShowResponse.fromJson(
            json.decode(readJson('dummy_data/tvshow/tvshow_top_rated.json')))
        .tvShowList;

    test('should return list of TvShows when response code is 200 ', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/tvshow/tvshow_top_rated.json'), 200));
      // act
      final result = await dataSource.getTopRatedTvShow();
      // assert
      expect(result, tTvShowList);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTopRatedTvShow();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get TvShow detail', () {
    final tId = 1;
    final tTvShowDetail = TvShowDetailResponse.fromJson(
        json.decode(readJson('dummy_data/tvshow/tvshow_detail.json')));

    test('should return TvShow detail when the response code is 200', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tId?$API_KEY')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/tvshow/tvshow_detail.json'), 200));
      // act
      final result = await dataSource.getTvShowDetail(tId);
      // assert
      expect(result, equals(tTvShowDetail));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tId?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTvShowDetail(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get TvShow recommendations', () {
    final tTvShowList = TvShowResponse.fromJson(json
            .decode(readJson('dummy_data/tvshow/tvshow_recommendations.json')))
        .tvShowList;
    final tId = 1;

    test('should return list of TvShow Model when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/tvshow/tvshow_recommendations.json'), 200));
      // act
      final result = await dataSource.getTvShowRecommendations(tId);
      // assert
      expect(result, equals(tTvShowList));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTvShowRecommendations(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('search TvShows', () {
    final tSearchResult = TvShowResponse.fromJson(json
            .decode(readJson('dummy_data/tvshow/search_chucky_tvshow.json')))
        .tvShowList;
    final tQuery = 'Chucky';

    test('should return list of TvShows when response code is 200', () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$tQuery')))
          .thenAnswer((_) async => http.Response(
                  readJson('dummy_data/tvshow/search_chucky_tvshow.json'), 200,
                  headers: {
                    HttpHeaders.contentTypeHeader:
                        'application/json; charset=utf-8'
                  }));
      // act
      final result = await dataSource.searchTvShow(tQuery);
      // assert
      expect(result, tSearchResult);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$tQuery')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.searchTvShow(tQuery);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
