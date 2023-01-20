import 'package:flutter/material.dart';

class Pokemon extends ChangeNotifier {
  final int id;
  final String name;
  final double height;
  final double weight;
  final String image;
  final String type;
  final double hp;
  final double attack;
  final double defense;
  final double speed;
  final double specialAttack;
  final double specialDefense;

  Pokemon({
    required this.id,
    required this.name,
    required this.height,
    required this.weight,
    required this.image,
    required this.type,
    required this.hp,
    required this.attack,
    required this.defense,
    required this.speed,
    required this.specialAttack,
    required this.specialDefense,
  });
}
