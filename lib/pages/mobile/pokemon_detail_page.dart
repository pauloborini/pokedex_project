import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_inicie/components/pokemon_detail/row_detail_web.dart';
import 'package:pokedex_inicie/components/pokemon_detail/skills_component.dart';
import 'package:pokedex_inicie/components/type_button.dart';
import 'package:pokedex_inicie/generated/assets.dart';
import 'package:pokedex_inicie/models/pokemon.dart';
import 'package:pokedex_inicie/repositories/favorites_repository.dart';
import 'package:pokedex_inicie/repositories/pokemon_repository.dart';
import 'package:pokedex_inicie/utils/constants.dart';
import 'package:pokedex_inicie/utils/responsive.dart';
import 'package:provider/provider.dart';
import 'package:social_share/social_share.dart';

import '../../components/pokemon_detail/column_detail_web.dart';
import '../web/home_page_web.dart';

class PokemonDetailPage extends StatefulWidget {
  final Pokemon pokemon;

  const PokemonDetailPage({super.key, required this.pokemon});

  @override
  State<PokemonDetailPage> createState() => _PokemonDetailPageState();
}

class _PokemonDetailPageState extends State<PokemonDetailPage> {
  ValueNotifier<bool> loaded = ValueNotifier(false);
  late String pokemonDesc;

  getPokemonDesc() async {
    loaded.value = false;
    pokemonDesc = await Provider.of<PokemonRepository>(context)
        .getPokemonDescription(widget.pokemon.id);
    loaded.value = true;
  }

  sharePokemon(Pokemon pokemon) async {
    String shareText = "Veja esse Pokémon incrível: ${pokemon.name} #${pokemon.id}, "
        "HP: ${pokemon.hp}, DEF: ${pokemon.defense}, ATA: ${pokemon.attack}, VEL: "
        "${pokemon.speed}, "
        "#pokedexinicie";
    SocialShare.shareOptions(shareText).catchError((onError) => null);
  }

  @override
  Widget build(BuildContext context) {
    getPokemonDesc();
    return Responsive.isXTest(context)
        ? Scaffold(backgroundColor: Theme.of(context).backgroundColor)
        : !kIsWeb
            ? returnScaffoldMobile()
            : returnScaffoldWeb();
  }

