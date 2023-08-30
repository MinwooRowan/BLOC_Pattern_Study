import 'package:bloc_pattern_study/bloc/todo_cubit.dart';
import 'package:bloc_pattern_study/bloc/todo_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubitScreen extends StatefulWidget {
  const HomeCubitScreen({super.key});

  @override
  State<HomeCubitScreen> createState() => _HomeCubitScreenState();
}

class _HomeCubitScreenState extends State<HomeCubitScreen> {
  String title = '';

  @override
  void initState() {
    super.initState();

    BlocProvider.of<TodoCubit>(context).listTodo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CUBIT'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          title.isNotEmpty ? context.read<TodoCubit>().createTodo(title) : null;
        },
        child: const Icon(
          Icons.edit,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            TextField(
              onChanged: (val) {
                title = val;
              },
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: BlocBuilder<TodoCubit, TodoState>(
                builder: (_, state) {
                  if (state is Empty) {
                    return Container();
                  } else if (state is Error) {
                    return Text(state.message);
                  } else if (state is Loading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is Loaded) {
                    final items = state.todos;

                    return ListView.separated(
                      itemBuilder: (_, index) {
                        final item = items[index];

                        return Row(
                          children: [
                            Expanded(
                              child: Text(
                                item.title,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                BlocProvider.of<TodoCubit>(context).deleteTodo(
                                  item,
                                );
                              },
                              child: const Icon(
                                Icons.delete,
                              ),
                            ),
                          ],
                        );
                      },
                      separatorBuilder: (_, index) => const Divider(),
                      itemCount: items.length,
                    );
                  }

                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
