import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pokedex_inicie/components/type_button.dart';
import 'package:pokedex_inicie/models/pokemon.dart';
import 'package:pokedex_inicie/pages/mobile/pokemon_detail_page.dart';
import 'package:pokedex_inicie/utils/constants.dart';

class PokemonItem extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonItem({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => PokemonDetailPage(pokemon: pokemon)));
      },
      child: Container(
        width: 160,
        height: 111,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: const [
              BoxShadow(
                offset: Offset(0.0, 4.0),
                blurRadius: 15,
                color: Color.fromRGBO(0, 0, 0, 0.15),
              )
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  Text(
                      pokemon.name.substring(0, 1).toUpperCase() +
                          pokemon.name.substring(1, pokemon.name.length),
                      style: const TextStyle(
                          color: secondaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16)),
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: TypeButton(
                        text: pokemon.type,
                      )),
                  Text(
                    "#${pokemon.id}",
                    style: const TextStyle(fontSize: 14, color: primaryColor),
                  ),
                  const Spacer(),
                ],
              ),
            ),
            Expanded(
              child: Image.network(pokemon.image, fit: BoxFit.contain),
            ),
          ],
        ),
      ),
    );
  }
}
