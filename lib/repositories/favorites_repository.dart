import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pokedex_inicie/database/pokemon_hive_adapter.dart';
import 'package:pokedex_inicie/models/pokemon.dart';

class FavoritesRepository extends ChangeNotifier {
  List<Pokemon> _favoritesList = [];
  late LazyBox box;

  FavoritesRepository() {
    _startRepository();
  }

  _startRepository() async {
    await _openBox();
    await _readFavorites();
  }

  _openBox() async {
    Hive.registerAdapter(PokemonHiveAdapter());
    box = await Hive.openLazyBox<Pokemon>('favorites_pokemon');
  }

  _readFavorites() {
    box.keys.forEach((pokemon) async {
      Pokemon p = await box.get(pokemon);
      _favoritesList.add(p);
      notifyListeners();
    });
  }

  List<Pokemon> get favoritesList => [..._favoritesList];

  saveFavorite(Pokemon pokemon) {
    if (!_favoritesList.contains(pokemon)) {
      _favoritesList.add(pokemon);
      box.put(pokemon.id, pokemon);
    } else {
      removeFavorite(pokemon);
    }
    notifyListeners();
  }

  removeFavorite(Pokemon pokemon) {
    _favoritesList.remove(pokemon);
    box.delete(pokemon.id);
    notifyListeners();
  }
}
