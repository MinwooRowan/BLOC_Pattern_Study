import 'package:bloc_pattern_study/bloc/todo_bloc.dart';
import 'package:bloc_pattern_study/bloc/todo_cubit.dart';
import 'package:bloc_pattern_study/config/routes/routes.dart';
import 'package:bloc_pattern_study/repository/todo_repository.dart';
import 'package:bloc_pattern_study/util/bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  Bloc.observer = CustomBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) {
          return TodoBloc(repository: TodoRepository());
        }),
        BlocProvider(create: (_) {
          return TodoCubit(repository: TodoRepository());
        }),
      ],
      child: MaterialApp.router(
        routerConfig: router,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
      ),
    );
  }
}
