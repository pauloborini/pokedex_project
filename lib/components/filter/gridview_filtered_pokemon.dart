import 'package:flutter/material.dart';
import 'package:pokedex_inicie/components/home/pokemon_item.dart';
import 'package:pokedex_inicie/models/pokemon.dart';
import 'package:pokedex_inicie/repositories/pokemon_repository.dart';
import 'package:pokedex_inicie/utils/responsive.dart';
import 'package:provider/provider.dart';

class PokemonsFilteredView extends StatelessWidget {
  final String type;

  const PokemonsFilteredView({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Responsive(
            test: GridViewPokemonFiltered(
                crossAxisCount: 1, childAspectRatio: 1.7, text: type),
            small: GridViewPokemonFiltered(
                crossAxisCount: 1, childAspectRatio: 1.7, text: type),
            medium: GridViewPokemonFiltered(
                crossAxisCount: 2, childAspectRatio: 1.5, text: type),
            large: GridViewPokemonFiltered(
                crossAxisCount: 3, childAspectRatio: 1.5, text: type),
            xlarge: GridViewPokemonFiltered(
                crossAxisCount: 5, childAspectRatio: 1.5, text: type),
          ),
        ],
      ),
    );
  }
}

class GridViewPokemonFiltered extends StatefulWidget {
  final String text;
  final int crossAxisCount;
  final double childAspectRatio;

  const GridViewPokemonFiltered(
      {super.key,
      this.crossAxisCount = 2,
      this.childAspectRatio = 1.5,
      required this.text});

  @override
  State<GridViewPokemonFiltered> createState() => _GridViewPokemonFilteredState();
}

class _GridViewPokemonFilteredState extends State<GridViewPokemonFiltered> {
  ValueNotifier<bool> loaded = ValueNotifier(false);
  late PokemonRepository pokemonRep;
  late List<Pokemon> pokemonFilteredList;

  getFilteredPokemons() async {
    loaded.value = false;
    try {
      pokemonRep = Provider.of<PokemonRepository>(context);
      pokemonFilteredList = await Provider.of<PokemonRepository>(context, listen: false)
          .getFilteredPokemons(widget.text.toLowerCase());
      loaded.value = true;
    } catch (e) {
      errorStandard();
    }
  }

  @override
  Widget build(BuildContext context) {
    getFilteredPokemons();
    return Column(
      children: [
        ValueListenableBuilder(
            valueListenable: loaded,
            builder: (context, bool isLoaded, child) {
              return (isLoaded)
                  ? GridView.builder(
                      padding: const EdgeInsets.only(left: 25, right: 25),
                      itemCount: pokemonFilteredList.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 1.5),
                      itemBuilder: (context, index) {
                        return PokemonItem(pokemon: pokemonFilteredList[index]);
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
