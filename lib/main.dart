import 'package:ditonton/common/constants.dart';
import 'package:ditonton/injection/injection_movie.dart' as movieInjection;
import 'package:ditonton/injection/injection_tvshow.dart' as tvShowInjection;
import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:ditonton/presentation/pages/movie/home_movie_page.dart';
import 'package:ditonton/presentation/pages/movie/movie_detail_page.dart';
import 'package:ditonton/presentation/pages/movie/popular_movies_page.dart';
import 'package:ditonton/presentation/pages/movie/search_movie_page.dart';
import 'package:ditonton/presentation/pages/movie/top_rated_movies_page.dart';
import 'package:ditonton/presentation/pages/movie/watchlist_movies_page.dart';
import 'package:ditonton/presentation/pages/tvshow/home_tvshow_page.dart';
import 'package:ditonton/presentation/pages/tvshow/on_the_air_tvshow_page.dart';
import 'package:ditonton/presentation/pages/tvshow/popular_tvshow_page.dart';
import 'package:ditonton/presentation/pages/tvshow/search_tvshow_page.dart';
import 'package:ditonton/presentation/pages/tvshow/top_rated_tvhsow_page.dart';
import 'package:ditonton/presentation/pages/tvshow/tvshow_detail_page.dart';
import 'package:ditonton/presentation/pages/tvshow/watchlist_tvshow_page.dart';
import 'package:ditonton/presentation/provider/movie/movie_detail_notifier.dart';
import 'package:ditonton/presentation/provider/movie/movie_list_notifier.dart';
import 'package:ditonton/presentation/provider/movie/movie_search_notifier.dart';
import 'package:ditonton/presentation/provider/movie/popular_movies_notifier.dart';
import 'package:ditonton/presentation/provider/movie/top_rated_movies_notifier.dart';
import 'package:ditonton/presentation/provider/movie/watchlist_movie_notifier.dart';
import 'package:ditonton/presentation/provider/tvshow/on_the_air_tvshow_notifier.dart';
import 'package:ditonton/presentation/provider/tvshow/popular_tvshow_notifier.dart';
import 'package:ditonton/presentation/provider/tvshow/top_rated_tvshow_notifier.dart';
import 'package:ditonton/presentation/provider/tvshow/tvShow_list_notifier.dart';
import 'package:ditonton/presentation/provider/tvshow/tvshow_detail_notifier.dart';
import 'package:ditonton/presentation/provider/tvshow/tvshow_search_notifier.dart';
import 'package:ditonton/presentation/provider/tvshow/watchlist_tvshow_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  movieInjection.init();
  tvShowInjection.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //movie
        ChangeNotifierProvider(
          create: (_) => movieInjection.movieLocator<MovieListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => movieInjection.movieLocator<MovieDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => movieInjection.movieLocator<MovieSearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => movieInjection.movieLocator<TopRatedMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => movieInjection.movieLocator<PopularMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => movieInjection.movieLocator<WatchlistMovieNotifier>(),
        ),
        //Tv Show
        ChangeNotifierProvider(
          create: (_) => tvShowInjection.tvShowLocator<TvShowListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => tvShowInjection.tvShowLocator<TvShowDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => tvShowInjection.tvShowLocator<TvShowSearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) =>
              tvShowInjection.tvShowLocator<OnTheAirTvShowsNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) =>
              tvShowInjection.tvShowLocator<TopRatedTvShowsNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) =>
              tvShowInjection.tvShowLocator<PopularTvShowsNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) =>
              tvShowInjection.tvShowLocator<WatchlistTvShowNotifier>(),
        ),
      ],
      child: MaterialApp(
        title: 'Ditonton',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          accentColor: kMikadoYellow,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: HomeMoviePage(),
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case HomeMoviePage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => HomeMoviePage());
            case PopularMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case TopRatedMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case SearchMoviePage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchMoviePage());
            case WatchlistMoviesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());
            case HomeTvShowPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => HomeTvShowPage());
            case OnTheAirTvShowsPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => OnTheAirTvShowsPage());
            case PopularTvShowsPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularTvShowsPage());
            case TopRatedTvShowsPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedTvShowsPage());
            case TvShowDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TvShowDetailPage(id: id),
                settings: settings,
              );
            case SearchTvShowPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchTvShowPage());
            case WatchlistTvShowsPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistTvShowsPage());
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => AboutPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
