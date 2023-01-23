import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_inicie/utils/constants.dart';

import '../../utils/responsive.dart';

class SkillsComponent extends StatelessWidget {
  final String stat;
  final Color color;
  final double value;
  final String valueText;

  const SkillsComponent({
    Key? key,
    required this.stat,
    required this.color,
    required this.value,
    required this.valueText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var test = Responsive.isTest(context);
    var small = Responsive.isSmall(context);
    var medium = Responsive.isMedium(context);
    var large = Responsive.isLarge(context);
    var xLarge = Responsive.isXLarge(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            width: !kIsWeb
                ? 100
                : test
                    ? 100
                    : small
                        ? 120
                        : medium
                            ? 140
                            : large
                                ? 100
                                : xLarge
                                    ? 140
                                    : 140,
            height: !kIsWeb
                ? 20
                : Responsive.isXLarge(context)
                    ? 28
                    : 20,
            child: AutoSizeText(
              stat,
              textAlign: TextAlign.start,
              style: const TextStyle(
                  color: descriptionColor,
                  fontSize: !kIsWeb ? 14 : 16,
                  fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Stack(
              children: [
                Container(
                  width: test
                      ? 150
                      : small
                          ? 170
                          : medium
                              ? 200
                              : large
                                  ? 170
                                  : xLarge
                                      ? 200
                                      : 200,
                  height: !kIsWeb
                      ? 12
                      : test
                          ? 21
                          : small
                              ? 21
                              : medium
                                  ? 21
                                  : large
                                      ? 15
                                      : xLarge
                                          ? 21
                                          : 21,
                  decoration: BoxDecoration(
                      color: const Color(0xFFFBFDFF),
                      borderRadius: BorderRadius.circular(!kIsWeb ? 4 : 2)),
                ),
                Container(
                  height: !kIsWeb
                      ? 12
                      : test
                          ? 21
                          : small
                              ? 21
                              : medium
                                  ? 21
                                  : large
                                      ? 15
                                      : xLarge
                                          ? 21
                                          : 21,
                  width: value,
                  decoration: BoxDecoration(
                      color: color, borderRadius: BorderRadius.circular(!kIsWeb ? 4 : 2)),
                  child: Center(
                    child: Text(
                      valueText,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, color: secondaryColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
        ],
      ),
    );
  }
}
