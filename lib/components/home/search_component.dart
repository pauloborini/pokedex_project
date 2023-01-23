import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pokedex_inicie/models/pokemon.dart';
import 'package:pokedex_inicie/pages/mobile/pokemon_detail_page.dart';
import 'package:pokedex_inicie/repositories/pokemon_repository.dart';
import 'package:pokedex_inicie/utils/constants.dart';
import 'package:provider/provider.dart';

import '../../utils/responsive.dart';

class SearchComponent extends StatelessWidget {
  SearchComponent({super.key});

  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double width = context.sizedDevice.width;
    final pokemonRep = Provider.of<PokemonRepository>(context);
    return SizedBox(
      height: !kIsWeb
          ? 31
          : Responsive.isTest(context)
              ? 36
              : Responsive.isSmall(context)
                  ? 40
                  : Responsive.isMedium(context)
                      ? 34
                      : 44,
      width: width *
          (!kIsWeb
              ? 0.41
              : Responsive.isTest(context)
                  ? 0.7
                  : Responsive.isSmall(context)
                      ? 0.7
                      : 0.32),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 1, color: const Color(0xFFF4F4F4)),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(5), bottomLeft: Radius.circular(6)),
                  boxShadow: const [
                    BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.15),
                        offset: Offset(0.0, 4.0),
                        blurRadius: 15)
                  ]),
              child: TextFormField(
                controller: _searchController,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  color: secondaryColor,
                ),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(bottom: !kIsWeb ? 12 : 8, left: 5)),
              ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              try {
                final Pokemon pokemon =
                    await pokemonRep.searchPokemon(_searchController.text.trim());
                if (pokemon != null) {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => PokemonDetailPage(pokemon: pokemon)));
                }
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Pokemon não encontrado")));
              }
            },
            child: Container(
              padding: const EdgeInsets.all(4),
              width: !kIsWeb
                  ? 40
                  : Responsive.isTest(context)
                      ? width * 0.12
                      : Responsive.isSmall(context)
                          ? width * 0.12
                          : width * 0.08,
              decoration: const BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(5), bottomRight: Radius.circular(5)),
                  boxShadow: [
                    BoxShadow(
                        color: primaryColor, offset: Offset(0.0, 4.0), blurRadius: 15)
                  ]),
              alignment: Alignment.center,
              child: !kIsWeb
                  ? const Icon(FontAwesomeIcons.magnifyingGlass,
                      color: Colors.white, size: 16)
                  : Responsive.isTest(context)
                      ? const Icon(FontAwesomeIcons.magnifyingGlass,
                          color: Colors.white, size: 16)
                      : const FittedBox(
                          child: AutoSizeText(
                            "Buscar",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white),
                            minFontSize: 10,
                            maxLines: 1,
                          ),
                        ),
            ),
          )
        ],
      ),
    );
  }
}
