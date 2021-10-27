import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas_app/models/models.dart';

class MoviesProvider extends ChangeNotifier{

  String _apiKey ='58f349bbec836eb21ee528cd6fdd02d8';
  String _baseUrl ='api.themoviedb.org';
  String _language ='es-MX';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];
  int _popularPage = 0;

  MoviesProvider(){
    print('MoviesProviderInicializado');
    this.getOnDisplayMovies();
    this.getPopularMovies();
  }

  Future<String> _getJsonData(String endpoint, [int page=1]) async{
    var url = Uri.https(_baseUrl, endpoint, {
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
}
