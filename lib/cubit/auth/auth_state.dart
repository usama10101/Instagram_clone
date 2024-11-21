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