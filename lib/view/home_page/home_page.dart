import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram/cubit/post/post_cubit.dart';
import 'package:instagram/view/home_page/bottom_navigation_bar.dart';
import 'package:instagram/view/home_page/drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    PostCubit cubit = PostCubit.get(context);
    return BlocBuilder<PostCubit, PostState>(
      builder: (context, state) {
        return Scaffold(
          drawer: drawer(),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: bottom_navigation_bar(cubit: cubit),
        );
      },
    );
  }
}
