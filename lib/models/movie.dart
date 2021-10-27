
/// adult : false
/// backdrop_path : "/lNyLSOKMMeUPr1RsL4KcRuIXwHt.jpg"
/// genre_ids : [878,28]
/// id : 580489
/// original_language : "en"
/// original_title : "Venom: Let There Be Carnage"
/// overview : "Venom 2 está en marcha y poco a poco vamos conociendo más detalles de esta nueva adaptación del Spiderverse de Sony Pictures junto a Marvel; tanto es así, que recientemente ha trascendido la aparición de Shriek en esta nueva película, una mítica villana de los cómics de Spider-Man que unirá fuerzas junto a su amado Cletus Kasady/Carnage para poner contra las cuerdas a Eddie Brock/Venom."
/// popularity : 7933.523
/// poster_path : "/2jVVDtDaeMxmcvrz2SNyhMcYtWc.jpg"
/// release_date : "2021-09-30"
/// title : "Venom: Carnage Liberado"
/// video : false
/// vote_average : 7
/// vote_count : 1106

import 'dart:convert';

class Movie {
  Movie({
    required this.adult,
    this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    this.posterPath,
    this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  bool adult;
  String? backdropPath;
  List<int> genreIds;
  int id;
  String originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  String? posterPath;
  String? releaseDate;
  String title;
  bool video;
  double voteAverage;
  int voteCount;


  String? heroId;

  //SE AGREGAN DE LAS LÍNEAS 55 A LA 61 (próximas 5 líneas) EN EL COMMIT DE MOSTRANDO IMÁGENES
  get fullPosterImg {
    if ( this.posterPath != null )
      return 'https://image.tmdb.org/t/p/w500${ this.posterPath }';

    return 'https://i.stack.imgur.com/GNhxO.png';
  }

  //SE AGREGAN DE LAS LÍNEAS 63 A LA 69 (PRÓXIMAS 7 LÍNEAS) EN EL COMMIT DE MovieDetails - Detalles de la película
  get fullBackdropPath {
    if ( this.backdropPath != null )
      return 'https://image.tmdb.org/t/p/w500${ this.backdropPath }';

    return 'https://i.stack.imgur.com/GNhxO.png';
  }


  factory Movie.fromJson(String str) => Movie.fromMap(json.decode(str));

  factory Movie.fromMap(Map<String, dynamic> json) => Movie(
    adult       : json["adult"],
    backdropPath: json["backdrop_path"],
    genreIds    : List<int>.from(json["genre_ids"].map((x) => x)),
    id          : json["id"],
    originalLanguage: json["original_language"],
    originalTitle   : json["original_title"],
    overview    : json["overview"],
    popularity  : json["popularity"].toDouble(),
    posterPath  : json["poster_path"],
    releaseDate : json["release_date"],
    title       : json["title"],
    video       : json["video"],
    voteAverage : json["vote_average"].toDouble(),
    voteCount   : json["vote_count"],
  );
}