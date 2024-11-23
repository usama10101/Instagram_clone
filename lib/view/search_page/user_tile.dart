import 'package:flutter/material.dart';
import 'package:instagram/cubit/auth/auth_cubit.dart';
import 'package:instagram/view/authentication/user_model.dart';

class UserTile extends StatelessWidget {
  final UserModel user;
  final String currentUserId;

  const UserTile({
    Key? key,
    required this.user,
    required this.currentUserId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authCubit = AuthCubit.get(context);

    // Check if the user is already being followed
    final isFollowing = authCubit.userModel.following?.contains(user.id) ?? false;

    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(user.pic ?? 'https://via.placeholder.com/150'),
      ),
      title: Text(user.name ?? 'Unknown'),
      subtitle: Text(user.email ?? 'No email'),
      trailing: ElevatedButton(
        onPressed: () {
          if (isFollowing) {
            authCubit.unfollowUser(currentUserId, user.id!);
          } else {
            authCubit.followUser(currentUserId, user.id!);
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: isFollowing ? Colors.red : Colors.blue,
        ),
        child: Text(isFollowing ? 'Unfollow' : 'Follow'),
      ),
    );
  }
}
