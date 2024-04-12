import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_bloc/features/dashboard/bloc/user_bloc.dart';
import 'package:task_bloc/features/dashboard/bloc/user_event.dart';
import 'package:task_bloc/features/dashboard/bloc/user_state.dart';
import 'package:task_bloc/features/dashboard/model/user_model.dart';
import 'package:task_bloc/features/dashboard/widgets/list_item_widget.dart';

class BuildUserList extends StatelessWidget {
  BuildUserList({super.key});
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserListBloc, UserListState>(
      listener: (context, state) {
        if (state is UserListLoaded && state.hasMoreData) {
          // Detect scrolled to the end
          _scrollController.addListener(() {
            if (_scrollController.position.pixels ==
                _scrollController.position.maxScrollExtent) {
              BlocProvider.of<UserListBloc>(context).add(LoadMoreUsers());
            }
          });
        }
      },
      builder: (context, state) {
        if (state is UserListLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is UserListError) {
          return Center(child: Text(state.message));
        } else if (state is UserListLoaded) {
          return ListView.builder(
            controller: _scrollController,
            itemCount: state.users.length +
                (state.hasMoreData ? 1 : 0), // Add 1 for loader
            itemBuilder: (listContext, index) {
              if (index >= state.users.length) {
                return const Center(child: CircularProgressIndicator());
              }

              final user = state.users[index];
              return ListItemWidget(
                user: user,
                index: index,
              );
            },
          );
        } else if (state is UserListError) {
          return Center(child: Text(state.message));
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
