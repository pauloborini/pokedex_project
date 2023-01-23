import 'package:auto_size_text/auto_size_text.dart';
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
          child: AutoSizeText(
            'Lista dos seus Pokemons Favoritos',
            maxLines: 2,
            minFontSize: 12,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: secondaryColor, fontWeight: FontWeight.w600),
          ),
        ));
  }
}
