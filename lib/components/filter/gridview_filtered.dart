import 'package:flutter/material.dart';
import 'package:pokedex_inicie/components/home/pokemon_item.dart';
import 'package:pokedex_inicie/models/pokemon.dart';
import 'package:pokedex_inicie/repositories/pokemon_repository.dart';
import 'package:pokedex_inicie/utils/constants.dart';
import 'package:pokedex_inicie/utils/responsive.dart';
import 'package:provider/provider.dart';

class PokemonsViewFiltered extends StatelessWidget {
  const PokemonsViewFiltered({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Row(children: const [
            Padding(
                padding: EdgeInsets.only(left: 25, top: 19, bottom: 10),
                child: Text('Lista de Pokemons',
                    style: TextStyle(
                        fontSize: 16,
                        color: secondaryColor,
                        fontWeight: FontWeight.bold))),
            SizedBox(height: 10),
          ]),
          const Responsive(
              small: GridViewPokemonFiltered(crossAxisCount: 1, childAspectRatio: 1.7),
              medium: GridViewPokemonFiltered(crossAxisCount: 2, childAspectRatio: 1.5),
              large: GridViewPokemonFiltered(crossAxisCount: 3, childAspectRatio: 1.5),
              xlarge: GridViewPokemonFiltered(crossAxisCount: 5, childAspectRatio: 1.5)),
        ],
      ),
    );
  }
}

class GridViewPokemonFiltered extends StatefulWidget {
  final int crossAxisCount;
  final double childAspectRatio;

  const GridViewPokemonFiltered(
      {super.key, this.crossAxisCount = 2, this.childAspectRatio = 1.5});

  @override
  State<GridViewPokemonFiltered> createState() => _GridViewPokemonFilteredState();
}

class _GridViewPokemonFilteredState extends State<GridViewPokemonFiltered> {
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

  // getNextTen() async {
  //   loaded.value = false;
  //   try {
  //     await pokemonRep.getNextTen();
  //   } catch (e) {
  //     errorStandard();
  //   }
  //   setState(() {
  //     loaded.value = true;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    getFirstTen();
    return Column(
      children: [
        ValueListenableBuilder(
            valueListenable: loaded,
            builder: (context, bool isLoaded, child) {
              return (isLoaded && pokemonList.isNotEmpty)
                  ? GridView.builder(
                      padding: const EdgeInsets.only(left: 25, right: 25),
                      itemCount: 10,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 1.5),
                      itemBuilder: (context, index) {
                        return PokemonItem(pokemon: pokemonList[index]);
                      },
                    )
                  : const Padding(
                      padding: EdgeInsets.only(top: 50, bottom: 20),
                      child: Center(
                        child: CircularProgressIndicator.adaptive(),
                      ),
                    );
            }),
        const SizedBox(height: 15),
        // ValueListenableBuilder(
        //     valueListenable: loaded,
        //     builder: (context, bool isLoaded, child) {
        //       return (isLoaded && pokemonList.isNotEmpty)
        //           ? CustomButton(
        //               title: 'Carregar +10',
        //               onPressed: () async {
        //                 setState(() {
        //                   getNextTen();
        //                 });
        //               })
        //           : Container();
        //     }),
        // const SizedBox(height: 15),
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
