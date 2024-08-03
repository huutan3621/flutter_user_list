import 'package:flutter/material.dart';

class AppColors {
  final Color primary;
  final Color background;
  final Color textBtn;
  final Color text;
  final Color heartDisable;
  final Color heartEnable;

  AppColors({
    required this.primary,
    required this.background,
    required this.text,
    required this.textBtn,
    required this.heartDisable,
    required this.heartEnable,
  });

  factory AppColors.light() {
    return AppColors(
      primary: const Color(0xff6EF9BF),
      background: const Color(0xffFFFFFF),
      textBtn: const Color(0xffFFFFFF),
      text: const Color(0xff161622),
      heartDisable: const Color(0xffFFFFFF),
      heartEnable: const Color(0xffEA001B),
    );
  }

  factory AppColors.dark() {
    return AppColors(
      primary: Color(0xffB678FF),
      background: const Color(0xff161622),
      textBtn: const Color(0xffFFFFFF),
      text: const Color(0xffFFFFFF),
      heartDisable: const Color(0xff161622),
      heartEnable: const Color(0xffEA001B),
    );
  }
}
