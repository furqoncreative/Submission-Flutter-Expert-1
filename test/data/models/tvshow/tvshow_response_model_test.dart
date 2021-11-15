import 'dart:convert';

import 'package:ditonton/data/models/tvshow/tvshow_model.dart';
import 'package:ditonton/data/models/tvshow/tvshow_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../json_reader.dart';

void main() {
  final tTvShowModel = TvShowModel(
    backdropPath: "/path.jpg",
    genreIds: [1, 2, 3, 4],
    id: 90462,
    overview: "Overview",
    popularity: 1.0,
    posterPath: "/path.jpg",
    voteAverage: 1.0,
    voteCount: 1,
    originalLanguage: 'en',
    originCountry:  ["US"],
    firstAirDate: '2021-10-12',
    originalName: 'Original Name',
    name: 'Name',
  );
  final tTvShowResponseModel =
      TvShowResponse(tvShowList: <TvShowModel>[tTvShowModel]);
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/tvshow/tvshow_on_the_air.json'));
      // act
      final result = TvShowResponse.fromJson(jsonMap);
      // assert
      expect(result, tTvShowResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tTvShowResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "backdrop_path": "/path.jpg",
            "first_air_date": "2021-10-12",
            "genre_ids": [1, 2, 3, 4],
            "id": 90462,
            "name": "Name",
            "origin_country": ["US"],
            "original_language": "en",
            "original_name": "Original Name",
            "overview": "Overview",
            "popularity": 1.0,
            "poster_path": "/path.jpg",
            "vote_average": 1,
            "vote_count": 1
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
