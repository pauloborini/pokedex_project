import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_inicie/components/home/search_component.dart';
import 'package:pokedex_inicie/generated/assets.dart';
import 'package:pokedex_inicie/utils/constants.dart';
import 'package:pokedex_inicie/utils/responsive.dart';

class HeaderHomePage extends StatelessWidget {
  const HeaderHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 152,
      margin: const EdgeInsets.symmetric(horizontal: 14),
      padding: const EdgeInsets.symmetric(horizontal: 20),
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
              const AutoSizeText(
                "Pokedéx",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                minFontSize: 12,
                style: TextStyle(
                    color: secondaryColor, fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: Responsive.isTest(context)
                    ? 180
                    : Responsive.isSmall(context)
                        ? 220
                        : 250,
                child: const AutoSizeText(
                  "Todas as espécies de pokemons\nestão esperando por você!",
                  maxLines: 2,
                  minFontSize: 10,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14, color: secondaryColor),
                ),
              ),
              const SizedBox(height: 8),
              SearchComponent(),
              const Spacer(),
            ],
          ),
          Spacer(),
          Expanded(
            flex: 10,
            child: Image.asset(Assets.imagesPikachu),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
