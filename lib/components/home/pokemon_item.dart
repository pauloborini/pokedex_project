import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_inicie/components/type_button.dart';
import 'package:pokedex_inicie/models/pokemon.dart';
import 'package:pokedex_inicie/pages/mobile/pokemon_detail_page.dart';
import 'package:pokedex_inicie/utils/constants.dart';

import '../../utils/responsive.dart';

class PokemonItem extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonItem({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        !kIsWeb
            ? Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (context) => PokemonDetailPage(pokemon: pokemon)))
            : Navigator.pushReplacement(
                context,
                CupertinoPageRoute(
                    builder: (context) => PokemonDetailPage(pokemon: pokemon)));
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
        child: !kIsWeb ? buildRowMobile() : buildColumnWeb(context),
      ),
    );
  }

  Row buildRowMobile() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              SizedBox(
                width: 80,
                child: AutoSizeText(
                    pokemon.name.substring(0, 1).toUpperCase() +
                        pokemon.name.substring(1, pokemon.name.length),
                    overflow: TextOverflow.ellipsis,
                    minFontSize: 10,
                    maxLines: 1,
                    style: const TextStyle(
                        color: secondaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16)),
              ),
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
    );
  }

  Column buildColumnWeb(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              SizedBox(
                width: Responsive.isTest(context)
                    ? 100
                    : Responsive.isSmall(context)
                        ? 100
                        : 80,
                child: AutoSizeText(
                    pokemon.name.substring(0, 1).toUpperCase() +
                        pokemon.name.substring(1, pokemon.name.length),
                    overflow: TextOverflow.ellipsis,
                    minFontSize: 14,
                    maxLines: 1,
                    style: const TextStyle(
                        color: descriptionColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 22)),
              ),
              const Spacer(),
              Text(
                "#${pokemon.id}",
                style: const TextStyle(fontSize: 16, color: descriptionColor),
              ),
            ],
          ),
        ),
        Expanded(
          child: Image.network(pokemon.image, fit: BoxFit.fitHeight),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            const AutoSizeText(
              'Altura:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: descriptionColor,
              ),
            ),
            const Spacer(),
            AutoSizeText('${pokemon.height}cm',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: descriptionColor,
                ))
          ],
        ),
        Row(
          children: [
            const AutoSizeText(
              'Peso:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: descriptionColor,
              ),
            ),
            const Spacer(),
            AutoSizeText('${pokemon.weight}Kg',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: descriptionColor,
                ))
          ],
        )
      ],
    );
  }
}
