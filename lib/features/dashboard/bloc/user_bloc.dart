import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_bloc/features/dashboard/bloc/user_event.dart';
import 'package:task_bloc/features/dashboard/bloc/user_state.dart';
import 'package:task_bloc/features/dashboard/model/user_model.dart';

part 'user_data.dart';

class UserListBloc extends Bloc<UserListEvent, UserListState> {
  UserListBloc() : super(UserListLoading()) {
    on<FetchUserList>(_onFetchUserList);
    on<FilterUsers>(_onFilterUsers);
    on<LoadMoreUsers>(_onLoadMoreUsers);
    on<UpdateUserRupee>(_onUpdateUserRupee);
  }
  List<UserModel> allUserList = [];

  final int _maxUsers = 43;
  final int _userPerRound = 20;

  Future<void> _onFetchUserList(
      FetchUserList event, Emitter<UserListState> emit) async {
    try {
      final users = _generateRandomUsers(_userPerRound);
      allUserList = users;
      emit(UserListLoaded(users: users, hasMoreData: true, nextPage: 1));
    } catch (error) {
      emit(UserListError('Error fetching users'));
    }
  }

  void _onUpdateUserRupee(UpdateUserRupee event, Emitter<UserListState> emit) {
    if (state is UserListLoaded) {
      final updatedUsers =
          List<UserModel>.from((state as UserListLoaded).users);
      updatedUsers[event.index] =
          updatedUsers[event.index].copyWith(rupee: event.newRupee);
      allUserList = updatedUsers;
      emit(UserListLoaded(users: updatedUsers, hasMoreData: true, nextPage: 1));
    }
  }

  Future<void> _onLoadMoreUsers(
      LoadMoreUsers event, Emitter<UserListState> emit) async {
    if (state is UserListLoaded) {
      final currentState = state as UserListLoaded;

      if (currentState.users.length >= _maxUsers) {
        emit(currentState.copyWith(hasMoreData: false)); // No more data
        return;
      }

      try {
        final nextPage = currentState.nextPage + 1;
        final newUsers = _generateRandomUsers(_userPerRound);
        final updatedUsers = [...currentState.users, ...newUsers];

        // Calculate if there would still be more data potentially
        final hasMorePotential =
            (nextPage - 1) * _userPerRound + newUsers.length < _maxUsers;
        allUserList = updatedUsers;

        emit(UserListLoaded(
          users: updatedUsers,
          hasMoreData: hasMorePotential,
          nextPage: nextPage,
        ));
      } catch (error) {
        emit(UserListError('Error loading more users'));
      }
    }
  }

  void _onFilterUsers(FilterUsers event, Emitter<UserListState> emit) {
    if (state is UserListLoaded) {
      if (event.query.isEmpty) {
        emit(
            UserListLoaded(users: allUserList, hasMoreData: true, nextPage: 1));
      } else {
        final filteredUsers = allUserList
            .where((user) => user.name.toLowerCase().contains(event.query))
            .toList();
        emit(UserListLoaded(
            users: filteredUsers, hasMoreData: false, nextPage: 0));
      }
    }
  }

  List<UserModel> _generateRandomUsers(int count) {
    return List.generate(count, (index) {
      return UserModel(
        name: userNames[index],
        phoneNumber: phoneNumbers[index],
        photoUrl: 'https://randomuser.me/api/portraits/thumb/men/$index.jpg',
        city: cityName[index],
        rupee: 40.0 + index,
      );
    });
  }
}
