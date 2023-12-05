import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:travelo_test_app/utils/colors.dart';
import 'package:travelo_test_app/view/user/complete_profile_page.dart';
import 'package:travelo_test_app/view_model/auth_veiw_model.dart';

class OTPVerificationPage extends StatefulWidget {
  final String name;
  final String email;
  final String password;
  final String tempOtp;
  const OTPVerificationPage(
      {super.key,
      required this.name,
      required this.email,
      required this.password,
      required this.tempOtp});

  @override
  State<OTPVerificationPage> createState() => _OTPVerificationPageState();
}

class _OTPVerificationPageState extends State<OTPVerificationPage> {
  String? otpCode;

  @override
  Widget build(BuildContext context) {
    // print("Name: ${widget.name}");
    // print("Email: ${widget.email}");
    // print("PassWord: ${widget.password}");
    print("TempOtp: ${widget.tempOtp}");

    var vm = Provider.of<AuthViewModel>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: const Text(
          "OTP Verification",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.w),
        child: Column(
          children: [
            SizedBox(
              height: 20.h,
            ),
            Center(
              child: SvgPicture.asset(
                'assets/icons/otp.svg',
                semanticsLabel: "Profile",
                width: 220.w,
                height: 220.h,
              ),
            ),
            SizedBox(
              height: 50.h,
            ),
            Pinput(
              length: 4,
              showCursor: true,
              defaultPinTheme: PinTheme(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blue.shade50,
                  border: Border.all(
                    color: kPrimaryColor,
                  ),
                ),
                textStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onCompleted: (value) {
                setState(() {
                  otpCode = value;
                });
              },
            ),
            SizedBox(
              height: 25.h,
            ),
            SizedBox(
              width: double.infinity,
              height: 56.h,
              child: ElevatedButton(
                onPressed: () async {
                  vm.setLoading(true);
                  await vm.otpVerification(
                      name: widget.name,
                      email: widget.email,
                      password: widget.password,
                      tempOtp: widget.tempOtp,
                      otpCode: otpCode);
                  vm.setLoading(false);

                  if (vm.otpVerifySuccessful) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CompleteProfilePage(
                                  email: widget.email,
                                  password: widget.password,
                                )));
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
                // Text(
                //   "Continue",
                //   style: TextStyle(color: Colors.white, fontSize: 16.sp),
                // ),
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Didn't get any code?",
                  style: TextStyle(fontSize: 15.sp),
                ),
                InkWell(
                  onTap: () {},
                  child: Text(
                    " Resend",
                    style: TextStyle(
                        fontSize: 15.sp,
                        color: kPrimaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
