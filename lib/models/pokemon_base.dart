import 'package:flutter/cupertino.dart';

class PokemonBase extends ChangeNotifier {
  final int? id;
  final String name;
  final String url;

  PokemonBase({this.id, required this.name, required this.url});
}
