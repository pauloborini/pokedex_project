import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:pokedex_inicie/components/custom_button.dart';
import 'package:pokedex_inicie/components/home/pokemon_item.dart';
import 'package:pokedex_inicie/models/pokemon.dart';
import 'package:pokedex_inicie/repositories/pokemon_repository.dart';
import 'package:pokedex_inicie/utils/constants.dart';
import 'package:pokedex_inicie/utils/responsive.dart';
import 'package:provider/provider.dart';

import '../../generated/assets.dart';

class PokemonsView extends StatelessWidget {
  const PokemonsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: const [
          Responsive(
            test: GridViewPokemon(
              crossAxisCount: 1,
              childAspectRatio: 1,
              crossAxisSpacing: 8,
              mainAxisSpacing: 12,
            ),
            small: GridViewPokemon(
              crossAxisCount: !kIsWeb ? 2 : 1,
              childAspectRatio: !kIsWeb ? 1 : 1.2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            medium: GridViewPokemon(
              crossAxisCount: !kIsWeb ? 3 : 2,
              childAspectRatio: !kIsWeb ? 1.3 : 1.2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 12,
            ),
            large: GridViewPokemon(
              crossAxisCount: !kIsWeb ? 4 : 3,
              childAspectRatio: 1,
              crossAxisSpacing: 24,
              mainAxisSpacing: 18,
            ),
            xlarge: GridViewPokemon(
              crossAxisCount: 5,
              childAspectRatio: 0.9,
              crossAxisSpacing: 32,
              mainAxisSpacing: 23,
            ),
          ),
        ],
      ),
    );
  }
}

class GridViewPokemon extends StatefulWidget {
  final int crossAxisCount;
  final double childAspectRatio;
  final double crossAxisSpacing;
  final double mainAxisSpacing;

  const GridViewPokemon(
      {super.key,
      required this.crossAxisCount,
      required this.childAspectRatio,
      required this.crossAxisSpacing,
      required this.mainAxisSpacing});

  @override
  State<GridViewPokemon> createState() => _GridViewPokemonState();
}

class _GridViewPokemonState extends State<GridViewPokemon> {
  ValueNotifier<bool> loaded = ValueNotifier(false);
  late PokemonRepository pokemonRep;
  late List<Pokemon> pokemonList;

  getFirstTen() async {
    loaded.value = false;
    try {
      pokemonRep = Provider.of<PokemonRepository>(context);
      await Provider.of<PokemonRepository>(context, listen: false).getFirstTenPokemons();
      pokemonList = pokemonRep.pokemonList;
      loaded.value = true;
    } catch (e) {
      errorStandard();
    }
  }

  getNextTen() async {
    loaded.value = false;
    try {
      await pokemonRep.getNextTen();
    } catch (e) {
      errorStandard();
    }
    setState(() {
      loaded.value = true;
    });
  }

  getPreviousTen() async {
    loaded.value = false;
    try {
      await pokemonRep.getPreviousTen();
    } catch (e) {
      errorStandard();
    }
    setState(() {
      loaded.value = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    getFirstTen();
    return Stack(
      children: [
        !kIsWeb
            ? const SizedBox()
            : Positioned(
                left: 0,
                top: 30,
                child: Image.asset(
                  Assets.imagesCirclesElement,
                  fit: BoxFit.fill,
                  width: 110,
                ),
              ),
        Container(
          padding: !kIsWeb
              ? null
              : Responsive.isSmall(context)
                  ? null
                  : Responsive.isMedium(context)
                      ? null
                      : Responsive.isLarge(context)
                          ? const EdgeInsets.symmetric(horizontal: 15)
                          : const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Row(children: [
                Padding(
                    padding: const EdgeInsets.only(left: 25, top: 19, bottom: 10),
                    child: !kIsWeb
                        ? const Text('Lista de Pokémons',
                            style: TextStyle(
                                fontSize: 16,
                                color: secondaryColor,
                                fontWeight: FontWeight.bold))
                        : SizedBox(
                            height: Responsive.isTest(context)
                                ? 25
                                : Responsive.isSmall(context)
                                    ? 25
                                    : Responsive.isMedium(context)
                                        ? 30
                                        : Responsive.isLarge(context)
                                            ? 32
                                            : Responsive.isXLarge(context)
                                                ? 35
                                                : 35,
                            child: const FittedBox(
                              child: AutoSizeText('Pokédex',
                                  style: TextStyle(
                                      fontSize: 30,
                                      color: secondaryColor,
                                      fontWeight: FontWeight.bold)),
                            ),
                          )),
                !kIsWeb ? const SizedBox(height: 10) : const Spacer(),
                !kIsWeb
                    ? const SizedBox()
                    : SizedBox(
                        height: Responsive.isTest(context)
                            ? 25
                            : Responsive.isSmall(context)
                                ? 25
                                : Responsive.isMedium(context)
                                    ? 28
                                    : Responsive.isLarge(context)
                                        ? 32
                                        : Responsive.isXLarge(context)
                                            ? 35
                                            : 35,
                        child: FittedBox(
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  getPreviousTen();
                                },
                                child: const CircleAvatar(
                                    radius: 15,
                                    backgroundColor: primaryColor,
                                    child: Icon(Icons.arrow_back_ios_new,
                                        size: 18, color: Colors.white)),
                              ),
                              const SizedBox(width: 8),
                              GestureDetector(
                                onTap: () {
                                  getNextTen();
                                },
                                child: const CircleAvatar(
                                    radius: 15,
                                    backgroundColor: primaryColor,
                                    child: Icon(Icons.arrow_forward_ios,
                                        size: 18, color: Colors.white)),
                              )
                            ],
                          ),
                        )),
                Responsive.isXLarge(context)
                    ? const SizedBox(width: 50)
                    : Responsive.isLarge(context)
                        ? const SizedBox(width: 20)
                        : const SizedBox(width: 0)
              ]),
              ValueListenableBuilder(
                  valueListenable: loaded,
                  builder: (context, bool isLoaded, child) {
                    return (isLoaded && pokemonList.isNotEmpty)
                        ? GridView.builder(
                            padding: const EdgeInsets.only(left: 25, right: 25),
                            itemCount: 10,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: widget.crossAxisCount,
                                crossAxisSpacing: widget.crossAxisSpacing,
                                mainAxisSpacing: widget.mainAxisSpacing,
                                childAspectRatio: widget.childAspectRatio),
                            itemBuilder: (context, index) {
                              return PokemonItem(pokemon: pokemonList[index]);
                            },
                          )
                        : const Padding(
                            padding: EdgeInsets.only(top: 150),
                            child: Center(
                              child: CircularProgressIndicator.adaptive(),
                            ),
                          );
                  }),
              const SizedBox(height: 15),
              !kIsWeb
                  ? ValueListenableBuilder(
                      valueListenable: loaded,
                      builder: (context, bool isLoaded, child) {
                        return (isLoaded && pokemonList.isNotEmpty)
                            ? CustomButton(
                                title: 'Carregar +10',
                                onPressed: () async {
                                  getNextTen();
                                })
                            : Container();
                      })
                  : Container(),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ],
    );
  }

  errorStandard() {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Erro'),
              content: const Text('Ocorreu um erro ao \ncarregar os Pokemons'),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context), child: const Text('OK'))
              ],
            ));
  }
}
