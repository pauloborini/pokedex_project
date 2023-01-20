import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pokedex_inicie/components/filter/gridview_filtered_pokemon.dart';
import 'package:pokedex_inicie/components/filter/header_filter_page.dart';
import 'package:pokedex_inicie/generated/assets.dart';
import 'package:pokedex_inicie/pages/mobile/home_page.dart';
import 'package:pokedex_inicie/utils/constants.dart';
import 'package:pokedex_inicie/utils/responsive.dart';

class FilterPage extends StatefulWidget {
  final String type;

  const FilterPage({super.key, required this.type});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Responsive.isXTest(context)
        ? Scaffold(
            backgroundColor: Theme.of(context).backgroundColor,
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).backgroundColor,
              leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new,
                      color: secondaryColor, size: 20),
                  onPressed: () => Navigator.pop(context)),
              title: Image.asset(
                Assets.imagesInicieLogo,
                width: 110,
              ),
              actions: const [
                Padding(
                  padding: EdgeInsets.only(right: 25),
                  child: CircleAvatar(
                      radius: 16, backgroundImage: AssetImage(Assets.imagesUser)),
                ),
              ],
            ),
            backgroundColor: Theme.of(context).backgroundColor,
            body: SingleChildScrollView(
              padding: EdgeInsets.zero,
              child: Container(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    HeaderFilterPage(type: widget.type),
                    const SizedBox(height: 10),
                    PokemonsFilteredView(type: widget.type),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: ClipRRect(
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
              child: BottomNavigationBar(
                backgroundColor: Colors.white,
                currentIndex: currentIndex,
                onTap: (index) {
                  setState(() {
                    Navigator.pushAndRemoveUntil(
                        context,
                        PageRouteBuilder(
                            pageBuilder: (BuildContext context,
                                    Animation<double> animation,
                                    Animation<double> secondaryAnimation) =>
                                HomePage(
                                  currentIndex: index,
                                )),
                        (route) => false);
                  });
                },
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home_outlined, size: 32),
                      activeIcon: Icon(Icons.home, size: 32),
                      label: 'Home'),
                  BottomNavigationBarItem(
                      icon: Icon(FontAwesomeIcons.heart),
                      activeIcon: Icon(FontAwesomeIcons.solidHeart),
                      label: 'Favoritos'),
                  BottomNavigationBarItem(
                      icon: Icon(FontAwesomeIcons.circleUser),
                      activeIcon: Icon(FontAwesomeIcons.solidCircleUser),
                      label: 'Minha'
                          ' Conta'),
                ],
              ),
            ),
          );
  }
}
