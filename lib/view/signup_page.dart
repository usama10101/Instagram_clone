import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:instagram/constants.dart';
import 'package:instagram/default/default_text.dart';
import 'package:instagram/enum.dart';
import 'package:instagram/shared/cache_helper.dart';
import 'package:instagram/view/choose_image.dart';
import 'package:instagram/view/home_page.dart';
import 'package:instagram/widgets/password_text_field.dart';
import 'package:instagram/widgets/repeat_password_text_field.dart';
import 'package:password_validation_plus/password_validation_plus.dart';
import 'package:sizer/sizer.dart';
import '../../cubit/auth/auth_cubit.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool? isPassword;
  bool isVisible = true;
  bool isVisibleR = true;
  String? value1;
  bool isLoged = false;

  var formKeyReg = GlobalKey<FormState>();
  var scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return Scaffold(
          key: scaffoldkey,
          backgroundColor: Colors.grey.shade100,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(0.2.dp),
                    width: w,
                    height: h * 0.70,
                    child: Form(
                      key: formKeyReg,
                      child: Padding(
                        padding: EdgeInsets.only(top: 0.2.dp),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 2,
                              child: DefaultText(
                                text: "Register",
                                fontSize: 22.sp,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    isDense: true,
                                    hintText: 'User name',
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
                                        child: Icon(Iconsax.personalcard,
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
                                        horizontal: size.width * 0.05),
                                  ),
                                  controller: nameController,
                                  keyboardType: TextInputType.name,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Name cannot be empty ";
                                    } else {
                                      return null;
                                    }
                                  },
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: TextFormField(
                                  // decoration: InputDecoration(
                                  //   labelText: "Email",
                                  //   suffixIcon: const Icon(Icons.mail),
                                  //   border: OutlineInputBorder(
                                  //     borderRadius: BorderRadius.circular(20.sp),
                                  //   ),
                                  // ),
                                  controller: emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Email cannot be empty ";
                                    }
                                    if (!RegExp(
                                            "^[a-zA-Z0-9+.-]+@[a-zA-Z0-9+.-]+.[a-z]")
                                        .hasMatch(value)) {
                                      return ("Please enter valid email");
                                    } else {
                                      return null;
                                    }
                                  },
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
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
                                        horizontal: size.width * 0.05),
                                  ),
                                ),
                              ),
                            ),
                            // SizedBox(height: 1.h),
                            // TextFormField(
                            //   obscureText: isVisible,
                            //   obscuringCharacter: '*',
                            //   decoration: InputDecoration(
                            //     labelText: "Password",
                            //     suffixIcon: IconButton(
                            //       icon: isVisible
                            //           ? const Icon(Icons.visibility_off)
                            //           : const Icon(
                            //               Icons.remove_red_eye_outlined),
                            //       onPressed: () {
                            //         setState(() {
                            //           isVisible = !isVisible;
                            //         });
                            //       },
                            //     ),
                            //     border: OutlineInputBorder(
                            //       borderRadius: BorderRadius.circular(20.sp),
                            //     ),
                            //   ),
                            //   keyboardType: TextInputType.text,
                            //   controller: passwordController,
                            //   validator: (value) {
                            //     value1 = value;

                            //     if (value!.isEmpty) {
                            //       return "Password cannot be empty ";
                            //     }
                            //     if (value.length < 8) {
                            //       return "Password must be 8 or more digits ";
                            //     } else {
                            //       return null;
                            //     }
                            //   },
                            //   autovalidateMode:
                            //       AutovalidateMode.onUserInteraction,
                            // ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Expanded(
                              child: PasswordTextField(
                                hint: 'Password',
                                controller: passwordController,
                                setState: setState,
                              ),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Expanded(
                              flex: 4,
                              child: PasswordValidationPlus(
                                textController: passwordController,
                                maxLength: 12,
                                minLength: 8,
                                successIcon: Iconsax.tick_circle,
                                unSuccessIcon: Iconsax.close_circle,
                                textSize: 16,
                              ),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Expanded(
                              child: RepeatPasswordTextField(
                                hint: 'Repeat Password',
                                controller: repeatPasswordControler,
                                setState: setState,
                              ),
                            ),
                            // TextFormField(
                            //   obscureText: isVisibleR,
                            //   obscuringCharacter: '*',
                            //   validator: (value) {
                            //     if (value != value1) {
                            //       return 'Please repeat password correctly';
                            //     }
                            //     return null;
                            //   },
                            //   controller: repeatPasswordControler,
                            //   decoration: InputDecoration(
                            //     border: OutlineInputBorder(
                            //         borderRadius: BorderRadius.circular(20.sp)),
                            //     labelText: 'Repeat password',
                            //     suffixIcon: IconButton(
                            //       icon: isVisibleR
                            //           ? const Icon(Icons.visibility_off)
                            //           : const Icon(
                            //               Icons.remove_red_eye_outlined),
                            //       onPressed: () {
                            //         setState(() {
                            //           isVisibleR = !isVisibleR;
                            //         });
                            //       },
                            //     ),
                            //   ),
                            //   autovalidateMode:
                            //       AutovalidateMode.onUserInteraction,
                            // ),
                            SizedBox(
                              height: 0.8.h,
                            ),
                            Expanded(
                              child: ElevatedButton(
                                  onPressed: () async {
                                    showDialog(
                                        context: context,
                                        builder: (context) =>
                                            const ChooseImage());
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.sp)),
                                  ),
                                  child: const DefaultText(
                                    text: "Choose photo",
                                    fontStyle: FontStyle.normal,
                                  )),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Expanded(
                              child: SizedBox(
                                width: 25.w,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    if (formKeyReg.currentState!.validate()) {
                                      await AuthCubit.get(context)
                                          .registerByEmailAndPassword(
                                              name: nameController.text,
                                              email: emailController.text,
                                              password: passwordController.text)
                                          .then((value) {
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
                                            key: SharedKey.isLoged,
                                            value: isLoged);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content:
                                                Text('Successfully Registered'),
                                            duration: Duration(seconds: 2),
                                          ),
                                        );
                                        value.sendEmailVerification();
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const HomePage()),
                                        );
                                      });
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.sp)),
                                  ),
                                  child: const DefaultText(
                                    text: "Sign up",
                                    color: Colors.white,
                                    fontStyle: FontStyle.normal,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 2.w, top: 4.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "Have account ? ",
                          style: TextStyle(fontSize: 18.sp),
                        ),
                        SizedBox(
                          width: 3.w,
                        ),
                        InkWell(
                          onTap: () {
                            nameController.clear();
                            emailController.clear();
                            passwordController.clear();
                            repeatPasswordControler.clear();
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => const LoginScreen()));
                            Navigator.pop(context);
                          },
                          child: Text(
                            "login",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.sp,
                                color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
