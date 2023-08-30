import 'package:bloc_pattern_study/bloc/todo_event.dart';
import 'package:bloc_pattern_study/bloc/todo_state.dart';
import 'package:bloc_pattern_study/model/todo.dart';
import 'package:bloc_pattern_study/repository/todo_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository repository;

  TodoBloc({
    required this.repository,
  }) : super(Empty()) {
    on<ListTodosEvent>(_mapListTodosEvent);
    on<CreateTodoEvent>(_mapCreateTodoEvent);
    on<DeleteTodoEvent>(_mapDeleteTodoEvent);
  }

  void _mapListTodosEvent(ListTodosEvent event, Emitter<TodoState> emit) async {
    try {
      emit(Loading());

      final resp = await repository.listTodo();

      final todos = resp
          .map<Todo>(
            (e) => Todo.fromJson(e),
          )
          .toList();

      emit(Loaded(todos: todos));
    } catch (e) {
      emit(Error(message: e.toString()));
    }
  }

  void _mapCreateTodoEvent(
      CreateTodoEvent event, Emitter<TodoState> emit) async {
    try {
      if (state is Loaded) {
        final parsedState = (state as Loaded);

        final newTodo = Todo(
          id: parsedState.todos.isNotEmpty
              ? parsedState.todos[parsedState.todos.length - 1].id + 1
              : 1,
          title: event.title,
          createdAt: DateTime.now().toString(),
        );

        final prevTodos = [
          ...parsedState.todos,
        ];

        final newTodos = [
          newTodo,
          ...prevTodos,
        ];

        emit(Loaded(todos: newTodos));

        final resp = await repository.createTodo(newTodo);

        emit(
          Loaded(
            todos: [
              Todo.fromJson(resp),
              ...prevTodos,
            ],
          ),
        );
      }
    } catch (e) {
      emit(Error(message: e.toString()));
    }
  }

  void _mapDeleteTodoEvent(
      DeleteTodoEvent event, Emitter<TodoState> emit) async {
    try {
      if (state is Loaded) {
        final newTodos = (state as Loaded)
            .todos
            .where((todo) => todo.id != event.todo.id)
            .toList();

        emit(Loaded(todos: newTodos));

        await repository.deleteTodo(event.todo);
      }
    } catch (e) {
      emit(Error(message: e.toString()));
    }
  }
}
