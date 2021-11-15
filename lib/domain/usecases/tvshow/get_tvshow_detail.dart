import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tvshow/tvshow_detail.dart';
import 'package:ditonton/domain/repositories/tvshow/tvshow_repository.dart';

class GetTvShowDetail {
  final TvShowRepository repository;

  GetTvShowDetail(this.repository);

  Future<Either<Failure, TvShowDetail>> execute(int id) {
    return repository.getTvShowDetail(id);
  }
}
