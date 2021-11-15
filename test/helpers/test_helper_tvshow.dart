import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/datasources/local/movie_local_data_source.dart';
import 'package:ditonton/data/datasources/local/tvshow_local_data_source.dart';
import 'package:ditonton/data/datasources/remote/movie_remote_data_source.dart';
import 'package:ditonton/data/datasources/remote/tvshow_remote_data_source.dart';
import 'package:ditonton/domain/repositories/movie/movie_repository.dart';
import 'package:ditonton/domain/repositories/tvshow/tvshow_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  TvShowRepository,
  TvShowRemoteDataSource,
  TvShowLocalDataSource,
  DatabaseHelper,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
