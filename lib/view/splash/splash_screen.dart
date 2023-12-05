import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:travelo_test_app/view/auth/sign_in/sign_in_page.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    changeScreen() {
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => SignInPage()));
      });
    }

    changeScreen();

    return Scaffold(
      body: Center(
        child: Container(
          margin: const EdgeInsets.only(left: 9),
          child: SvgPicture.asset(
            'assets/icons/travelo.svg',
            semanticsLabel: 'My SVG Image',
            height: 220.h,
            width: 324.w,
            // width: 70,
          ),
        ),
      ),
    );
  }
}
