import 'package:flutter/material.dart';
import 'package:pokedex_inicie/utils/constants.dart';

class SkillsComponent extends StatelessWidget {
  final String stat;
  final Color color;
  final double value;
  final bool isMobile;

  const SkillsComponent(
      {Key? key,
      required this.stat,
      required this.color,
      required this.value,
      this.isMobile = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            width: isMobile ? 100 : 140,
            height: 20,
            child: FittedBox(
              child: Text(
                stat,
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: descriptionColor,
                    fontSize: isMobile ? 14 : 16,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Stack(
              children: [
                Container(
                  height: isMobile ? 12 : 22,
                  decoration: BoxDecoration(
                      color: const Color(0xffFBFDFF),
                      borderRadius: BorderRadius.circular(isMobile ? 4 : 2)),
                ),
                Container(
                  height: isMobile ? 12 : 22,
                  width: value,
                  decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(isMobile ? 4 : 2)),
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
