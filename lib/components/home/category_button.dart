import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_inicie/pages/mobile/filter_page.dart';

class CategoryButton extends StatelessWidget {
  final String nameCategory;
  final Color colorCategory;

  const CategoryButton(
      {super.key, required this.nameCategory, required this.colorCategory});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 7),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(CupertinoPageRoute(
              builder: (contextNew) => FilterPage(type: nameCategory)));
        },
        child: Container(
          padding: const EdgeInsets.all(2),
          width: 67,
          height: 24,
          decoration:
              BoxDecoration(borderRadius: BorderRadius.circular(5), color: colorCategory),
          child: FittedBox(
            child: Text(
              nameCategory,
              style: const TextStyle(fontSize: 14, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
