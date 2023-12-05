import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:travelo_test_app/utils/colors.dart';
import 'package:travelo_test_app/view_model/auth_veiw_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var vm = Provider.of<AuthViewModel>(context, listen: false);

    return Scaffold(
      backgroundColor: const Color(0xffF2F8FD),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xffF2F8FD),
        leading: Container(
          margin: EdgeInsets.only(left: 18.w),
          height: 50.h,
          width: 50.h,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.person,
            size: 27.h,
            color: Colors.grey,
          ),
        ),
        title: Text(
          "Hello, ${vm.user!.name}",
          // "Hello, Adventure!",
          style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black),
        ),
        actions: [
          InkWell(
            onTap: () {
              // Provider.of<AuthViewModel>(context, listen: false).logoutUser();
              // Navigator.pushReplacement(
              //   context,
              //   MaterialPageRoute(builder: (context) => const SignInPage()),
              // );
            },
            child: Container(
              margin: EdgeInsets.only(right: 18.w),
              height: 50.h,
              width: 50.h,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.logout,
                size: 27.h,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                "Home",
                style: TextStyle(
                    fontSize: 36.sp,
                    fontWeight: FontWeight.w600,
                    color: kPrimaryColor),
              ),
            )
          ],
        ),
      ),
    );
  }
}
