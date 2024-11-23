import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:instagram/cubit/auth/auth_cubit.dart';
import 'package:instagram/shared/enum.dart';
import 'package:instagram/shared/cache_helper.dart';
import 'package:instagram/view/authentication/login_page/login_page.dart';
import 'package:instagram/view/profile_page/user_profile_page.dart';

class drawer extends StatelessWidget {
  const drawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        children: [
          InkWell(
            onTap: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const UserProfilePage()),
                  (route) => true);
            },
            child: BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                return UserAccountsDrawerHeader(
                  accountEmail: Text(
                      '${AuthCubit.get(context).userModel.email ?? CacheHelper.getString(key: SharedKey.email)}',
                      style: const TextStyle(color: Colors.grey, fontSize: 15)),
                  accountName: Text(
                      '${AuthCubit.get(context).userModel.name ?? CacheHelper.getString(key: SharedKey.accountName)}',
                      style: TextStyle(color: Colors.black, fontSize: 20)),
                  currentAccountPicture: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                        '${AuthCubit.get(context).userModel.pic ?? CacheHelper.getString(key: SharedKey.userProfileImage)}'),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                );
              },
            ),
          ),
          ListTile(
            title: const Text(
              'Profile',
              style: TextStyle(color: Colors.black),
            ),
            leading: const Icon(Iconsax.personalcard, color: Colors.black),
            onTap: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const UserProfilePage()),
                  (route) => true);
            },
          ),
          ListTile(
            title: const Text(
              'Log out',
              style: TextStyle(color: Colors.black),
            ),
            leading: const Icon(
              Iconsax.logout,
              color: Colors.black,
            ),
            onTap: () {
              CacheHelper.remove();
              CacheHelper.putBool(key: SharedKey.isLoged, value: false);
              CacheHelper.putBool(key: SharedKey.isSigned, value: true);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
