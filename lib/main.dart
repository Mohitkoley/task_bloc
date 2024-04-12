import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_bloc/features/auth/screens/auth_screen.dart';
import 'package:task_bloc/features/dashboard/bloc/user_bloc.dart';
import 'package:task_bloc/features/dashboard/bloc/user_event.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: true,
      create: (context) => UserListBloc()..add(FetchUserList()),
      child: MaterialApp(
        title: 'user task',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: AuthScreen(),
      ),
    );
  }
}
