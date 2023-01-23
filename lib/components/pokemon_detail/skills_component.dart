import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_inicie/utils/constants.dart';

class SkillsComponent extends StatelessWidget {
  final String stat;
  final Color color;
  final double value;

  const SkillsComponent({
    Key? key,
    required this.stat,
    required this.color,
    required this.value,
  }) : super(key: key);

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
            width: !kIsWeb ? 100 : 140,
            height: !kIsWeb ? 20 : 28,
            child: FittedBox(
              child: Text(
                stat,
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: descriptionColor,
                    fontSize: !kIsWeb ? 14 : 16,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Stack(
              children: [
                Container(
                  width: 210,
                  height: !kIsWeb ? 12 : 21,
                  decoration: BoxDecoration(
                      color: const Color(0xFFFBFDFF),
                      borderRadius: BorderRadius.circular(!kIsWeb ? 4 : 2)),
                ),
                Container(
                  height: !kIsWeb ? 12 : 21,
                  width: value,
                  decoration: BoxDecoration(
                      color: color, borderRadius: BorderRadius.circular(!kIsWeb ? 4 : 2)),
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
