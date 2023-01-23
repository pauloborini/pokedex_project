import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../generated/assets.dart';
import '../../models/pokemon.dart';
import '../../utils/constants.dart';
import '../../utils/responsive.dart';
import '../type_button.dart';
import 'skills_component.dart';

class ColumnDetailWeb extends StatelessWidget {
  final String pokemonDesc;
  final Pokemon pokemon;

  const ColumnDetailWeb({super.key, required this.pokemon, required this.pokemonDesc});

  @override
  Widget build(BuildContext context) {
    var test = Responsive.isTest(context);
    var small = Responsive.isSmall(context);
    var medium = Responsive.isMedium(context);

    double fontSize22 = test
        ? 18
        : small
            ? 18
            : medium
                ? 22
                : 22;
    double fontSize18 = test
        ? 16
        : small
            ? 16
            : medium
                ? 18
                : 18;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 110,
          child: Image.asset(Assets.imagesInicieLogo),
        ),
        Container(
          alignment: Alignment.centerLeft,
          child: AutoSizeText(
              pokemon.name.substring(0, 1).toUpperCase() +
                  pokemon.name.substring(1, pokemon.name.length),
              maxLines: 1,
              minFontSize: 20,
              style: const TextStyle(
                  color: descriptionColor, fontSize: 35, fontWeight: FontWeight.bold)),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("Cod: #${pokemon.id}",
                style: TextStyle(fontSize: fontSize22, color: descriptionColor)),
          ],
        ),
        Row(
          children: [
            Text('Tipo:',
                style: TextStyle(fontSize: fontSize22, color: descriptionColor)),
            const SizedBox(width: 14),
            TypeButton(text: pokemon.type),
          ],
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 244,
          child: Image.network(
            pokemon.image,
            fit: BoxFit.cover,
            alignment: Alignment.center,
          ),
        ),
        const SizedBox(height: 31),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("Descrição",
                style: TextStyle(
                    color: descriptionColor,
                    fontSize: fontSize22,
                    fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: context.sizedDevice.width * 0.8,
          child: Text('"${pokemonDesc.replaceAll("\n", "")}"',
              maxLines: 6,
              textAlign: TextAlign.left,
              style: const TextStyle(
                  color: descriptionColor, fontSize: 16, fontWeight: FontWeight.w600)),
        ),
        const SizedBox(height: 25),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("Informações",
                style: TextStyle(
                    color: descriptionColor,
                    fontSize: fontSize22,
                    fontWeight: FontWeight.bold)),
          ],
        ),
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
                value: test
                    ? pokemon.hp
                    : small
                        ? pokemon.hp + 20
                        : pokemon.hp + 50,
                valueText: pokemon.hp.toString(),
              ),
              SkillsComponent(
                stat: 'Defesa',
                color: colorsSkills[1],
                value: test
                    ? pokemon.defense
                    : small
                        ? pokemon.defense + 20
                        : pokemon.defense + 50,
                valueText: pokemon.defense.toString(),
              ),
              SkillsComponent(
                stat: 'Ataque',
                color: colorsSkills[3],
                value: test
                    ? pokemon.attack
                    : small
                        ? pokemon.attack + 20
                        : pokemon.attack + 50,
                valueText: pokemon.attack.toString(),
              ),
              SkillsComponent(
                stat: 'Velocidade',
                color: colorsSkills[2],
                value: test
                    ? pokemon.speed
                    : small
                        ? pokemon.speed + 20
                        : pokemon.speed + 50,
                valueText: pokemon.speed.toString(),
              ),
              SkillsComponent(
                stat: 'Ataque Especial',
                color: colorsSkills[4],
                value: test
                    ? pokemon.specialAttack
                    : small
                        ? pokemon.specialAttack + 20
                        : pokemon.specialAttack + 50,
                valueText: pokemon.specialAttack.toString(),
              ),
              SkillsComponent(
                stat: 'Defesa Especial',
                color: colorsSkills[5],
                value: test
                    ? pokemon.specialDefense
                    : small
                        ? pokemon.specialDefense + 20
                        : pokemon.specialDefense + 50,
                valueText: pokemon.specialDefense.toString(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
