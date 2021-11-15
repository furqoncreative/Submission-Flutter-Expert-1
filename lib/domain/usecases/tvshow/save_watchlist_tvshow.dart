import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tvshow/tvshow_detail.dart';
import 'package:ditonton/domain/repositories/tvshow/tvshow_repository.dart';

class SaveWatchlistTvShow {
  final TvShowRepository repository;

  SaveWatchlistTvShow(this.repository);

  Future<Either<Failure, String>> execute(TvShowDetail tvShow) {
    return repository.saveWatchlistTvShow(tvShow);
  }
}
