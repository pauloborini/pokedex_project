import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_inicie/components/home/search_component.dart';
import 'package:pokedex_inicie/generated/assets.dart';
import 'package:pokedex_inicie/utils/constants.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.sizedDevice.height * 0.22,
      margin: const EdgeInsets.symmetric(horizontal: 14),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: headerBackground,
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Spacer(),
              const Text(
                "Pokedéx",
                style: TextStyle(
                    color: secondaryColor, fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 5, bottom: 19),
                child: Text(
                  "Todas as espécies de pokemons\nestão esperando por você!",
                  style: TextStyle(fontSize: 14, color: secondaryColor),
                ),
              ),
              SearchComponent(),
              const Spacer(),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: SizedBox(
              width: 100,
              height: 99,
              child: Image.asset(Assets.imagesPikachu),
            ),
          )
        ],
      ),
    );
  }
}
