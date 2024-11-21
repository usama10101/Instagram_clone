import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram/constants.dart';
import 'package:instagram/cubit/auth/auth_cubit.dart';
import 'package:instagram/default/default_text.dart';

class ChooseImage extends StatelessWidget {
  const ChooseImage({super.key});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor:const Color(0xffE7D4B5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Form(
        key: formKeyChooseImage,
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
                const Icon(Icons.image_outlined, color: Colors.black,),
                TextButton(
                    onPressed: () async {
                      await AuthCubit.get(context).uploadImage("jhkg");
                    },
                    child: const DefaultText(
                      text: 'Choose from gallary',
                      fontStyle: FontStyle.normal,
                      fontSize: 20,
                    )),
              ],
            ),
            const SizedBox(height: 25,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.camera_alt_outlined, color: Colors.black,),
                TextButton(
                  onPressed: () async {
                    await AuthCubit.get(context).uploadImage("cam");
                  },
                  child: const DefaultText(
                    text: 'Take a photo',
                    fontStyle: FontStyle.normal,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40,),
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
