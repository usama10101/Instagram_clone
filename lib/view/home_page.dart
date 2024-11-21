import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:instagram/cubit/auth/auth_cubit.dart';
import 'package:instagram/cubit/post/post_cubit.dart';
import 'package:instagram/enum.dart';
import 'package:instagram/shared/cache_helper.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    PostCubit cubit = PostCubit.get(context);
    return BlocBuilder<PostCubit, PostState>(
      builder: (context, state) {
        return Scaffold(
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
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
              ]),
        );
      },
    );
  }
}
