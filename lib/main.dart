import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pokedex_inicie/database/hive_config.dart';
import 'package:pokedex_inicie/pages/mobile/start_page.dart';
import 'package:pokedex_inicie/pages/web/home_page_web.dart';
import 'package:pokedex_inicie/repositories/favorites_repository.dart';
import 'package:pokedex_inicie/repositories/pokemon_repository.dart';
import 'package:pokedex_inicie/utils/constants.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final connectivityResult = await (Connectivity().checkConnectivity());
  await HiveConfig.start();
  runApp(MyApp(connectivityResult: connectivityResult));
}

class MyApp extends StatelessWidget {
  final ConnectivityResult connectivityResult;

  const MyApp({super.key, required this.connectivityResult});

  @override
  Widget build(BuildContext context) {
    final orientation =
        SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    kIsWeb ? null : orientation;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PokemonRepository()),
        ChangeNotifierProvider(create: (context) => FavoritesRepository()),
      ],
      child: MaterialApp(
        scrollBehavior: MyCustomScrollBehavior(),
        title: 'Inicie Pokedex',
        theme: ThemeData(
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                showUnselectedLabels: true,
                showSelectedLabels: true,
                elevation: 0,
                selectedLabelStyle: TextStyle(fontSize: 14, color: secondaryColor),
                unselectedLabelStyle: TextStyle(fontSize: 14),
                unselectedIconTheme: IconThemeData(color: Colors.black38),
                selectedIconTheme: IconThemeData(color: secondaryColor),
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.black87),
            fontFamily: "Nunito",
            brightness: Brightness.light,
            backgroundColor: stanColor,
            primaryColor: primaryColor,
            appBarTheme: const AppBarTheme(
                centerTitle: true,
                elevation: 0,
                scrolledUnderElevation: 0,
                systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.transparent,
                    statusBarIconBrightness: Brightness.dark))),
        home: kIsWeb
            ? const HomePageWeb()
            : StartPage(connectivityResult: connectivityResult),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
