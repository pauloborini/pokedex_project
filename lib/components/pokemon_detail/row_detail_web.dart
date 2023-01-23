import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../generated/assets.dart';
import '../../models/pokemon.dart';
import '../../utils/constants.dart';
import '../../utils/responsive.dart';
import '../type_button.dart';
import 'skills_component.dart';

class RowDetailWeb extends StatelessWidget {
  final Pokemon pokemon;
  final String pokemonDesc;

  const RowDetailWeb({super.key, required this.pokemon, required this.pokemonDesc});

  @override
  Widget build(BuildContext context) {
    var large = Responsive.isLarge(context);
    var xLarge = Responsive.isXLarge(context);

    double fontSize22 = large
        ? 18
        : xLarge
            ? 22
            : 22;
    double fontSize18 = large
        ? 16
        : xLarge
            ? 18
            : 18;

    return Row(
      children: [
        SizedBox(
          width: context.sizedDevice.width * 0.35,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              SizedBox(
                width: 110,
                child: Image.asset(Assets.imagesInicieLogo),
              ),
              Text(
                  pokemon.name.substring(0, 1).toUpperCase() +
                      pokemon.name.substring(1, pokemon.name.length),
                  style: const TextStyle(
                      color: descriptionColor,
                      fontSize: 35,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Row(
                children: [
                  Text("Cod: #${pokemon.id}",
                      style: TextStyle(fontSize: fontSize22, color: descriptionColor)),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 17),
                    child: Text('Tipo:',
                        style: TextStyle(fontSize: fontSize22, color: descriptionColor)),
                  ),
                  TypeButton(text: pokemon.type),
                ],
              ),
              const SizedBox(height: 23),
              Text("Descrição",
                  style: TextStyle(
                      color: descriptionColor,
                      fontSize: fontSize22,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              SizedBox(
                width: context.sizedDevice.width * 0.33,
                child: AutoSizeText('"${pokemonDesc.replaceAll("\n", "")}"',
                    maxLines: 5,
                    textAlign: TextAlign.left,
                    minFontSize: 12,
                    style: const TextStyle(
                        color: descriptionColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600)),
              ),
              const SizedBox(height: 25),
              Text("Informações",
                  style: TextStyle(
                      color: descriptionColor,
                      fontSize: fontSize22,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 11),
              Row(
                children: [
                  Text("Altura:",
                      style: TextStyle(
                          color: descriptionColor,
                          fontSize: fontSize18,
                          fontWeight: FontWeight.w600)),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Text("${pokemon.height}cm",
                        style: TextStyle(
                            color: descriptionColor,
                            fontSize: fontSize18,
                            fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Text("Peso:",
                      style: TextStyle(
                          color: descriptionColor,
                          fontSize: fontSize18,
                          fontWeight: FontWeight.w600)),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Text("${pokemon.weight}Kg",
                        style: TextStyle(
                            color: descriptionColor,
                            fontSize: fontSize18,
                            fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              Container(
                color: Colors.transparent,
                child: Column(
                  children: [
                    SkillsComponent(
                      stat: 'Vida',
                      color: colorsSkills[0],
                      value: pokemon.hp +
                          (large
                              ? 20
                              : xLarge
                                  ? 50
                                  : 50),
                      valueText: pokemon.hp.toString(),
                    ),
                    SkillsComponent(
                      stat: 'Defesa',
                      color: colorsSkills[1],
                      value: pokemon.defense +
                          (large
                              ? 20
                              : xLarge
                                  ? 50
                                  : 50),
                      valueText: pokemon.defense.toString(),
                    ),
                    SkillsComponent(
                      stat: 'Ataque',
                      color: colorsSkills[3],
                      value: pokemon.attack +
                          (large
                              ? 20
                              : xLarge
                                  ? 50
                                  : 50),
                      valueText: pokemon.attack.toString(),
                    ),
                    SkillsComponent(
                      stat: 'Velocidade',
                      color: colorsSkills[2],
                      value: pokemon.speed +
                          (large
                              ? 20
                              : xLarge
                                  ? 50
                                  : 50),
                      valueText: pokemon.speed.toString(),
                    ),
                    SkillsComponent(
                      stat: 'Ataque Especial',
                      color: colorsSkills[4],
                      value: pokemon.specialAttack +
                          (large
                              ? 20
                              : xLarge
                                  ? 50
                                  : 50),
                      valueText: pokemon.specialAttack.toString(),
                    ),
                    SkillsComponent(
                      stat: 'Defesa Especial',
                      color: colorsSkills[5],
                      value: pokemon.specialDefense +
                          (large
                              ? 20
                              : xLarge
                                  ? 50
                                  : 50),
                      valueText: pokemon.specialDefense.toString(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Responsive.isXLarge(context)
            ? Expanded(
                flex: 8,
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 2, color: Colors.white, style: BorderStyle.solid),
                      shape: BoxShape.circle),
                  child: CircleAvatar(
                    foregroundColor: Colors.transparent,
                    backgroundColor: Colors.transparent,
                    radius: 300,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 100),
                      child: Image.network(
                        pokemon.image,
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter,
                      ),
                    ),
                  ),
                ),
              )
            : Expanded(
                flex: 8,
                child: Image.network(
                  pokemon.image,
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                ),
              ),
        const Spacer(),
      ],
    );
  }
}
