import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelo_test_app/utils/colors.dart';
import 'package:travelo_test_app/view/user/widgets/congratulation_dialog.dart';

class CompleteProfilePage extends StatelessWidget {
  final String? email;
  final String? password;
  const CompleteProfilePage({super.key, this.email, this.password});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "Complete Profile",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.w),
        child: Column(children: [
          Image.asset(
            "assets/icons/Avater.png",
            height: 210.h,
          ),
          const Expanded(child: SizedBox()),
          SizedBox(
            width: double.infinity,
            height: 56.h,
            child: ElevatedButton(
              onPressed: () async {
                showDialog(
                    context: context,
                    builder: (context) =>
                        CongratulationDialog(email: email, password: password));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.sp)),
              ),
              child: Text(
                "Complete",
                style: TextStyle(color: Colors.white, fontSize: 16.sp),
              ),
            ),
          ),
          SizedBox(
            height: 40.h,
          ),
        ]),
      ),
    );
  }
}
