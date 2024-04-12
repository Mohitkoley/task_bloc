import 'package:flutter/material.dart';
import 'package:task_bloc/features/auth/widgets/auth_textfiled.dart';
import 'package:task_bloc/features/dashboard/screens/user_list_screen.dart';
import 'package:task_bloc/shared/validation_mixin.dart';
import 'package:task_bloc/utils/extension.dart';

class AuthScreen extends StatelessWidget with ValidationMixin {
  AuthScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Login Screen'),
        ),
        body: SafeArea(
            child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AuthTextField(
                  hintText: "Enter phone number",
                  validator: checkPhone,
                  keyboardType: TextInputType.phone,
                  inputFormatters: phoneFormatter,
                ),
                20.hBox,
                AuthTextField(
                  hintText: "Enter password",
                  validator: checkPassword,
                ),
                30.hBox,
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.showSnackBar("Login Successful");
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const UserListScreen()));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(context.width, 50),
                  ),
                  child: const Text("Login"),
                )
              ],
            ),
          ),
        )));
  }
}
