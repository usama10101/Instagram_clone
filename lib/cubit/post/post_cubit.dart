import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram/view/posts_page.dart';
import 'package:instagram/view/search_page/search_page.dart';
import 'package:instagram/view/search_page/search_posts.dart';
import 'package:instagram/view/shorts_page.dart';
import 'package:instagram/view/profile_page/user_profile_page.dart';

part 'post_state.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit() : super(PostInitial());
  static PostCubit get(context) => BlocProvider.of(context);
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  // ContactModel contactModel = ContactModel();
  ImagePicker imagePicker = ImagePicker();
  // String? downloadUrl;
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  int currentIndex = 0;
  List<Widget> screens = const [
    PostsPage(),
    SearchPosts(),
    ShortsPage(),
    UserProfilePage(),
  ];
  changeNav(int index) {
    currentIndex = index;
    emit(ChangeNavBarSuccessState());
  }
}
