import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:instagram/cubit/auth/auth_cubit.dart';
import 'package:instagram/shared/enum.dart';
import 'package:instagram/shared/cache_helper.dart';
import 'package:instagram/view/profile_page/update_profile_page.dart';
import 'package:instagram/view/profile_page/user_list_page.dart';
import 'package:instagram/view/profile_page/user_profile_image.dart';
import 'package:sizer/sizer.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        final authCubit = AuthCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.grey.shade50,
          appBar: AppBar(
            backgroundColor: Colors.grey.shade50,
            centerTitle: true,
            elevation: 0,
            foregroundColor: Colors.black,
            title: Text(
              "${CacheHelper.getString(key: SharedKey.accountName)}",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ProfilePic(
                        image:
                            "${AuthCubit.get(context).userModel.pic ?? CacheHelper.getString(key: SharedKey.userProfileImage)}"),
                    Column(
                      children: [Text('20'), Text('Posts')],
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserListPage(
                              title: 'Followers',
                              fetchUsers: authCubit.getFollowers,
                            ),
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          Text(
                            '${authCubit.getFollowersCount()}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text('followers')
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        // Navigate to Following List
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserListPage(
                              title: 'Following',
                              fetchUsers: authCubit.getFollowings,
                            ),
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          Text(
                            '${authCubit.getFollowingCount()}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text('followings')
                        ],
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "${CacheHelper.getString(key: SharedKey.accountName)}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
                SizedBox(
                  height: 4.h,
                ),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: 90.w,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        side: BorderSide(color: Colors.grey.shade300),
                        minimumSize: const Size(double.infinity, 48),
                      ),
                      onPressed: () {},
                      child: const Text(
                        "Edit profile",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ),
                  ),
                ),
                Divider(
                  height: 10.h,
                ),
                // Info(
                //   infoKey: "Email Address",
                //   info: "${CacheHelper.getString(key: SharedKey.email)}",
                // ),
                const SizedBox(height: 16.0),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ProfilePic extends StatelessWidget {
  const ProfilePic({
    super.key,
    required this.image,
    this.isShowPhotoUpload = false,
    this.imageUploadBtnPress,
  });

  final String image;
  final bool isShowPhotoUpload;
  final VoidCallback? imageUploadBtnPress;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.symmetric(vertical: 16.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (contexy) => const UserProfileImage());
            },
            child: CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(image),
            ),
          ),
          CircleAvatar(
            radius: 13,
            backgroundColor: Colors.white,
          ),
          InkWell(
            onTap: () {
              showDialog(
                  context: context, builder: (context) => UpdateProfilePage());
            },
            child: CircleAvatar(
              radius: 12,
              backgroundColor: Colors.blue,
              child: const Icon(
                Iconsax.add,
                color: Colors.white,
                size: 20,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class Info extends StatelessWidget {
  const Info({
    super.key,
    required this.infoKey,
    required this.info,
  });

  final String infoKey, info;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            infoKey,
            style: TextStyle(
              color: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .color!
                  .withOpacity(0.8),
            ),
          ),
          Text(info),
        ],
      ),
    );
  }
}
