import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pokedex_inicie/components/favorites/favorites_body.dart';
import 'package:pokedex_inicie/components/home/home_body.dart';
import 'package:pokedex_inicie/components/profile/profile_body.dart';
import 'package:pokedex_inicie/generated/assets.dart';
import 'package:pokedex_inicie/utils/constants.dart';
import 'package:pokedex_inicie/utils/responsive.dart';

class HomePage extends StatefulWidget {
  int currentIndex;

  HomePage({super.key, required this.currentIndex});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    List body = [
      const HomeBody(),
      const FavoritesBody(),
      const ProfileBody(),
    ];
    return Responsive.isXTest(context)
        ? Scaffold(
            backgroundColor: Theme.of(context).backgroundColor,
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).backgroundColor,
              leading: const Icon(Icons.menu, color: secondaryColor, size: 28),
              title: Image.asset(
                Assets.imagesInicieLogo,
                width: 110,
              ),
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
            backgroundColor: Theme.of(context).backgroundColor,
            extendBodyBehindAppBar: true,
            body: body.elementAt(widget.currentIndex),
            bottomNavigationBar: ClipRRect(
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
              child: BottomNavigationBar(
                backgroundColor: Colors.white,
                currentIndex: widget.currentIndex,
                onTap: (index) {
                  setState(() {
                    widget.currentIndex = index;
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
