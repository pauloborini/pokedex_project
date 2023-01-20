import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pokedex_inicie/utils/constants.dart';

class TypeButton extends StatelessWidget {
  final String text;

  const TypeButton({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      width: 67,
      height: 24,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: Color(randomColor())),
      child: FittedBox(
        child: Text(
          text.substring(0, 1).toUpperCase() + text.substring(1, text.length),
          style: const TextStyle(fontSize: 14, color: Colors.white),
        ),
      ),
    );
  }

  int randomColor() {
    final random = Random();
    final int index = random.nextInt(colors.length);
    return colors[index];
  }
}
