import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_inicie/utils/constants.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final Function() onPressed;

  const CustomButton({super.key, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 43,
        width: 226,
        decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(5),
            boxShadow: const [
              BoxShadow(offset: Offset(0.0, 4.0), blurRadius: 15, color: primaryColor)
            ]),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 5),
            Text(
              title,
              style: const TextStyle(
                  color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Spacer(flex: 3),
            const Padding(
              padding: EdgeInsets.only(right: 8),
              child: Icon(
                CupertinoIcons.forward,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
