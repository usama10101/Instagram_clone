import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:instagram/constants.dart';
import 'package:instagram/cubit/auth/auth_cubit.dart';
import 'package:instagram/default/default_text.dart';
import 'package:instagram/shared/enum.dart';
import 'package:instagram/shared/cache_helper.dart';

class UpdateProfilePage extends StatelessWidget {
  const UpdateProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Form(
        key: formKeyUpdateImage,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.clear,
                    color: Colors.black,
                    size: 30,
                  )),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Iconsax.gallery,
                  color: Colors.black,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      AuthCubit.get(context).uploadImage('dsffd');
                      CacheHelper.putString(
                          key: SharedKey.userProfileImage,
                          value: AuthCubit.get(context).userModel.pic!);
                    },
                    child: const DefaultText(
                      text: 'Choose from gallary',
                      fontStyle: FontStyle.normal,
                      fontSize: 20,
                    )),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Iconsax.camera,
                  color: Colors.black,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    AuthCubit.get(context).uploadImage('cam');
                    CacheHelper.putString(
                        key: SharedKey.userProfileImage,
                        value: AuthCubit.get(context).userModel.pic!);
                  },
                  child: const DefaultText(
                    text: 'Take a photo',
                    fontStyle: FontStyle.normal,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const DefaultText(
                        text: 'Cancel',
                        color: Colors.red,
                        fontStyle: FontStyle.normal,
                        fontSize: 17,
                      ),
                    ),
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
