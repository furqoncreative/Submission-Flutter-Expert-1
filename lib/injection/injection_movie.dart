import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/datasources/local/movie_local_data_source.dart';
import 'package:ditonton/data/datasources/remote/movie_remote_data_source.dart';
import 'package:ditonton/data/repositories/movie_repository_impl.dart';
import 'package:ditonton/domain/repositories/movie/movie_repository.dart';
import 'package:ditonton/domain/usecases/movie/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/movie/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecases/movie/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/movie/get_top_rated_movies.dart';
import 'package:ditonton/domain/usecases/movie/get_watchlist_movie_status.dart';
import 'package:ditonton/domain/usecases/movie/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/movie/remove_watchlist_movie.dart';
import 'package:ditonton/domain/usecases/movie/save_watchlist_movie.dart';
import 'package:ditonton/domain/usecases/movie/search_movies.dart';
import 'package:ditonton/presentation/provider/movie/movie_detail_notifier.dart';
import 'package:ditonton/presentation/provider/movie/movie_list_notifier.dart';
import 'package:ditonton/presentation/provider/movie/movie_search_notifier.dart';
import 'package:ditonton/presentation/provider/movie/popular_movies_notifier.dart';
import 'package:ditonton/presentation/provider/movie/top_rated_movies_notifier.dart';
import 'package:ditonton/presentation/provider/movie/watchlist_movie_notifier.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import '../domain/usecases/movie/get_movie_recommendations.dart';

final movieLocator = GetIt.instance;

void init() {
  // provider
  movieLocator.registerFactory(
    () => MovieListNotifier(
      getNowPlayingMovies: movieLocator(),
      getPopularMovies: movieLocator(),
      getTopRatedMovies: movieLocator(),
    ),
  );
  movieLocator.registerFactory(
    () => MovieDetailNotifier(
      getMovieDetail: movieLocator(),
      getMovieRecommendations: movieLocator(),
      getWatchListStatus: movieLocator(),
      saveWatchlist: movieLocator(),
      removeWatchlist: movieLocator(),
    ),
  );
  movieLocator.registerFactory(
    () => MovieSearchNotifier(
      searchMovies: movieLocator(),
    ),
  );
  movieLocator.registerFactory(
    () => PopularMoviesNotifier(
      movieLocator(),
    ),
  );
  movieLocator.registerFactory(
    () => TopRatedMoviesNotifier(
      getTopRatedMovies: movieLocator(),
    ),
  );
  movieLocator.registerFactory(
    () => WatchlistMovieNotifier(
      getWatchlistMovies: movieLocator(),
    ),
  );

  // use case
  movieLocator.registerLazySingleton(() => GetNowPlayingMovies(movieLocator()));
  movieLocator.registerLazySingleton(() => GetPopularMovies(movieLocator()));
  movieLocator.registerLazySingleton(() => GetTopRatedMovies(movieLocator()));
  movieLocator.registerLazySingleton(() => GetMovieDetail(movieLocator()));
  movieLocator
      .registerLazySingleton(() => GetMovieRecommendations(movieLocator()));
  movieLocator.registerLazySingleton(() => SearchMovies(movieLocator()));
  movieLocator
      .registerLazySingleton(() => GetWatchListMovieStatus(movieLocator()));
  movieLocator.registerLazySingleton(() => SaveWatchlistMovie(movieLocator()));
  movieLocator
      .registerLazySingleton(() => RemoveWatchlistMovie(movieLocator()));
  movieLocator.registerLazySingleton(() => GetWatchlistMovies(movieLocator()));

  // repository
  movieLocator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: movieLocator(),
      localDataSource: movieLocator(),
    ),
  );

  // data sources
  movieLocator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: movieLocator()));
  movieLocator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: movieLocator()));

  // helper
  movieLocator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  movieLocator.registerLazySingleton(() => http.Client());
}
