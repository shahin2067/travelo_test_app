import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelo_test_app/utils/colors.dart';

class KButton extends StatelessWidget {
  const KButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56.h,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonInActiveColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.sp)),
        ),
        child: Text(
          "Sign in",
          style: TextStyle(color: Colors.grey, fontSize: 16.sp),
        ),
      ),
    );
  }
}
