import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram/view/user_model.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  static AuthCubit get(context) => BlocProvider.of(context);

  var auth = FirebaseAuth.instance;
  var fireStore = FirebaseFirestore.instance;
  UserModel userModel = UserModel();
  // String? downloadUrl;
  GoogleSignIn googleSignIn = GoogleSignIn();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  ImagePicker imagePicker = ImagePicker();
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  registerByEmailAndPassword(
      {String? name, required String email, required String password}) async {
    try {
      UserCredential credential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      userModel.name = name;
      userModel.email = email;
      userModel.password = password;
      userModel.id = credential.user!.uid;
      if (userImage != null) {
        await firebaseStorage
            .ref()
            .child("images/")
            .child('${userModel.id}.png')
            .putFile(File(userImage!.path));
        userModel.pic = await firebaseStorage
            .ref()
            .child("images/")
            .child('${userModel.id}.png')
            .getDownloadURL();
      } else {
        userModel.pic =
            'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png';
      }
      await fireStore
          .collection("users")
          .doc(userModel.id)
          .set(userModel.toMap());
      emit(RegisterByEmailAndPasswordSaveState());
      return credential.user;
    } on FirebaseAuthException catch (error) {
      print(
          "***************Failed with error code :${error.code} ${error.message}");
    }
  }

  loginByEmailAndPassword(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (userCredential.user != null) {
        var userData = await fireStore
            .collection("users")
            .doc(userCredential.user!.uid)
            .get();
        userModel = UserModel.fromMap(userData.data()!);
        emit(LoginByEmailAndPasswordSaveState());
      } else {
        throw FirebaseAuthException(
            message: "Authentication failed", code: "auth-failed");
      }
    } on FirebaseAuthException catch (error) {
      print(
          "***************Failed with error code : ${error.code} ${error.message}");
      emit(LoginByEmailAndPasswordFailState(error.message ?? "Login failed"));
      throw error;
    }
  }

  registerByGoogle() async {
    GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;
    AuthCredential userCredential = GoogleAuthProvider.credential(
      idToken: googleSignInAuthentication.idToken,
      accessToken: googleSignInAuthentication.accessToken,
    );
    UserCredential userByGoogle =
        await auth.signInWithCredential(userCredential);

    userModel.id = userByGoogle.user!.uid;
    userModel.email = userByGoogle.user!.email;
    userModel.name = userByGoogle.user!.displayName;
    userModel.pic = userByGoogle.user!.photoURL;

    await fireStore
        .collection('users')
        .doc(userModel.id)
        .set(userModel.toMap());
    emit(RegisterBygoogleState());
  }

  // updateUserPic({required String id, String? pic}) {
  //   firebaseFirestore
  //       .collection('users')
  //       .doc(id.toString())
  //       .update({'pic': pic}).then((value) {
  //     print('Contact picture updated');
  //     getUsers();
  //     emit(UpdateUserPicSuccessState());
  //   }).catchError((error) {
  //     print(error);
  //     emit(UpdateUserPicErrorState());
  //   });
  // }

  XFile? userImage;
  // uploadImage(String camera) async {
  //   if (camera == 'cam') {
  //     userImage = await imagePicker.pickImage(source: ImageSource.camera);
  //     await firebaseStorage
  //         .ref()
  //         .child("images/")
  //         .child('${userModel.id} as camera.png')
  //         .putFile(File(userImage!.path));
  //     // updateUserPic(id: userModel.id!);

  //     print('${userImage}===============================');
  //     emit(UploadImageState());
  //     return userImage!.readAsBytes();
  //   } else {
  //     userImage = await imagePicker.pickImage(source: ImageSource.gallery);
  //     await firebaseStorage
  //         .ref()
  //         .child("images/")
  //         .child('${userModel.id} as gallery')
  //         .putFile(File(userImage!.path));
  //     emit(UploadImageState());
  //     // updateUserPic(id: userModel.id!);

  //     return userImage!.readAsBytes();
  //   }
  //   //   downloadUrl = await firebaseStorage
  //   //     .ref()
  //   //     .child("images/")
  //   //     .child(camera == 'cam'
  //   // ? '${userModel.id}_camera.png'
  //   //     : '${userModel.id}_gallery')
  //   //     .getDownloadURL();

  //   // emit(UploadImageState());
  //   // return downloadUrl;
  // }

  /////////////////////////////////////////////////////////////
  uploadImage(String source) async {
  userImage = await imagePicker.pickImage(
      source: source == 'cam' ? ImageSource.camera : ImageSource.gallery);

  if (userImage != null) {
    try {
      String filePath = 'images/${userModel.id}.png';

      // Upload the image to Firebase Storage
      await firebaseStorage.ref(filePath).putFile(File(userImage!.path));

      // Get the download URL
      String downloadUrl = await firebaseStorage.ref(filePath).getDownloadURL();

      // Check if user ID is valid
      if (userModel.id != null) {
        // Update user picture in Firestore and update the local model
        updateUserPic(id: userModel.id!, pic: downloadUrl);
        userModel.pic = downloadUrl; // Update local user model
      } else {
        print("User ID is null!");
      }

      emit(UploadImageState());
    } catch (e) {
      print("Error uploading image: $e");
      emit(UploadImageErrorState());
    }
  } else {
        userModel.pic =
            'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png';
      }
}

updateUserPic({required String id, required String pic}) {
  // Ensure pic is not null or empty
  if (pic.isEmpty) {
    print("The provided picture URL is empty.");
    return; // Prevent updating if pic is empty
  }

  firebaseFirestore
      .collection('users')
      .doc(id)
      .update({'pic': pic}).then((value) {
    print('User picture updated successfully');
    getUsers(); // Refresh the users list if needed
    emit(UpdateUserPicSuccessState());
  }).catchError((error) {
    print('Error updating user picture: $error');
    emit(UpdateUserPicErrorState());
  });
}


  List users = [];
  getUsers() async {
    var fireStoreUsers = await fireStore
        .collection('users')
        .where('id', isNotEqualTo: userModel.id)
        .get();
    fireStoreUsers.docs.forEach((element) {
      users.add(UserModel.fromMap(element.data()));
    });
    emit(LoadingUsersSuccessfulState());
  }
}
