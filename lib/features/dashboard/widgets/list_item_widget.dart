import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_bloc/features/dashboard/bloc/user_bloc.dart';
import 'package:task_bloc/features/dashboard/bloc/user_event.dart';
import 'package:task_bloc/features/dashboard/model/user_model.dart';

class ListItemWidget extends StatelessWidget {
  const ListItemWidget({
    super.key,
    required this.user,
    required this.index,
  });

  final UserModel user;
  final int index;

  @override
  Widget build(BuildContext ListContext) {
    return ListTile(
        onTap: () {
          // show dialog for updating rupee
          showAdaptiveDialog(
              context: ListContext,
              builder: (context) {
                final formKey = GlobalKey<FormState>();
                return AlertDialog(
                  title: Text('Update Rupee (${user.rupee})'),
                  contentPadding: const EdgeInsets.all(16),
                  content: Form(
                    key: formKey,
                    child: TextFormField(
                      onChanged: (value) {},
                      onSaved: (value) {
                        if (value == null || value.isEmpty) {
                          return;
                        } else {
                          BlocProvider.of<UserListBloc>(ListContext)
                              .add(UpdateUserRupee(index, double.parse(value)));
                        }
                      },
                      decoration:
                          const InputDecoration(hintText: 'Enter new rupee'),
                    ),
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Cancel')),
                    TextButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            Navigator.of(context).pop();
                          }
                        },
                        child: const Text('Update')),
                  ],
                );
              });
        },
        leading: CircleAvatar(
          backgroundImage: NetworkImage(user.photoUrl),
        ),
        title: Text("${user.name} (${user.city})"),
        subtitle: Text("${user.phoneNumber}"),
        trailing: Text(user.isHigh ? 'High' : 'Low'));
  }
}
