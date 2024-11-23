import 'package:flutter/material.dart';
import 'package:instagram/view/authentication/user_model.dart';

class UserListPage extends StatelessWidget {
  final String title;
  final Future<List<UserModel>> Function() fetchUsers;

  const UserListPage({
    Key? key,
    required this.title,
    required this.fetchUsers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: FutureBuilder<List<UserModel>>(
        future: fetchUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          final users = snapshot.data ?? [];

          if (users.isEmpty) {
            return const Center(
              child: Text('No users found.'),
            );
          }

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(user.pic ?? 'https://via.placeholder.com/150'),
                ),
                title: Text(user.name ?? 'Unknown'),
                subtitle: Text(user.email ?? 'No email'),
              );
            },
          );
        },
      ),
    );
  }
}
