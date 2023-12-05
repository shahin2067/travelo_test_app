import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:travelo_test_app/utils/colors.dart';
import 'package:travelo_test_app/utils/validator_logic.dart';
import 'package:travelo_test_app/view/auth/sign_up/sign_up_page.dart';
import 'package:travelo_test_app/view/auth/widgets/k_text_filed.dart';
import 'package:travelo_test_app/view/bottom_nav/bottom_nav.dart';
import 'package:travelo_test_app/view_model/auth_veiw_model.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
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
          "Sign in",
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
                          return ValidatorLogic.requiredEmail(value);
                        },
                        labelText: "Your Email Address",
                        prefixIcon: FontAwesomeIcons.envelope,
                        isObscure: false,
                        controller: emailController,
                      ),
                      KTextFiled(
                        validator: (text) =>
                            ValidatorLogic.requiredPassword(text),
                        labelText: "Password",
                        prefixIcon: Icons.lock_sharp,
                        isObscure: true,
                        controller: passwordController,
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Forgot Password?",
                      style: TextStyle(
                          fontSize: 15.sp,
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30.h,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 56.h,
                  child: 
                  ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState?.validate() ?? false) {
                        // Start loading state
                        vm.setLoading(true);

                        await vm.loginUser(
                          email: emailController.text,
                          password: passwordController.text,
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
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttonInActiveColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.sp),
                      ),
                    ),
                    child: Consumer<AuthViewModel>(
                      builder: (context, model, child) {
                        return model.isLoadingData
                            ? const CircularProgressIndicator(
                                color: kPrimaryColor,
                              )
                            : Text(
                                "Sign in",
                                style: TextStyle(
                                  color: const Color.fromARGB(255, 100, 94, 94),
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
                        border: Border.all(color: textFieldBorderColor),
                      ),
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
                        border: Border.all(color: textFieldBorderColor),
                      ),
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
                      "Don't have any account?",
                      style: TextStyle(fontSize: 15.sp),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignUpPage(),
                          ),
                        );
                      },
                      child: Text(
                        " Register Now",
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
