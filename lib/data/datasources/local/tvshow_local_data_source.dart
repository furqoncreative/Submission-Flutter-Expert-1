import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/models/tvshow/tvshow_table.dart';

abstract class TvShowLocalDataSource {
  Future<String> insertWatchlistTvShow(TvShowTable tvShow);

  Future<String> removeWatchlistTvShow(TvShowTable tvShow);

  Future<TvShowTable?> getTvShowById(int id);

  Future<List<TvShowTable>> getWatchlistTvShow();
}

class TvShowLocalDataSourceImpl implements TvShowLocalDataSource {
  final DatabaseHelper databaseHelper;

  TvShowLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> insertWatchlistTvShow(TvShowTable tvShow) async {
    try {
      await databaseHelper.insertWatchlistTvShow(tvShow);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlistTvShow(TvShowTable tvShow) async {
    try {
      await databaseHelper.removeWatchlistTvShow(tvShow);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<TvShowTable?> getTvShowById(int id) async {
    final result = await databaseHelper.getTvShowById(id);
    if (result != null) {
      return TvShowTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<TvShowTable>> getWatchlistTvShow() async {
    final result = await databaseHelper.getWatchlistTvShow();
    return result.map((data) => TvShowTable.fromMap(data)).toList();
  }
}
