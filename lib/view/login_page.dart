// ignore_for_file: use_build_context_synchronously

import 'package:auth_buttons/auth_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:instagram/constants.dart';
import 'package:instagram/enum.dart';
import 'package:instagram/shared/cache_helper.dart';
import 'package:instagram/view/home_page.dart';
import 'package:instagram/view/signup_page.dart';
import 'package:instagram/view/user_model.dart';
import 'package:instagram/widgets/password_text_field.dart';
import 'package:sizer/sizer.dart';
import '../../../cubit/auth/auth_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {
  bool isLoged = false;
  bool isVisible = true;
  UserModel userModel = UserModel();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.grey.shade100,
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: 12.h),
              child: Form(
                key: formKeylog,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 1.w),
                      child: Center(
                        child: Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 27.sp,
                            fontWeight: FontWeight.bold,
                            // color: AppTheme.
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 6.5.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6.w),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                isDense: true,
                                hintText: 'Email',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.black26, width: 1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.black26, width: 1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.black38, width: 1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                suffixIcon: InkWell(
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        left: size.width * 0.02,
                                        right: size.width * 0.01),
                                    child: Icon(Iconsax.message_circle,
                                        size: size.height * 0.022),
                                  ),
                                ),
                                suffixIconConstraints: BoxConstraints(
                                  minWidth: size.width * 0.15,
                                ),
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .labelLarge!
                                    .copyWith(
                                        color: Colors.black38,
                                        fontWeight: FontWeight.w500,
                                        height: 1.4,
                                        letterSpacing: 1.5),
                                counterText: "",
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: size.height * 0.018,
                                    horizontal: size.width * 0.04),
                              ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Email Can not be empty ";
                              }
                              if (!RegExp(
                                      "^[a-zA-Z0-9+.-]+@[a-zA-Z-9+.-]+.[a-z]")
                                  .hasMatch(value)) {
                                return " please enter valid email";
                              } else {
                                return null;
                              }
                            },
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          PasswordTextField(
                              hint: 'Password',
                              controller: passwordController,
                              setState: setState,
                            ),
                          // TextFormField(
                          //   obscureText: isVisible,
                          //   obscuringCharacter: '*',
                          //   controller: passwordController,
                          //   decoration: InputDecoration(
                          //     labelText: "Password",
                          //     suffixIcon: IconButton(
                          //       icon: isVisible
                          //           ? const Icon(Icons.remove_red_eye)
                          //           : const Icon(
                          //               Icons.remove_red_eye_outlined),
                          //       onPressed: () {
                          //         setState(() {
                          //           isVisible = !isVisible;
                          //           // obsecureText = isVisible;
                          //         });
                          //       },
                          //     ),
                          //     border: OutlineInputBorder(
                          //       borderRadius: BorderRadius.circular(30),
                          //     ),
                          //   ),
                          //   keyboardType: TextInputType.visiblePassword,
                          //   // ignore: body_might_complete_normally_nullable
                          //   validator: (value) {
                          //     if (value!.length < 6) {
                          //       return "password should be return 6";
                          //     }
                          //   },
                          //   autovalidateMode:
                          //       AutovalidateMode.onUserInteraction,
                          // ),
                          SizedBox(
                            height: 2.5.h,
                          ),
                          SizedBox(
                            width: size.width * 0.3,
                            child: ElevatedButton(
                              onPressed: () async {
                                if (formKeylog.currentState!.validate()) {
                                  try {
                                    await AuthCubit.get(context)
                                        .loginByEmailAndPassword(
                                            email: emailController.text,
                                            password:
                                                passwordController.text)
                                        .then((value) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content:
                                                  Text('Login success')));
                      
                                      CacheHelper.putString(
                                  key: SharedKey.accountName,
                                  value: AuthCubit.get(context)
                                      .userModel
                                      .name!);
                              CacheHelper.putString(
                                  key: SharedKey.userProfileImage,
                                  value: AuthCubit.get(context)
                                      .userModel
                                      .pic!);
                              CacheHelper.putString(
                                  key: SharedKey.email,
                                  value: AuthCubit.get(context)
                                      .userModel
                                      .email!);
                              isLoged = true;
                              CacheHelper.putBool(
                                  key: SharedKey.isLoged, value: isLoged);
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const HomePage()),
                                          (route) => false);
                                    });
                                  } catch (error) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text('Invalid email or password'), 
                                    ));
                                  }
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(20))),
                              child: const Text("Next"),
                            ),
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          GoogleAuthButton(
                            onPressed: () async {
                              await AuthCubit.get(context)
                                  .registerByGoogle();
                              CacheHelper.putString(
                                  key: SharedKey.accountName,
                                  value: AuthCubit.get(context)
                                      .userModel
                                      .name!);
                              CacheHelper.putString(
                                  key: SharedKey.userProfileImage,
                                  value: AuthCubit.get(context)
                                      .userModel
                                      .pic!);
                              CacheHelper.putString(
                                  key: SharedKey.email,
                                  value: AuthCubit.get(context)
                                      .userModel
                                      .email!);
                              isLoged = true;
                              CacheHelper.putBool(
                                  key: SharedKey.isLoged, value: isLoged);
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const HomePage()),
                                  (route) => false);
                            },
                            style: const AuthButtonStyle(
                              buttonType: AuthButtonType.secondary,
                              iconType: AuthIconType.outlined,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            " Create new account ?  ",
                            style: TextStyle(fontSize: 18.sp),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const RegisterScreen()),);
                              emailController.clear();
                              passwordController.clear();
                            },
                            child: Text(
                              "Sign up",
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.sp,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
