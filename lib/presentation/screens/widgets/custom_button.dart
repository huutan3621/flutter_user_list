import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final Function()? onTap;
  final Color? btnColor;
  final Color? textColor;

  const CustomButton({
    super.key,
    required this.title,
    this.onTap,
    this.btnColor = Colors.blueAccent,
    this.textColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: btnColor,
            borderRadius: const BorderRadius.all(Radius.circular(8))),
        child: Center(
            child: Text(
          title,
          style: TextStyle(
            fontSize: 20,
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
        )),
      ),
    );
  }
}
