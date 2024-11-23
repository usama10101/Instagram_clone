part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}
final class RegisterByEmailAndPasswordSaveState extends AuthState {}
final class LoginByEmailAndPasswordSaveState extends AuthState {
  final String successMessage;

  LoginByEmailAndPasswordSaveState([this.successMessage = 'Login successful']);
}
final class LoginByEmailAndPasswordFailState extends AuthState {
  final String errorMessage;

  LoginByEmailAndPasswordFailState(this.errorMessage);
}
final class RegisterBygoogleState extends AuthState {}
final class UploadImageState extends AuthState {}
final class LoadingUsersSuccessfulState extends AuthState {}
final class UpdateUserPicSuccessState extends AuthState {}
final class UpdateUserPicErrorState extends AuthState {}
final class UploadImageErrorState extends AuthState {}
class SearchUsersState extends AuthState {
  final List<UserModel> searchResults;

  SearchUsersState(this.searchResults);
}
class SearchLoading extends AuthState {}
class SearchError extends AuthState {
  final String message;

  SearchError(this.message);

  @override
  List<Object?> get props => [message];
}
class UserDataUpdatedState extends AuthState {
  final UserModel updatedUser;

  UserDataUpdatedState(this.updatedUser);
}

