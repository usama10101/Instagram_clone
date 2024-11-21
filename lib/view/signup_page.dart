import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
          backgroundColor: Colors.white,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Form(
                key: formKeyReg,
                child: Padding(
                  padding: EdgeInsets.only(top: 10.h, left: 1.w, right: 1.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: SizedBox(
                            height: 8.h,
                            child: Image.asset('assets/instagram.png')),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      TextFormField(
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
                      SizedBox(
                        height: 1.h,
                      ),
                      TextFormField(
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
                      SizedBox(
                        height: 1.h,
                      ),
                      PasswordTextField(
                        hint: 'Password',
                        controller: passwordController,
                        setState: setState,
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      PasswordValidationPlus(
                        textController: passwordController,
                        maxLength: 12,
                        minLength: 8,
                        successIcon: Iconsax.tick_circle,
                        unSuccessIcon: Iconsax.close_circle,
                        textSize: 16,
                      ),
                      SizedBox(height: 2.h,),
                      SizedBox(
                        width: 50.w,
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
                                    BorderRadius.circular(12.sp)),
                          ),
                          child: const DefaultText(
                            text: "Register",
                            color: Colors.white,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ),
                      SizedBox(height: 2.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Have an account?",
                            style: TextStyle(fontSize: 16.sp),
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
                                  fontSize: 17.sp,
                                  color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
