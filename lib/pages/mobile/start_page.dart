import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_inicie/components/custom_button.dart';
import 'package:pokedex_inicie/generated/assets.dart';
import 'package:pokedex_inicie/pages/users/net_check.dart';
import 'package:pokedex_inicie/utils/constants.dart';
import 'package:pokedex_inicie/utils/responsive.dart';

class StartPage extends StatelessWidget {
  final ConnectivityResult connectivityResult;

  const StartPage({super.key, required this.connectivityResult});

  @override
  Widget build(BuildContext context) {
    return Responsive.isXTest(context)
        ? Scaffold(backgroundColor: Theme.of(context).backgroundColor)
        : Scaffold(
            appBar: AppBar(
                backgroundColor: Theme.of(context).backgroundColor, toolbarHeight: 40),
            backgroundColor: Theme.of(context).backgroundColor,
            body: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.all(10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          Image.asset(
                            Assets.imagesStartPage,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            top: 4,
                            left: 42,
                            child: Image.asset(
                              Assets.imagesInicieLogo,
                              width: 120,
                            ),
                          )
                        ],
                      ),
                      const Text.rich(
                        TextSpan(
                            text: 'Explore o mundo\ndos ',
                            style: TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                                color: secondaryColor,
                                height: 1.1),
                            children: [
                              TextSpan(
                                text: 'Pokémons',
                                style: TextStyle(color: primaryColor),
                              )
                            ]),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      const Text("Descubra todas as espécies de Pokémons",
                          style: TextStyle(
                            color: secondaryColor,
                            fontSize: 16,
                          )),
                      const SizedBox(height: 25),
                      CustomButton(
                          title: "Começar",
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              CupertinoPageRoute(
                                builder: (context) =>
                                    NetCheck(connectivityResult: connectivityResult),
                              ),
                            );
                          }),
                    ]),
              ),
            ),
          );
  }
}
