import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget test;
  final Widget small;
  final Widget medium;
  final Widget large;
  final Widget xlarge;

  const Responsive(
      {super.key,
      required this.test,
      required this.small,
      required this.medium,
      required this.large,
      required this.xlarge});

  static bool isXTest(BuildContext context) =>
      MediaQuery.of(context).size.height <= 200 ||
      MediaQuery.of(context).size.width <= 250;

  static bool isTest(BuildContext context) =>
      MediaQuery.of(context).size.height <= 400 ||
      MediaQuery.of(context).size.width <= 340;

  static bool isSmall(BuildContext context) => MediaQuery.of(context).size.width <= 510;

  static bool isMedium(BuildContext context) => MediaQuery.of(context).size.width <= 650;

  static bool isLarge(BuildContext context) => MediaQuery.of(context).size.width < 1024;

  static bool isXLarge(BuildContext context) => MediaQuery.of(context).size.width >= 1024;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    if (size.width >= 1024) {
      return xlarge;
    } else if (size.width >= 650) {
      return large;
    } else if (size.width >= 510) {
      return medium;
    } else if (size.width >= 340) {
      return small;
    } else {
      return test;
    }
  }
}
