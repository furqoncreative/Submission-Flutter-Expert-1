import 'package:ditonton/data/datasources/local/tvshow_local_data_source.dart';
import 'package:ditonton/data/datasources/remote/tvshow_remote_data_source.dart';
import 'package:ditonton/data/repositories/tvshow_repository_impl.dart';
import 'package:ditonton/domain/repositories/tvshow/tvshow_repository.dart';
import 'package:ditonton/domain/usecases/tvshow/get_on_the_air_tvshow.dart';
import 'package:ditonton/domain/usecases/tvshow/get_popular_tvshow.dart';
import 'package:ditonton/domain/usecases/tvshow/get_top_rated_tvshow.dart';
import 'package:ditonton/domain/usecases/tvshow/get_tvshow_detail.dart';
import 'package:ditonton/domain/usecases/tvshow/get_tvshow_recommendations.dart';
import 'package:ditonton/domain/usecases/tvshow/get_watchlist_tvshow.dart';
import 'package:ditonton/domain/usecases/tvshow/get_watchlist_tvshow_status.dart';
import 'package:ditonton/domain/usecases/tvshow/remove_watchlist_tvshow.dart';
import 'package:ditonton/domain/usecases/tvshow/save_watchlist_tvshow.dart';
import 'package:ditonton/domain/usecases/tvshow/search_tvshow.dart';
import 'package:ditonton/presentation/provider/tvshow/on_the_air_tvshow_notifier.dart';
import 'package:ditonton/presentation/provider/tvshow/popular_tvshow_notifier.dart';
import 'package:ditonton/presentation/provider/tvshow/top_rated_tvshow_notifier.dart';
import 'package:ditonton/presentation/provider/tvshow/tvShow_list_notifier.dart';
import 'package:ditonton/presentation/provider/tvshow/tvshow_detail_notifier.dart';
import 'package:ditonton/presentation/provider/tvshow/tvshow_search_notifier.dart';
import 'package:ditonton/presentation/provider/tvshow/watchlist_tvshow_notifier.dart';
import 'package:get_it/get_it.dart';

final tvShowLocator = GetIt.instance;

void init() {
  // provider
  tvShowLocator.registerFactory(
    () => TvShowListNotifier(
      getOnTheAirTvShow: tvShowLocator(),
      getPopularTvShows: tvShowLocator(),
      getTopRatedTvShows: tvShowLocator(),
    ),
  );
  tvShowLocator.registerFactory(
    () => TvShowDetailNotifier(
      getTvShowDetail: tvShowLocator(),
      getTvShowRecommendations: tvShowLocator(),
      getWatchListStatus: tvShowLocator(),
      saveWatchlist: tvShowLocator(),
      removeWatchlist: tvShowLocator(),
    ),
  );
  tvShowLocator.registerFactory(
    () => TvShowSearchNotifier(
      searchTvShows: tvShowLocator(),
    ),
  );
  tvShowLocator.registerFactory(
    () => OnTheAirTvShowsNotifier(
      tvShowLocator(),
    ),
  );
  tvShowLocator.registerFactory(
    () => PopularTvShowsNotifier(
      tvShowLocator(),
    ),
  );
  tvShowLocator.registerFactory(
    () => TopRatedTvShowsNotifier(
      getTopRatedTvShows: tvShowLocator(),
    ),
  );
  tvShowLocator.registerFactory(
    () => WatchlistTvShowNotifier(
      getWatchlistTvShows: tvShowLocator(),
    ),
  );

  // use case
  tvShowLocator.registerLazySingleton(() => GetOnTheAirTvShow(tvShowLocator()));
  tvShowLocator.registerLazySingleton(() => GetPopularTvShow(tvShowLocator()));
  tvShowLocator.registerLazySingleton(() => GetTopRatedTvShow(tvShowLocator()));
  tvShowLocator.registerLazySingleton(() => GetTvShowDetail(tvShowLocator()));
  tvShowLocator
      .registerLazySingleton(() => GetTvShowRecommendations(tvShowLocator()));
  tvShowLocator.registerLazySingleton(() => SearchTvShow(tvShowLocator()));
  tvShowLocator
      .registerLazySingleton(() => GetWatchListTvShowStatus(tvShowLocator()));
  tvShowLocator
      .registerLazySingleton(() => SaveWatchlistTvShow(tvShowLocator()));
  tvShowLocator
      .registerLazySingleton(() => RemoveWatchlistTvShow(tvShowLocator()));
  tvShowLocator
      .registerLazySingleton(() => GetWatchlistTvShow(tvShowLocator()));

  // repository
  tvShowLocator.registerLazySingleton<TvShowRepository>(
    () => TvShowRepositoryImpl(
      remoteDataSource: tvShowLocator(),
      localDataSource: tvShowLocator(),
    ),
  );

  // data sources
  tvShowLocator.registerLazySingleton<TvShowRemoteDataSource>(
      () => TvShowRemoteDataSourceImpl(client: tvShowLocator()));
  tvShowLocator.registerLazySingleton<TvShowLocalDataSource>(
      () => TvShowLocalDataSourceImpl(databaseHelper: tvShowLocator()));
}
