// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clean_architecture/features/user/domain/entities/user_entity.dart';

class UserState {
  final bool isLoading;
  final UserEntity? user;
  final String? error;

  const UserState({required this.isLoading, this.user, this.error});

  UserState copyWith({bool? isLoading, UserEntity? user, String? error}) {
    return UserState(
      isLoading: isLoading ?? this.isLoading,
      user: user ?? this.user,
      error: error,
    );
  }
}
