import 'package:ditonton/data/models/tvshow/tvshow_table.dart';
import 'package:ditonton/domain/entities/genre/genre.dart';
import 'package:ditonton/domain/entities/tvshow/tvshow.dart';
import 'package:ditonton/domain/entities/tvshow/tvshow_detail.dart';

final testTvShow = TvShow(
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

final testTvShowList = [testTvShow];

final testTvShowDetail = TvShowDetail(
    backdropPath: "backdropPath",
    firstAirDate: "firstAirDate",
    genres: [Genre(id: 1, name: "Action")],
    id: 1,
    name: "name",
    originalName: "originalName",
    overview: "overview",
    posterPath: "posterPath",
    voteAverage: 1,
    voteCount: 1,
    numberOfSeasons: 1);

final testWatchlistTvShow = TvShow.watchlist(
    id: 1, overview: "overview", posterPath: "posterPath", name: "name");

final testTvShowTable = TvShowTable(
    id: 1, name: "name", posterPath: "posterPath", overview: "overview");

final testTvShowMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'name': 'name'
};
