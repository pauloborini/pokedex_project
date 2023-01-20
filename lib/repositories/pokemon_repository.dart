import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pokedex_inicie/models/pokemon.dart';
import 'package:pokedex_inicie/models/pokemon_base.dart';
import 'package:http/http.dart' as http;

class PokemonRepository with ChangeNotifier {
  List<PokemonBase> _pokemonBaseList = [];
  List<Pokemon> _pokemonList = [];
  int offset = 0;
  bool initialData = false;
  String descriptionPokemon = '';

  List<PokemonBase> get pokemonBaseList => [..._pokemonBaseList];

  List<Pokemon> get pokemonList => [..._pokemonList];

  int itemCount() {
    return pokemonBaseList.length;
  }

  getFirstTenPokemons() async {
    if (initialData == false) {
      _pokemonBaseList.clear();
      _pokemonList.clear();
      String uri = 'https://pokeapi.co/api/v2/pokemon/?offset=0&limit=10';
      final response = await http.get(Uri.parse(uri));
      if (response.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(response.body);
        final List<dynamic> pokemonAPI = json["results"];
        for (int i = 0; i < pokemonAPI.length; i++) {
          final pokemonBase = pokemonAPI[i];
          final pokeBase =
              PokemonBase(name: pokemonBase["name"], url: pokemonBase["url"]);
          _pokemonBaseList.add(pokeBase);
          String url = pokeBase.url;
          String newUrl = url.replaceFirst(RegExp(r'/$'), '');
          Uri uri = Uri.parse(newUrl);
          String idText = uri.pathSegments.last;
          final int id = int.parse(idText);
          final pokemon = await getPokemonDetails(id);
          _pokemonList.add(pokemon);
        }
        initialData = true;
      } else {
        throw Exception('Erro ao carregar Pokemons');
      }
    }
  }

  getNextTen() async {
    _pokemonBaseList.clear();
    _pokemonList.clear();
    offset += 10;
    String uri = 'https://pokeapi.co/api/v2/pokemon/?offset=$offset&limit=10';
    final response = await http.get(Uri.parse(uri));
    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      final List<dynamic> pokemonAPI = json["results"];
      for (int i = 0; i < pokemonAPI.length; i++) {
        final pokemonBase = pokemonAPI[i];
        final pokeBase = PokemonBase(name: pokemonBase["name"], url: pokemonBase["url"]);
        _pokemonBaseList.add(pokeBase);
        String url = pokeBase.url;
        String newUrl = url.replaceFirst(RegExp(r'/$'), '');
        Uri uri = Uri.parse(newUrl);
        String idText = uri.pathSegments.last;
        final int id = int.parse(idText);
        final pokemon = await getPokemonDetails(id);
        _pokemonList.add(pokemon);
      }
      initialData = true;
    } else {
      throw Exception('Erro ao carregar Pokemons');
    }
  }

  Future<Pokemon> getPokemonDetails(int id) async {
    final response = await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon/$id'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      List<dynamic> types = json['types'];
      List pokemonTypes = types.map((type) => type['type']['name']).toList();
      final Pokemon pokemon = Pokemon(id,
          name: json["name"],
          height: json["height"] / 10,
          weight: json["weight"] / 10,
          image: json["sprites"]["other"]["home"]["front_default"],
          type: pokemonTypes.first,
          hp: json["stats"][5]["base_stat"].toDouble(),
          attack: json["stats"][4]["base_stat"].toDouble(),
          defense: json["stats"][3]["base_stat"].toDouble(),
          speed: json["stats"][0]["base_stat"].toDouble(),
          specialAttack: json["stats"][2]["base_stat"].toDouble(),
          specialDefense: json["stats"][1]["base_stat"].toDouble());
      return pokemon;
    } else {
      throw Exception('Erro ao carregar Pokemons');
    }
  }

  Future<String> getPokemonDescription(int id) async {
    final response =
        await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon-species/$id'));
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final englishDescription = jsonResponse['flavor_text_entries']
          .firstWhere((entry) => entry['language']['name'] == 'en')['flavor_text'];
      return englishDescription;
    } else {
      throw Exception('Erro ao carregar a descrição do Pokemon');
    }
  }

  Future<Pokemon> searchPokemon(String text) async {
    final response = await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon/$text'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      List<dynamic> types = json['types'];
      List pokemonTypes = types.map((type) => type['type']['name']).toList();
      final Pokemon pokemon = Pokemon(json["id"],
          name: json["name"],
          height: json["height"] / 10,
          weight: json["weight"] / 10,
          image: json["sprites"]["other"]["home"]["front_default"],
          type: pokemonTypes.first,
          hp: json["stats"][5]["base_stat"].toDouble(),
          attack: json["stats"][4]["base_stat"].toDouble(),
          defense: json["stats"][3]["base_stat"].toDouble(),
          speed: json["stats"][0]["base_stat"].toDouble(),
          specialAttack: json["stats"][2]["base_stat"].toDouble(),
          specialDefense: json["stats"][1]["base_stat"].toDouble());
      return pokemon;
    } else {
      throw Exception('Erro ao carregar Pokemons');
    }
  }

  getFilteredPokemons(String type) async {
    initialData = false;
    if (initialData == false) {
      _pokemonBaseList.clear();
      _pokemonList.clear();
      String uri = 'https://pokeapi.co/api/v2/type/$type';
      final response = await http.get(Uri.parse(uri));
      if (response.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(response.body);
        final List<dynamic> pokemonAPI = json["results"];
        for (int i = 0; i < pokemonAPI.length; i++) {
          final pokemonBase = pokemonAPI[i];
          final pokeBase =
              PokemonBase(name: pokemonBase["name"], url: pokemonBase["url"]);
          _pokemonBaseList.add(pokeBase);
          String url = pokeBase.url;
          String newUrl = url.replaceFirst(RegExp(r'/$'), '');
          Uri uri = Uri.parse(newUrl);
          String idText = uri.pathSegments.last;
          final int id = int.parse(idText);
          final pokemon = await getPokemonDetails(id);
          _pokemonList.add(pokemon);
        }
        initialData = true;
      } else {
        throw Exception('Erro ao carregar Pokemons');
      }
    }
  }
}
