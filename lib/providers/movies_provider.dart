import 'package:flutter/material.dart';

class MoviesProvider extends ChangeNotifier{

  MoviesProvider(){
    print('MoviesProviderInicializado');
    this.getOnDisplayMovies();
  }

  getOnDisplayMovies() async {
    print('getOnDisplayMovies');
  }
}