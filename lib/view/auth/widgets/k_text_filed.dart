import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelo_test_app/utils/colors.dart';

class KTextFiled extends StatelessWidget {
  final String? labelText;
  final IconData prefixIcon;
  final bool isObscure;
  final TextEditingController controller;
  final String? Function(String?) validator;

  const KTextFiled({
    super.key,
    this.labelText,
    required this.prefixIcon,
    required this.isObscure,
    required this.controller,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: TextFormField(
        validator: validator,
        obscureText: isObscure,
        controller: controller,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xffE3E3E3),
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: kPrimaryColor,
            ),
          ),

          prefixIcon: Icon(prefixIcon),
          labelText: labelText,
          // hintText: "example@gmail.com"
        ),
      ),
    );
  }
}
