import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram/view/authentication/user_model.dart';

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

  void searchUsers(String query) async {
    if (query.isEmpty) {
      emit(AuthInitial());
      return;
    }

    emit(SearchLoading());

    try {
      var snapshot = await fireStore
          .collection('users')
          .where('name', isGreaterThanOrEqualTo: query)
          .where('name', isLessThanOrEqualTo: query + '\uf8ff')
          .get();

      final users = snapshot.docs.map((doc) {
        return UserModel.fromMap(doc.data());
      }).toList();

      emit(SearchUsersState(users));
    } catch (e) {
      emit(SearchError('Failed to search users: $e'));
    }
  }

  Future<void> followUser(String currentUserId, String targetUserId) async {
    try {
      await fireStore.collection('users').doc(currentUserId).update({
        'following': FieldValue.arrayUnion([targetUserId])
      });

      await fireStore.collection('users').doc(targetUserId).update({
        'followers': FieldValue.arrayUnion([currentUserId])
      });

      emit(LoadingUsersSuccessfulState());
    } catch (e) {
      emit(SearchError('Failed to follow user: $e'));
    }
  }

  Future<void> unfollowUser(String currentUserId, String targetUserId) async {
    try {
      await fireStore.collection('users').doc(currentUserId).update({
        'following': FieldValue.arrayRemove([targetUserId])
      });

      await fireStore.collection('users').doc(targetUserId).update({
        'followers': FieldValue.arrayRemove([currentUserId])
      });

      emit(LoadingUsersSuccessfulState());
    } catch (e) {
      emit(SearchError('Failed to unfollow user: $e'));
    }
  }

  Stream<List<UserModel>> getAllUsers() {
    return fireStore
        .collection('users')
        .where('id', isNotEqualTo: userModel.id)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => UserModel.fromMap(doc.data())).toList());
  }

// Fetch the number of followers for the current user
  int getFollowersCount() {
    return userModel.followers?.length ?? 0;
  }

  // Fetch the number of followings for the current user
  int getFollowingCount() {
    return userModel.following?.length ?? 0;
  }

  // Fetch user details by IDs
  Future<List<UserModel>> fetchUsersByIds(List<String> userIds) async {
    try {
      List<UserModel> users = [];

      if (userIds.isEmpty) return users;

      // Batch fetching users
      var snapshot = await fireStore
          .collection('users')
          .where(FieldPath.documentId, whereIn: userIds)
          .get();

      for (var doc in snapshot.docs) {
        users.add(UserModel.fromMap(doc.data()));
      }
      return users;
    } catch (e) {
      throw Exception('Failed to fetch users: $e');
    }
  }

  // Get followers for the current user
  Future<List<UserModel>> getFollowers() async {
    return await fetchUsersByIds(userModel.followers ?? []);
  }

  // Get followings for the current user
  Future<List<UserModel>> getFollowings() async {
    return await fetchUsersByIds(userModel.following ?? []);
  }

  void listenToUserChanges(String userId) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .snapshots()
        .listen((snapshot) {
      if (snapshot.exists) {
        userModel = UserModel.fromMap(snapshot.data()!);
        emit(UserDataUpdatedState(userModel)); // Emit a state to update UI
      }
    });
  }

  Future<UserModel> fetchUserData(String userId) async {
    var snapshot =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    if (snapshot.exists) {
      return UserModel.fromMap(snapshot.data()!);
    } else {
      throw Exception('User not found');
    }
  }

  void loadUserProfile(String userId) {
    listenToUserChanges(userId);
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

  XFile? userImage;
  uploadImage(String source) async {
    userImage = await imagePicker.pickImage(
        source: source == 'cam' ? ImageSource.camera : ImageSource.gallery);

    if (userImage != null) {
      try {
        String filePath = 'images/${userModel.id}.png';

        // Upload the image to Firebase Storage
        await firebaseStorage.ref(filePath).putFile(File(userImage!.path));

        // Get the download URL
        String downloadUrl =
            await firebaseStorage.ref(filePath).getDownloadURL();

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
