import 'package:flutter/material.dart';

const padding = 20.0;
const duration = Duration(milliseconds: 500);
const maxWidth = 1440.0;

const Color stanColor = Color.fromARGB(255, 246, 246, 246);
const Color headerBackground = Color.fromRGBO(241, 176, 179, 0.1);
const Color pokeItemBackColor = Color.fromARGB(255, 253, 253, 253);
const Color backWeb = Color.fromARGB(255, 239, 244, 250);
const Color primaryColor = Color(0xFFEA686D);
const Color secondaryColor = Color(0xFF2F3E77);
const Color descriptionColor = Color(0xFF233674);
const Color backgroundPokePageColor = Color(0xFFF7F1F1);

extension SizedDevice on BuildContext {
  Size get sizedDevice => MediaQuery.of(this).size;
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

final List<int> colors = [
  -23505422,
  -14049492,
  -16777216,
  -13251864,
  -14583081,
  -13777544,
  -14587851,
  -36958642,
  -16925816,
  -26964147,
];
