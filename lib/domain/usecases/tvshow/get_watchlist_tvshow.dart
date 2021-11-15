import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tvshow/tvshow.dart';
import 'package:ditonton/domain/repositories/tvshow/tvshow_repository.dart';

class GetWatchlistTvShow {
  final TvShowRepository _repository;

  GetWatchlistTvShow(this._repository);

  Future<Either<Failure, List<TvShow>>> execute() {
    return _repository.getWatchlistTvShow();
  }
}
