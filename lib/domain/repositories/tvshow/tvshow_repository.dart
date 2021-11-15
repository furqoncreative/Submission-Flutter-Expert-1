import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tvshow/tvshow.dart';
import 'package:ditonton/domain/entities/tvshow/tvshow_detail.dart';

abstract class TvShowRepository {
  Future<Either<Failure, List<TvShow>>> getOnTheAirTvShow();

  Future<Either<Failure, List<TvShow>>> getPopularTvShow();

  Future<Either<Failure, List<TvShow>>> getTopRatedTvShow();

  Future<Either<Failure, TvShowDetail>> getTvShowDetail(int id);

  Future<Either<Failure, List<TvShow>>> getTvShowRecommendations(int id);

  Future<Either<Failure, List<TvShow>>> searchTvShow(String query);

  Future<Either<Failure, String>> saveWatchlistTvShow(TvShowDetail movie);

  Future<Either<Failure, String>> removeWatchlistTvShow(TvShowDetail movie);

  Future<bool> isAddedToWatchlistTvShow(int id);

  Future<Either<Failure, List<TvShow>>> getWatchlistTvShow();
}
