part of 'post_cubit.dart';

@immutable
sealed class PostState {}

final class PostInitial extends PostState {}
class ChangeNavBarSuccessState extends PostState{}
