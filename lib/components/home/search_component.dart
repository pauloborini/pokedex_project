import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pokedex_inicie/models/pokemon.dart';
import 'package:pokedex_inicie/pages/mobile/pokemon_detail_page.dart';
import 'package:pokedex_inicie/repositories/pokemon_repository.dart';
import 'package:pokedex_inicie/utils/constants.dart';
import 'package:provider/provider.dart';

class SearchComponent extends StatelessWidget {
  final bool isMobile;

  SearchComponent({super.key, this.isMobile = true});

  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final pokemonRep = Provider.of<PokemonRepository>(context);
    return SizedBox(
      height: isMobile ? 31 : 45,
      width: context.sizedDevice.width * (isMobile ? 0.41 : 1),
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
              child: TextField(
                controller: _searchController,
                style: const TextStyle(
                  color: secondaryColor,
                ),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(bottom: isMobile ? 17 : 8, left: 5)),
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
              width: isMobile ? 40 : 106,
              decoration: const BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(5), bottomRight: Radius.circular(5)),
                  boxShadow: [
                    BoxShadow(
                        color: primaryColor, offset: Offset(0.0, 4.0), blurRadius: 15)
                  ]),
              alignment: Alignment.center,
              child: isMobile
                  ? const Icon(FontAwesomeIcons.magnifyingGlass,
                      color: Colors.white, size: 16)
                  : const Text(
                      "Buscar",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
                    ),
            ),
          )
        ],
      ),
    );
  }
}
