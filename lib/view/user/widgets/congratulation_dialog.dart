import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:travelo_test_app/utils/colors.dart';
import 'package:travelo_test_app/view/bottom_nav/bottom_nav.dart';
import 'package:travelo_test_app/view_model/auth_veiw_model.dart';

class CongratulationDialog extends StatelessWidget {
  final String? email;
  final String? password;
  const CongratulationDialog({super.key, this.email, this.password});

  @override
  Widget build(BuildContext context) {
    var vm = Provider.of<AuthViewModel>(context, listen: false);

    return AlertDialog(
      scrollable: true,
      // title: const Text("Login"),
      backgroundColor: Colors.white,
      content: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                      height: 38.h,
                      width: 37.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.sp),
                          border: Border.all(color: Colors.grey, width: 3.w)),
                      child: Icon(
                        Icons.clear,
                        size: 22.h,
                      )),
                )
              ],
            ),
            Image.asset(
              "assets/icons/Congratulations.png",
              height: 200.h,
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              "Congratulations!",
              style: TextStyle(
                  fontSize: 24.sp,
                  color: kPrimaryColor,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              "Your new account has been created successfully.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16.sp),
            ),
            SizedBox(
              height: 30.h,
            ),
            SizedBox(
              width: double.infinity,
              height: 56.h,
              child: ElevatedButton(
                onPressed: () async {
                  vm.setLoading(true);

                  await vm.loginUser(
                    email: email.toString(),
                    password: password.toString(),
                  );

                  // End loading state
                  vm.setLoading(false);

                  if (vm.loginSuccessful && vm.user != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BottomNavController(),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.sp)),
                ),
                child: Consumer<AuthViewModel>(
                  builder: (context, model, child) {
                    return model.isLoadingData
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : Text(
                            "Continue",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                            ),
                          );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
