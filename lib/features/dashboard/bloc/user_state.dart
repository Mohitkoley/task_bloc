// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:task_bloc/features/dashboard/model/user_model.dart';

abstract class UserListState extends Equatable {}

class UserListLoading extends UserListState {
  @override
  List<Object> get props => [];
}

class UserListLoaded extends UserListState {
  final List<UserModel> users;
  final bool hasMoreData;
  final int nextPage;

  UserListLoaded({
    required this.users,
    required this.hasMoreData,
    required this.nextPage,
  });

  UserListLoaded copyWith({
    List<UserModel>? users,
    bool? hasMoreData,
    int? nextPage,
  }) {
    return UserListLoaded(
      users: users ?? this.users,
      hasMoreData: hasMoreData ?? this.hasMoreData,
      nextPage: nextPage ?? this.nextPage,
    );
  }

  @override
  List<Object> get props => [users];
}

class UserListError extends UserListState {
  final String message;

  UserListError(this.message);

  @override
  List<Object> get props => [message];
}
