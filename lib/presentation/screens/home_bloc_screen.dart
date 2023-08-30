import 'package:bloc_pattern_study/bloc/todo_bloc.dart';
import 'package:bloc_pattern_study/bloc/todo_event.dart';
import 'package:bloc_pattern_study/bloc/todo_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBlocScreen extends StatefulWidget {
  const HomeBlocScreen({super.key});

  @override
  State<HomeBlocScreen> createState() => _HomeBlocScreenState();
}

class _HomeBlocScreenState extends State<HomeBlocScreen> {
  String title = '';

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<TodoBloc>(context).add(ListTodosEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    print("Initial state: ${BlocProvider.of<TodoBloc>(context).state}");

    return Scaffold(
      appBar: AppBar(
        title: const Text('BLOC'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          title.isNotEmpty
              ? context.read<TodoBloc>().add(CreateTodoEvent(title: title))
              : null;
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
              child: BlocBuilder<TodoBloc, TodoState>(
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
                                BlocProvider.of<TodoBloc>(context)
                                    .add(DeleteTodoEvent(todo: item));
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
