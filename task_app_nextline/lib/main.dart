import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_app_nextline/screen/cubit/task_cubit.dart';
import 'package:task_app_nextline/screen/project_detail.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return BlocProvider(
      create: (context) => TaskCubit(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ProjectDetail(),
      ),
    );
  }
}
