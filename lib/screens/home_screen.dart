import 'package:flutter/material.dart';
import 'package:peliculas_app/providers/movies_provider.dart';
import 'package:peliculas_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: true);
    print(moviesProvider.onDisplayMovies);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Películas en Cines'),
        elevation: 0,
        actions: [
          IconButton(
              onPressed: (){},
              icon: Icon(Icons.search_outlined),
          ),
        ]
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Tarjetas principales
            CardSwiper(movies: moviesProvider.onDisplayMovies),

            // Movie Slider
            MovieSlider(),
            // MovieSlider(),
            // MovieSlider(),
            // MovieSlider(),
          ],
        ),
      ),
    );
  }
}
