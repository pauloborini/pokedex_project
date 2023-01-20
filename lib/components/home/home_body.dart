import 'package:flutter/material.dart';
import 'package:pokedex_inicie/components/home/category_slider.dart';
import 'package:pokedex_inicie/components/home/gridview_pokemon.dart';
import 'package:pokedex_inicie/components/home/header_widget.dart';
import 'package:pokedex_inicie/generated/assets.dart';
import 'package:pokedex_inicie/utils/constants.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onPanDown: (_) {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Stack(children: [
        Positioned(
          right: 0,
          top: 118,
          child: Image.asset(
            Assets.imagesCirclesElement,
            width: 55,
          ),
        ),
        SingleChildScrollView(
            child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: maxWidth),
            child: Column(
              children: [
                SizedBox(height: context.sizedDevice.height * 0.17),
                const HeaderWidget(),
                const CategorySlider(),
                const PokemonsView(),
              ],
            ),
          ),
        ))
      ]),
    );
  }
}
