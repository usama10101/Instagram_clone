import 'package:flutter/material.dart';
import 'package:instagram/cubit/auth/auth_cubit.dart';
import 'package:instagram/shared/enum.dart';
import 'package:instagram/shared/cache_helper.dart';

class UserProfileImage extends StatelessWidget {
  const UserProfileImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Image(image: NetworkImage('${AuthCubit.get(context).userModel.pic ?? CacheHelper.getString(key: SharedKey.userProfileImage)}'),),
    );
  }
}
