import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tvshow/tvshow.dart';
import 'package:ditonton/domain/repositories/tvshow/tvshow_repository.dart';

class GetTvShowRecommendations {
  final TvShowRepository repository;

  GetTvShowRecommendations(this.repository);

  Future<Either<Failure, List<TvShow>>> execute(id) {
    return repository.getTvShowRecommendations(id);
  }
}
