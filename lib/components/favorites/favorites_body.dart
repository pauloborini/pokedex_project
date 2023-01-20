import 'package:flutter/material.dart';
import 'package:pokedex_inicie/components/favorites/gridview_favorites.dart';
import 'package:pokedex_inicie/components/favorites/header_favorites_page.dart';

class FavoritesBody extends StatelessWidget {
  const FavoritesBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: const [HeaderFavoritesPage(), SizedBox(height: 10), FavoritesView()],
        ),
      ),
    );
  }
}
