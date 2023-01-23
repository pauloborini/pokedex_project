import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_inicie/pages/mobile/home_page.dart';

class NetCheck extends StatefulWidget {
  final ConnectivityResult connectivityResult;

  const NetCheck({Key? key, required this.connectivityResult}) : super(key: key);

  @override
  State<NetCheck> createState() => _NetCheckState();
}

class _NetCheckState extends State<NetCheck> {
  @override
  Widget build(BuildContext context) {
    if (widget.connectivityResult == ConnectivityResult.none) {
      return const Scaffold(
        body: Center(
          child: Text('Sem conexão com a Internet, o App não funcionará assim.'),
        ),
      );
    } else {
      return HomePage(currentIndex: 0);
    }
  }
}
