import 'package:ditonton/domain/repositories/tvshow/tvshow_repository.dart';

class GetWatchListTvShowStatus {
  final TvShowRepository repository;

  GetWatchListTvShowStatus(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedToWatchlistTvShow(id);
  }
}
