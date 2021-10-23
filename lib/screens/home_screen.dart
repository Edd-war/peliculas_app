import 'package:flutter/material.dart';
import 'package:peliculas_app/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            CardSwiper(),

            // Movie Slider
            MovieSlider(),
          ],
        ),
      ),
    );
  }
}
