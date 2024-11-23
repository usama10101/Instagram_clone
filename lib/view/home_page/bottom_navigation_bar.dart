
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:instagram/cubit/auth/auth_cubit.dart';
import 'package:instagram/cubit/post/post_cubit.dart';
import 'package:instagram/shared/enum.dart';
import 'package:instagram/shared/cache_helper.dart';

class bottom_navigation_bar extends StatelessWidget {
  const bottom_navigation_bar({
    super.key,
    required this.cubit,
  });

  final PostCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        showSelectedLabels: false,
        currentIndex: cubit.currentIndex,
        onTap: (index) {
          cubit.changeNav(index);
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Iconsax.home,
                color: Colors.black,
              ),
              label: 'home'),
          BottomNavigationBarItem(
              icon: Icon(
                Iconsax.search_normal_1,
                color: Colors.black,
              ),
              label: 'search'),
          BottomNavigationBarItem(
              icon: Icon(
                Iconsax.video_play,
                color: Colors.black,
              ),
              label: 'shorts'),
          BottomNavigationBarItem(
              icon: CircleAvatar(
                backgroundImage: NetworkImage(AuthCubit.get(context).userModel.pic ?? CacheHelper.getString(key: SharedKey.userProfileImage)),
                radius: 15,
              ),
              label: 'profile'),
        ]);
  }
}
