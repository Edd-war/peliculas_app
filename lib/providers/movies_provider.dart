
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas_app/helpers/debouncer.dart';
import 'package:peliculas_app/models/credits_response.dart';
import 'package:peliculas_app/models/models.dart';
import 'package:peliculas_app/models/search_response.dart';

class MoviesProvider extends ChangeNotifier{

  String _apiKey ='58f349bbec836eb21ee528cd6fdd02d8';
  String _baseUrl ='api.themoviedb.org';
  String _language ='es-MX';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];

  Map<int, List<Cast>> moviesCast={};

  int _popularPage = 0;

  final debouncer = Debouncer(
    duration: Duration(milliseconds: 500),
  );

  final StreamController<List<Movie>> _suggestionStreamController = new StreamController.broadcast();
  Stream<List<Movie>> get suggestionStream => this._suggestionStreamController.stream;

  MoviesProvider(){
    print('MoviesProviderInicializado');
    this.getOnDisplayMovies();
    this.getPopularMovies();
    // _suggestionStreamController.close();
  }

  Future<String> _getJsonData(String endpoint, [int page=1]) async{
    final url = Uri.https(_baseUrl, endpoint, {
      'api_key' : _apiKey,
      'language' : _language,
      'page' : '$page'
    });
    // Await the http response, then decode the json-formatted response
    final response = await http.get(url);
    return response.body;
  }

  getOnDisplayMovies() async {
    // var url = Uri.https(_baseUrl, '/3/movie/now_playing', {
    //   'api_key' : _apiKey,
    //   'language' : _language,
    //   'page' : '1'
    // });
    // // Await the http response, then decode the json-formatted response
    // final response = await http.get(url);
    final nowPlayingResponse = NowPlayingResponse.fromJson(await this._getJsonData('3/movie/now_playing'));
    // final nowPlayingResponse = NowPlayingResponse.fromJson(response.body);
    // final Map<String, dynamic> decodeData = json.decode(response.body);
   // if (response.statusCode!=200) return ('ERROR');
   //  print(nowPlayingResponse.results[0].title);
    // print(nowPlayingResponse.results![1].title);
    onDisplayMovies=nowPlayingResponse.results;
    notifyListeners();
  }

  getPopularMovies() async {
    _popularPage++;
    // var url = Uri.https(_baseUrl, '3/movie/popular', {
    //   'api_key': _apiKey,
    //   'language': _language,
    //   'page': '1'
    // });
    //
    // final response = await http.get(url);
    final jsonData = await this._getJsonData('3/movie/popular', _popularPage);
    final popularResponse = PopularResponse.fromJson( jsonData);
    popularMovies = [...popularMovies, ...popularResponse.results];
    print(popularMovies[0]);
    notifyListeners();
  }

  Future<List<Cast>> getMovieCast(int movieId) async{
    if(moviesCast.containsKey(movieId)) return moviesCast[movieId]!;
    // print('Pidiendo info al servidor de los actores');
    final jsonData = await this._getJsonData('3/movie/$movieId/credits');
    final creditsResponse = CreditsResponse.fromJson(jsonData);
    moviesCast[movieId] = creditsResponse.cast;
    return creditsResponse.cast;
  }

  Future<List<Movie>> searchMovies(String query)async{
    final url = Uri.https(_baseUrl, '3/search/movie', {
      'api_key' : _apiKey,
      'language' : _language,
      'query' : query
    });
    final response = await http.get(url);
    final searchResponse = SearchResponse.fromJson(response.body);

    return searchResponse.results;

  }

  void getSuggestionsByQuery(String searchTerm){
    debouncer.value='';
    debouncer.onValue=(value)async{
      // print('Tenemos valor a buscar: $value');
      final results = await this.searchMovies(value);
      this._suggestionStreamController.add(results);
    };

    final timer = Timer.periodic(Duration(milliseconds: 300), (_) {
      debouncer.value = searchTerm;
    });

    Future.delayed(Duration(milliseconds: 301)).then((_) => timer.cancel());
  }

}
