import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pokedex_inicie/components/home/category_button.dart';
import 'package:pokedex_inicie/database/category_data.dart';
import 'package:pokedex_inicie/utils/constants.dart';

class CategorySlider extends StatefulWidget {
  const CategorySlider({super.key});

  @override
  State<CategorySlider> createState() => _CategorySliderState();
}

class _CategorySliderState extends State<CategorySlider> {
  List<Widget> categoryList = [];

  void getCategories() {
    List<dynamic> responseData = categoryData;
    List<Widget> itemsList = [];
    responseData.forEach((category) {
      itemsList.add(CategoryButton(
          nameCategory: category["category"], colorCategory: Color(randomColor())));
    });
    setState(() {
      categoryList = itemsList;
    });
  }

  @override
  void initState() {
    getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Row(
            children: const [
              Padding(
                padding: EdgeInsets.only(left: 25, top: 19, bottom: 10),
                child: Text(
                  'Tipo',
                  style: TextStyle(
                      fontSize: 16, color: secondaryColor, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(left: 25),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: categoryList,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  int randomColor() {
    final random = Random();
    final int index = random.nextInt(colors.length);
    return colors[index];
  }
}
