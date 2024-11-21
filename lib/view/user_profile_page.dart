// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:grduation_proj/cubit/auth/auth_cubit.dart';
// import 'package:grduation_proj/enum.dart';
// import 'package:grduation_proj/shared/cache_helper.dart';
// import 'package:grduation_proj/view/choose_image.dart';
// import 'package:grduation_proj/view/user_profile_image.dart';

// class UserProfilePage extends StatelessWidget {
//   const UserProfilePage({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<AuthCubit, AuthState>(
//       builder: (context, state) {
//         return Scaffold(
//           body: Padding(
//               padding: const EdgeInsets.only(right: 16.0, left: 16, top: 50),
//               child: SingleChildScrollView(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Center(
//                       child: Stack(
//                         children: [
//                           InkWell(
//                             onTap: (){
//                               showDialog(context: context, builder: (contexy) => const UserProfileImage());
//                             },
//                             child: CircleAvatar(
//                                               backgroundColor: Colors.grey.shade400,
//                               radius: 50,
//                               backgroundImage:
//                                   NetworkImage('${CacheHelper.getString(key: SharedKey.userProfileImage)}'),
//                             ),
//                           ),
//                           Positioned(
//                             bottom: 0,
//                             right: 0,
//                             child: IconButton(
//                               icon: const Icon(Icons.camera_alt),
//                               onPressed: () async {

//                                 showDialog(
//                                     context: context,
//                                     builder: (context) => const ChooseImage());
//                                 // Navigator.pop(context);
//                                 // await AuthCubit.get(context)
//                                 //     .updatePic(id: contactProfileModel['id']);
//                               },
//                               style: ElevatedButton.styleFrom(
//                                 shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(30)),
//                               ),
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//                     Center(
//                       child: Text(
//                         '${CacheHelper.getString(key: SharedKey.accountName)}',
//                         style: const TextStyle(
//                             fontSize: 24, fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//                     Center(
//                       child: Text(
//                         '${CacheHelper.getString(key: SharedKey.email)}',
//                         style: const TextStyle(
//                             fontSize: 18,),
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//                   ],
//                 ),
//               ),
//             ),
//         );
//       },
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:instagram/cubit/auth/auth_cubit.dart';
import 'package:instagram/enum.dart';
import 'package:instagram/shared/cache_helper.dart';
import 'package:instagram/view/update_profile_page.dart';
import 'package:instagram/view/user_profile_image.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            centerTitle: false,
            elevation: 0,
            backgroundColor: const Color(0xFF00BF6D),
            foregroundColor: Colors.white,
            title: const Text("Profile"),
            actions: [
              IconButton(
                icon: const Icon(Icons.settings_outlined),
                onPressed: () {},
              )
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                ProfilePic(
                    image:
                        "${AuthCubit.get(context).userModel.pic ?? CacheHelper.getString(key: SharedKey.userProfileImage)}"),
                Text(
                  "${CacheHelper.getString(key: SharedKey.accountName)}",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const Divider(height: 16.0 * 2),
                Info(
                  infoKey: "Email Address",
                  info: "${CacheHelper.getString(key: SharedKey.email)}",
                ),
                const SizedBox(height: 16.0),
                Align(
                  alignment: Alignment.centerRight,
                  child: SizedBox(
                    width: 160,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF00BF6D),
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 48),
                        shape: const StadiumBorder(),
                      ),
                      onPressed: () {},
                      child: const Text("Edit profile"),
                    ),
                  ),
                ),
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
        border: Border.all(
          color:
              Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.08),
        ),
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
              radius: 55,
              backgroundImage: NetworkImage(image),
            ),
          ),
          InkWell(
            onTap: () {
              showDialog(
                  context: context, builder: (context) => UpdateProfilePage());
            },
            child: CircleAvatar(
              radius: 13,
              backgroundColor: Colors.black54,
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
