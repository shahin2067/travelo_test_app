import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:travelo_test_app/utils/colors.dart';
import 'package:travelo_test_app/utils/validator_logic.dart';
import 'package:travelo_test_app/view/auth/otp_verification/otp_verfication_page.dart';
import 'package:travelo_test_app/view/auth/sign_in/sign_in_page.dart';
import 'package:travelo_test_app/view/auth/widgets/k_text_filed.dart';
import 'package:travelo_test_app/view_model/auth_veiw_model.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var vm = Provider.of<AuthViewModel>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Sign up",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/icons/profile.svg',
                  semanticsLabel: "Profile",
                  width: 112.w,
                  height: 104.h,
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  "Welcome Back!",
                  style:
                      TextStyle(fontSize: 23.sp, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Please login to continue",
                  style: TextStyle(
                    fontSize: 15.sp,
                  ),
                ),
                SizedBox(
                  height: 40.h,
                ),
                Form(
                    key: formKey,
                    child: Column(
                      children: [
                        KTextFiled(
                          validator: (value) {
                            return ValidatorLogic.requiredField(value);
                          },
                          labelText: "Your Full Name",
                          prefixIcon: Icons.person,
                          isObscure: false,
                          controller: nameController,
                        ),
                        KTextFiled(
                          validator: (value) {
                            return ValidatorLogic.requiredEmail(value);
                          },
                          labelText: "Your Email",
                          prefixIcon: FontAwesomeIcons.envelope,
                          isObscure: false,
                          controller: emailController,
                        ),
                        KTextFiled(
                          validator: (value) {
                            return ValidatorLogic.requiredPassword(value);
                          },
                          labelText: "Password",
                          prefixIcon: Icons.lock_sharp,
                          isObscure: true,
                          controller: passwordController,
                        ),
                        KTextFiled(
                          validator: (value) {
                            return ValidatorLogic.requiredPassword(value);
                          },
                          labelText: "Confirm Password",
                          prefixIcon: Icons.lock_sharp,
                          isObscure: true,
                          controller: confirmPasswordController,
                        ),
                      ],
                    )),
                SizedBox(
                  height: 30.h,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 56.h,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState?.validate() ?? false) {
                        if (passwordController.text ==
                            confirmPasswordController.text) {
                          vm.setLoading(true);
                          await vm.registerUser(
                              name: nameController.text,
                              email: emailController.text,
                              password: passwordController.text,
                              confirmPassword: passwordController.text);
                          vm.setLoading(false);
                        } else {
                          CherryToast.error(
                            title: const Text(
                              "Password didn't matched",
                            ),
                            toastPosition: Position.bottom,
                          ).show(context);
                        }
                      }

                      if (vm.registrationSuccessful) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OTPVerificationPage(
                                      name: nameController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                      tempOtp: vm.registrationOtp.toString(),
                                    )));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttonInActiveColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.sp)),
                    ),
                    child: Consumer<AuthViewModel>(
                      builder: (context, model, child) {
                        return model.isLoadingData
                            ? const CircularProgressIndicator(
                                color: kPrimaryColor,
                              )
                            : Text(
                                "Sign up",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16.sp,
                                ),
                              );
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 40.h,
                ),
                Row(
                  children: [
                    Container(
                      height: 2.h,
                      width: 113.w,
                      color: textFieldBorderColor,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: Text(
                        "OR CONTINUE WITH",
                        style: TextStyle(fontSize: 15.sp),
                      ),
                    ),
                    Container(
                      height: 2.h,
                      width: 113.w,
                      color: textFieldBorderColor,
                    ),
                  ],
                ),
                SizedBox(
                  height: 18.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 56.h,
                      width: 190.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.sp),
                          border: Border.all(color: textFieldBorderColor)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/icons/google.png",
                            height: 23.h,
                          ),
                          SizedBox(
                            width: 7.w,
                          ),
                          Text(
                            "Google",
                            style: TextStyle(fontSize: 17.sp),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 56.h,
                      width: 190.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.sp),
                          border: Border.all(color: textFieldBorderColor)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/icons/facebook.png",
                            height: 23.h,
                          ),
                          SizedBox(
                            width: 7.w,
                          ),
                          Text(
                            "Facebook",
                            style: TextStyle(fontSize: 17.sp),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 40.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: TextStyle(fontSize: 15.sp),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignInPage()));
                      },
                      child: Text(
                        " Sign in",
                        style: TextStyle(
                            fontSize: 15.sp,
                            color: kPrimaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
