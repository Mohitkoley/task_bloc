import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_bloc/features/dashboard/bloc/user_bloc.dart';
import 'package:task_bloc/features/dashboard/bloc/user_event.dart';
import 'package:task_bloc/features/dashboard/widgets/user_list_widget.dart';

class UserListScreen extends StatelessWidget {
  const UserListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User List')),
      body: Column(
        children: [
          _buildSearchField(context),
          Expanded(child: BuildUserList()),
        ],
      ),
    );
  }

  Widget _buildSearchField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        onChanged: (query) {
          BlocProvider.of<UserListBloc>(context).add(FilterUsers(query));
        },
        decoration: const InputDecoration(hintText: 'name/phone/city'),
      ),
    );
  }
}
