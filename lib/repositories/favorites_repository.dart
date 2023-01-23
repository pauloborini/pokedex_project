import 'package:flutter/material.dart';
import 'package:pokedex_inicie/models/pokemon.dart';

class FavoritesRepository extends ChangeNotifier {
  List<Pokemon> _favoritesList = [];

  List<Pokemon> get favoritesList => [..._favoritesList];

  saveFavorite(Pokemon pokemon) {
    if (!_favoritesList.any((p) => p.id == pokemon.id)) {
      _favoritesList.add(pokemon);
    } else {
      removeFavorite(pokemon);
    }
    notifyListeners();
  }

  removeFavorite(Pokemon pokemon) {
    _favoritesList.remove(pokemon);
  }
}