  Scaffold returnScaffoldMobile() {
    final favoritesRep = Provider.of<FavoritesRepository>(context);
    final favoriteList = favoritesRep.favoritesList;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundPokePageColor,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: secondaryColor, size: 20),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Image.asset(Assets.imagesInicieLogo, width: 110),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 25),
            child: CircleAvatar(
              radius: 16,
              backgroundImage: AssetImage(Assets.imagesUser),
            ),
          ),
        ],
      ),
      body: ValueListenableBuilder(
          valueListenable: loaded,
          builder: (context, bool isLoaded, child) {
            return (isLoaded && pokemonDesc.length > 10)
                ? SingleChildScrollView(
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: maxWidth),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: context.sizedDevice.height * 0.38,
                            width: double.infinity,
                            decoration: const BoxDecoration(
                                color: headerBackground,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20))),
                            alignment: Alignment.center,
                            child: Image.network(
                              widget.pokemon.image,
                              height: 210,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                        widget.pokemon.name
                                                .substring(0, 1)
                                                .toUpperCase() +
                                            widget.pokemon.name
                                                .substring(1, widget.pokemon.name.length),
                                        style: const TextStyle(
                                            color: descriptionColor,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold)),
                                    const Spacer(),
                                    Padding(
                                        padding: const EdgeInsets.only(right: 4),
                                        child: IconButton(
                                          onPressed: () {
                                            favoritesRep.saveFavorite(widget.pokemon);
                                          },
                                          icon: !favoriteList.any((pokemon) =>
                                                  pokemon.id == widget.pokemon.id)
                                              ? const Icon(
                                                  CupertinoIcons.heart,
                                                  color: Colors.black38,
                                                )
                                              : const Icon(
                                                  CupertinoIcons.heart_fill,
                                                  color: Colors.red,
                                                ),
                                        )),
                                    IconButton(
                                      icon: const Icon(Icons.share,
                                          color: Colors.black38, size: 20),
                                      onPressed: () {
                                        sharePokemon(widget.pokemon);
                                      },
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 4, bottom: 8),
                                  child: Row(
                                    children: [
                                      Text("Cod: #${widget.pokemon.id}",
                                          style: const TextStyle(
                                              fontSize: 14, color: descriptionColor)),
                                      const Spacer(),
                                      TypeButton(text: widget.pokemon.type),
                                    ],
                                  ),
                                ),
                                const Text("Descrição",
                                    style: TextStyle(
                                        color: descriptionColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(height: 5),
                                AutoSizeText('"${pokemonDesc.replaceAll("\n", "")}"',
                                    maxLines: 5,
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                        color: descriptionColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600)),
                                const SizedBox(height: 20),
                                SkillsComponent(
                                  stat: 'Vida',
                                  color: colorsSkills[0],
                                  value: widget.pokemon.hp + 50,
                                  valueText: '',
                                ),
                                SkillsComponent(
                                  stat: 'Defesa',
                                  color: colorsSkills[1],
                                  value: widget.pokemon.defense + 50,
                                  valueText: '',
                                ),
                                SkillsComponent(
                                  stat: 'Ataque',
                                  color: colorsSkills[3],
                                  value: widget.pokemon.attack + 50,
                                  valueText: '',
                                ),
                                SkillsComponent(
                                  stat: 'Velocidade',
                                  color: colorsSkills[2],
                                  value: widget.pokemon.speed + 50,
                                  valueText: '',
                                ),
                                SkillsComponent(
                                  stat: 'Ataque Especial',
                                  color: colorsSkills[4],
                                  value: widget.pokemon.specialAttack + 50,
                                  valueText: '',
                                ),
                                SkillsComponent(
                                  stat: 'Defesa Especial',
                                  color: colorsSkills[5],
                                  value: widget.pokemon.specialDefense + 50,
                                  valueText: '',
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                : const Center(child: CircularProgressIndicator.adaptive());
          }),
    );
  }

  Scaffold returnScaffoldWeb() {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    CupertinoPageRoute(builder: (context) => const HomePageWeb()));
              },
              icon:
                  const Icon(Icons.arrow_back_ios_new, size: 30, color: secondaryColor))),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              const Color(0xFFEFF4FA),
              const Color(0xFFEFF4FA),
              const Color(0xFFEFF4FA),
              const Color(0xFFEFF4FA).withOpacity(0),
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          ),
          Responsive.isXLarge(context)
              ? Positioned(
                  right: 0,
                  top: 50,
                  child: Image.asset(
                    Assets.imagesCirclesElement,
                    fit: BoxFit.fill,
                    width: 150,
                  ),
                )
              : const SizedBox(),
          ValueListenableBuilder(
              valueListenable: loaded,
              builder: (context, bool isLoaded, child) {
                return (isLoaded && pokemonDesc.length > 10)
                    ? SingleChildScrollView(
                        child: Center(
                          child: Stack(
                            children: [
                              Responsive.isXLarge(context)
                                  ? Positioned(
                                      left: -50,
                                      top: 450,
                                      child: Image.asset(
                                        Assets.imagesCirclesElement,
                                        fit: BoxFit.fill,
                                        width: 100,
                                      ),
                                    )
                                  : const SizedBox(),
                              Container(
                                  margin: const EdgeInsets.fromLTRB(50, 50, 50, 20),
                                  constraints: const BoxConstraints(maxWidth: maxWidth),
                                  child: Responsive.isTest(context)
                                      ? ColumnDetailWeb(
                                          pokemon: widget.pokemon,
                                          pokemonDesc: pokemonDesc)
                                      : Responsive.isSmall(context)
                                          ? ColumnDetailWeb(
                                              pokemon: widget.pokemon,
                                              pokemonDesc: pokemonDesc)
                                          : Responsive.isMedium(context)
                                              ? ColumnDetailWeb(
                                                  pokemon: widget.pokemon,
                                                  pokemonDesc: pokemonDesc)
                                              : Responsive.isLarge(context)
                                                  ? RowDetailWeb(
                                                      pokemon: widget.pokemon,
                                                      pokemonDesc: pokemonDesc)
                                                  : RowDetailWeb(
                                                      pokemon: widget.pokemon,
                                                      pokemonDesc: pokemonDesc)),
                            ],
                          ),
                        ),
                      )
                    : const Center(child: CircularProgressIndicator.adaptive());
              }),
        ],
      ),
    );
  }
}
