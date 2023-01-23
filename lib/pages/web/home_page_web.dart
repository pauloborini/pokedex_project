import 'package:flutter/material.dart';

import '../../components/home/gridview_pokemon.dart';
import '../../components/web/header_home_web.dart';
import '../../utils/constants.dart';
import '../../utils/responsive.dart';

class HomePageWeb extends StatelessWidget {
  const HomePageWeb({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Responsive.isXTest(context)
        ? Scaffold(
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
                )
              ],
            ),
          )
        : Scaffold(
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
                SingleChildScrollView(
                  child: Center(
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: maxWidth),
                      child: Column(
                        children: const [
                          HeaderHomeWeb(),
                          PokemonsView(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
