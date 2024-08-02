import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_user_list/presentation/screens/widgets/custom_button.dart';
import 'package:flutter_user_list/router.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SvgPicture.asset(
              "assets/svgs/ic_disk.svg",
              height: 120,
            ),
            const Text(
              "User list display app",
              style: TextStyle(color: Colors.black),
            ),
            const Spacer(),
            CustomButton(
              title: "Tiếp tục",
              onTap: () {
                Navigator.pushNamed(context, RouteNames.bottomBar);
              },
            ),
          ],
        ),
      ),
    );
  }
}
