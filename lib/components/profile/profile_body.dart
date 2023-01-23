import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_inicie/components/pokemon_detail/skills_component.dart';
import 'package:pokedex_inicie/components/type_button.dart';
import 'package:pokedex_inicie/generated/assets.dart';
import 'package:pokedex_inicie/utils/constants.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                      bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))),
              alignment: Alignment.center,
              child: Image.asset(
                Assets.imagesCharizard,
                height: 210,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Text('Paulo Borini',
                          style: TextStyle(
                              color: descriptionColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                      Spacer(),
                      Padding(
                        padding: EdgeInsets.only(right: 8),
                        child: Icon(
                          CupertinoIcons.heart_fill,
                          color: Colors.red,
                        ),
                      ),
                      Icon(Icons.share, color: Colors.black38, size: 20),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4, bottom: 8),
                    child: Row(
                      children: const [
                        Text("Cod: # 007",
                            style: TextStyle(fontSize: 14, color: descriptionColor)),
                        Spacer(),
                        TypeButton(text: 'Itajaí'),
                      ],
                    ),
                  ),
                  const Text("Descrição",
                      style: TextStyle(
                          color: descriptionColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  const Text('"Desenvolvedor Flutter"',
                      style: TextStyle(
                          color: descriptionColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600)),
                  const SizedBox(height: 20),
                  SkillsComponent(
                    stat: 'Vida',
                    color: colorsSkills[0],
                    value: 187,
                    valueText: '',
                  ),
                  SkillsComponent(
                    stat: 'Defesa',
                    color: colorsSkills[1],
                    value: 155,
                    valueText: '',
                  ),
                  SkillsComponent(
                    stat: 'Ataque',
                    color: colorsSkills[3],
                    value: 190,
                    valueText: '',
                  ),
                  SkillsComponent(
                    stat: 'Velocidade',
                    color: colorsSkills[2],
                    value: 155,
                    valueText: '',
                  ),
                  SkillsComponent(
                    stat: 'Ataque Especial',
                    color: colorsSkills[4],
                    value: 165,
                    valueText: '',
                  ),
                  SkillsComponent(
                    stat: 'Defesa Especial',
                    color: colorsSkills[5],
                    value: 172,
                    valueText: '',
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
