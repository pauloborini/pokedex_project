import 'package:flutter/material.dart';
import 'package:pokedex_inicie/utils/responsive.dart';

class HomePageWeb extends StatelessWidget {
  const HomePageWeb({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Responsive.isXTest(context)
        ? Scaffold(
            backgroundColor: Theme.of(context).backgroundColor,
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).backgroundColor,
            ),
            backgroundColor: Theme.of(context).backgroundColor,
          );
  }
}
