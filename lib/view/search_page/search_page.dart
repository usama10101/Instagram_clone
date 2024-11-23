import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:instagram/cubit/auth/auth_cubit.dart';
import 'package:instagram/view/search_page/user_tile.dart';
import 'package:sizer/sizer.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authCubit = AuthCubit.get(context);

    return Scaffold(
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: EdgeInsets.only(left: 3.w, right: 3.w, top: 6.h),
            child: Row(
              children: [
                InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                    child: Icon(
                  Iconsax.arrow_left,
                  size: 35,
                )),
                SizedBox(
                  width: 4.5.w,
                ),
                SizedBox(
                  height: 5.h,
                  width: 80.w,
                  child: TextField(
                    decoration: InputDecoration(
                      hoverColor: Colors.grey.shade400,
                      hintText: 'Search',
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.black26, width: 1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      border: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.black26, width: 1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.black38, width: 1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      prefixIcon: Icon(Icons.search),
                    ),
                    onChanged: (query) {
                      // Trigger the search method in the AuthCubit
                      authCubit.searchUsers(query);
                    },
                  ),
                ),
              ],
            ),
          ),
          // Search Results
          Expanded(
            child: BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                if (state is SearchLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is SearchUsersState) {
                  final users = state.searchResults;
                  if (users.isEmpty) {
                    return const Center(
                      child: Text('No users found.'),
                    );
                  }
                  return ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      final user = users[index];
                      return UserTile(
                        user: user,
                        currentUserId: authCubit.userModel.id!,
                      );
                    },
                  );
                } else if (state is SearchError) {
                  return Center(
                    child: Text(
                      state.message,
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                }
                return const Center(
                  child: Text('Start searching for users.'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
