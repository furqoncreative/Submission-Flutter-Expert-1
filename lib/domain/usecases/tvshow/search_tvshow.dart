import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tvshow/tvshow.dart';
import 'package:ditonton/domain/repositories/tvshow/tvshow_repository.dart';

class SearchTvShow {
  final TvShowRepository repository;

  SearchTvShow(this.repository);

  Future<Either<Failure, List<TvShow>>> execute(String query) {
    return repository.searchTvShow(query);
  }
}
