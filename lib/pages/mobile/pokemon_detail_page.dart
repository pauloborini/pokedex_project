import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pokedex_inicie/components/pokemon_detail/skills_component.dart';
import 'package:pokedex_inicie/components/type_button.dart';
import 'package:pokedex_inicie/generated/assets.dart';
import 'package:pokedex_inicie/models/pokemon.dart';
import 'package:pokedex_inicie/repositories/pokemon_repository.dart';
import 'package:pokedex_inicie/utils/constants.dart';
import 'package:provider/provider.dart';

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
        .getPokemonDescription(widget.pokemon.id!);
    loaded.value = true;
  }

  @override
  Widget build(BuildContext context) {
    getPokemonDesc();
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
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                          widget.pokemon.name
                                                  .substring(0, 1)
                                                  .toUpperCase() +
                                              widget.pokemon.name.substring(
                                                  1, widget.pokemon.name.length),
                                          style: const TextStyle(
                                              color: descriptionColor,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold)),
                                      const Spacer(),
                                      const Padding(
                                        padding: EdgeInsets.only(right: 4),
                                        child: Icon(
                                          FontAwesomeIcons.heart,
                                          color: Colors.grey,
                                          size: 20,
                                        ),
                                      ),
                                      const Icon(Icons.share,
                                          color: Colors.black38, size: 20)
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
                                  Text('"${pokemonDesc.replaceAll("\n", "")}"',
                                      style: const TextStyle(
                                          color: descriptionColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600)),
                                  const SizedBox(height: 20),
                                  SkillsComponent(
                                      stat: 'Vida',
                                      color: colorsSkills[0],
                                      value: widget.pokemon.hp + 70),
                                  SkillsComponent(
                                      stat: 'Defesa',
                                      color: colorsSkills[1],
                                      value: widget.pokemon.defense + 70),
                                  SkillsComponent(
                                      stat: 'Ataque',
                                      color: colorsSkills[3],
                                      value: widget.pokemon.attack + 70),
                                  SkillsComponent(
                                      stat: 'Velocidade',
                                      color: colorsSkills[2],
                                      value: widget.pokemon.speed + 70),
                                  SkillsComponent(
                                      stat: 'Ataque Especial',
                                      color: colorsSkills[4],
                                      value: widget.pokemon.specialAttack + 70),
                                  SkillsComponent(
                                      stat: 'Defesa Especial',
                                      color: colorsSkills[5],
                                      value: widget.pokemon.specialDefense + 70),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  : const Center(child: CircularProgressIndicator.adaptive());
            }));
  }

  final colorsSkills = [
    const Color(0xFFC4F789),
    const Color(0xFFF7802A),
    const Color(0xFF49D0B0),
    const Color(0xFFEA686D),
    const Color(0xFF85ABD9),
    const Color(0xFFFDEF51),
  ];
}
