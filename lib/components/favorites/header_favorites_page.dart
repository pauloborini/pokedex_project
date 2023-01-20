import 'package:flutter/material.dart';
import 'package:pokedex_inicie/utils/constants.dart';

class HeaderFavoritesPage extends StatelessWidget {
  const HeaderFavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 25),
        height: context.sizedDevice.height * 0.08,
        width: double.maxFinite,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: headerBackground,
        ),
        child: const Center(
          child: Text(
            'Lista dos seus Pokemons Favoritos',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: secondaryColor, fontWeight: FontWeight.w600),
          ),
        ));
  }
}
