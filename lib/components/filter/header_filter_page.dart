import 'package:flutter/material.dart';
import 'package:pokedex_inicie/components/type_button.dart';
import 'package:pokedex_inicie/utils/constants.dart';

class HeaderFilterPage extends StatelessWidget {
  final String type;

  const HeaderFilterPage({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25),
      height: context.sizedDevice.height * 0.08,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: headerBackground,
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Padding(
          padding: EdgeInsets.only(right: 8),
          child: Text(
            'Pokemons do tipo:',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, color: secondaryColor),
          ),
        ),
        TypeButton(text: type)
      ]),
    );
  }
}
