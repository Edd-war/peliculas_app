

import 'package:flutter/material.dart';

class MovieSearchDelegate extends SearchDelegate{

  @override
  // TODO: implement searchFieldLabel
  String? get searchFieldLabel => 'Buscar Contenido';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      Text('buildActions'),
    ];
    // TODO: implement buildActions
    // throw UnimplementedError();
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return Text('buildLeading');
    // // TODO: implement buildLeading
    // throw UnimplementedError();
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text('buildResults');
    // TODO: implement buildResults
    // throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Text('buildSuggestions: $query');
    // TODO: implement buildSuggestions
    // throw UnimplementedError();
  }



}