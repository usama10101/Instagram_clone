import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram/cubit/search/search_state.dart';
import 'package:instagram/view/authentication/user_model.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  final FirebaseFirestore fireStore = FirebaseFirestore.instance;

  void searchUsers(String query) async {
    if (query.isEmpty) {
      emit(SearchInitial());
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

      emit(SearchSuccess(users));
    } catch (e) {
      emit(SearchError('Failed to fetch users: $e'));
    }
  }
}
