abstract class UserListEvent {}

class FetchUserList extends UserListEvent {}

class FilterUsers extends UserListEvent {
  final String query;

  FilterUsers(this.query);
}

class UpdateUserRupee extends UserListEvent {
  final int index; // Index of the user to update
  final double newRupee;

  UpdateUserRupee(this.index, this.newRupee);
}

class LoadMoreUsers extends UserListEvent {
  LoadMoreUsers();
}
