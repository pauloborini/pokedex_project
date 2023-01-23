import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_inicie/components/home/search_component.dart';
import 'package:pokedex_inicie/utils/constants.dart';
import 'package:pokedex_inicie/utils/responsive.dart';

import '../../generated/assets.dart';

class HeaderHomeWeb extends StatelessWidget {
  const HeaderHomeWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return const Responsive(
      test: HeaderConfigure(
        padding: 15,
        component: SmallAndTest(),
      ),
      small: HeaderConfigure(
        padding: 15,
        component: SmallAndTest(),
      ),
      medium: HeaderConfigure(
        padding: 20,
        component: XLargeLargeAndMedium(),
      ),
      large: HeaderConfigure(
        padding: 30,
        component: XLargeLargeAndMedium(),
      ),
      xlarge: HeaderConfigure(
        padding: 40,
        component: XLargeLargeAndMedium(),
      ),
    );
  }
}

class HeaderConfigure extends StatelessWidget {
  final double padding;
  final Widget component;

  const HeaderConfigure({super.key, required this.padding, required this.component});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: padding), child: component);
  }
}

class XLargeLargeAndMedium extends StatelessWidget {
  const XLargeLargeAndMedium({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = context.sizedDevice.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Image.asset(
                Assets.imagesInicieLogo,
                height: Responsive.isMedium(context) ? 40 : 60,
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: width * 0.32,
                child: const FittedBox(
                  child: AutoSizeText.rich(
                    TextSpan(
                        text: 'Explore o mundo\ndos ',
                        style: TextStyle(
                            fontSize: 55,
                            fontWeight: FontWeight.bold,
                            color: secondaryColor,
                            height: 1.1),
                        children: [
                          TextSpan(
                            text: 'Pokémons',
                            style: TextStyle(color: primaryColor),
                          )
                        ]),
                    minFontSize: 35,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: width * 0.42,
                child: const FittedBox(
                  child: AutoSizeText(
                    "Descubra todas as espécies de Pokémons",
                    maxLines: 1,
                    minFontSize: 18,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: secondaryColor, fontSize: 25),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              SearchComponent(),
            ],
          ),
        ),
        Expanded(
          child: Image.asset(
            Assets.imagesStartPageWeb,
            fit: BoxFit.contain,
          ),
        ),
      ],
    );
  }
}

class SmallAndTest extends StatelessWidget {
  const SmallAndTest({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = context.sizedDevice.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(Assets.imagesInicieLogo, height: 55),
        Container(
          alignment: Alignment.center,
          width: double.maxFinite,
          child: Image.asset(
            Assets.imagesStartPageWebResponsive,
            fit: BoxFit.fitHeight,
          ),
        ),
        SizedBox(
          width: width * 0.60,
          child: const FittedBox(
            alignment: Alignment.center,
            child: Text.rich(
              TextSpan(
                  text: 'Explore o mundo\n  dos ',
                  style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: secondaryColor,
                      height: 1.1),
                  children: [
                    TextSpan(
                      text: 'Pokémons',
                      style: TextStyle(
                        color: primaryColor,
                      ),
                    )
                  ]),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          width: width * 0.8,
          child: const FittedBox(
            child: AutoSizeText(
              "Descubra todas as espécies de Pokémons",
              maxLines: 1,
              minFontSize: 16,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: secondaryColor, fontSize: 25),
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        SearchComponent(),
      ],
    );
  }
}
