import 'package:flutter/material.dart';
import 'package:pokedex_inicie/components/home/pokemon_item.dart';
import 'package:pokedex_inicie/models/pokemon.dart';
import 'package:pokedex_inicie/repositories/favorites_repository.dart';
import 'package:pokedex_inicie/utils/constants.dart';
import 'package:pokedex_inicie/utils/responsive.dart';
import 'package:provider/provider.dart';

class FavoritesView extends StatelessWidget {
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: const [
          Responsive(
              small: GridViewFavoritesPokemon(crossAxisCount: 1, childAspectRatio: 1.7),
              medium: GridViewFavoritesPokemon(crossAxisCount: 2, childAspectRatio: 1.5),
              large: GridViewFavoritesPokemon(crossAxisCount: 3, childAspectRatio: 1.5),
              xlarge: GridViewFavoritesPokemon(crossAxisCount: 5, childAspectRatio: 1.5)),
        ],
      ),
    );
  }
}

class GridViewFavoritesPokemon extends StatefulWidget {
  final int crossAxisCount;
  final double childAspectRatio;

  const GridViewFavoritesPokemon(
      {super.key, this.crossAxisCount = 2, this.childAspectRatio = 1.5});

  @override
  State<GridViewFavoritesPokemon> createState() => _GridViewFavoritesPokemonState();
}

class _GridViewFavoritesPokemonState extends State<GridViewFavoritesPokemon> {
  ValueNotifier<bool> loaded = ValueNotifier(false);
  late FavoritesRepository favoritesRep;
  late List<Pokemon> favoritesList;

  getFavorites() async {
    loaded.value = false;
    try {
      favoritesRep = Provider.of<FavoritesRepository>(context);
      favoritesList = favoritesRep.favoritesList;
      loaded.value = true;
    } catch (e) {
      errorStandard();
    }
  }

  @override
  Widget build(BuildContext context) {
    getFavorites();
    return Column(
      children: [
        ValueListenableBuilder(
            valueListenable: loaded,
            builder: (context, bool isLoaded, child) {
              if (favoritesList.isNotEmpty) {
                return (isLoaded)
                    ? GridView.builder(
                        padding: const EdgeInsets.only(left: 25, right: 25),
                        itemCount: favoritesList.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 1.5),
                        itemBuilder: (context, index) {
                          return PokemonItem(pokemon: favoritesList[index]);
                        },
                      )
                    : const Padding(
                        padding: EdgeInsets.only(top: 50, bottom: 20),
                        child: Center(
                          child: CircularProgressIndicator.adaptive(),
                        ),
                      );
              } else {
                return const Center(
                  child: Text('Sem Pokemons para exibir.',
                      style: TextStyle(
                          fontSize: 20,
                          color: secondaryColor,
                          fontWeight: FontWeight.w600)),
                );
              }
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
