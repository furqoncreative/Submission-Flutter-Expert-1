import 'package:ditonton/data/models/tvshow/tvshow_model.dart';
import 'package:ditonton/domain/entities/tvshow/tvshow.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tTvShowModel = TvShowModel(
      firstAirDate: 'firstAirDate',
      genreIds: [1, 2, 3],
      backdropPath: 'backdropPath',
      id: 1,
      overview: 'overview',
      popularity: 1,
      posterPath: 'posterPath',
      voteAverage: 1,
      voteCount: 1,
      originCountry: [],
      name: 'name',
      originalLanguage: 'originalLanguage',
      originalName: 'originalName'
  );

  final tTvShow = TvShow(backdropPath: "backdropPath",
      firstAirDate: "firstAirDate",
      genreIds: [1, 2, 3],
      id: 1,
      name: "name",
      originalName: "originalName",
      overview: "overview",
      popularity: 1,
      posterPath: "posterPath",
      voteAverage: 1,
      voteCount: 1);

  test('should be a subclass of Tv Show entity', () async {
    final result = tTvShowModel.toEntity();
    expect(result, tTvShow);
  });
}
