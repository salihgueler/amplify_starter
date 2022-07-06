import 'package:equatable/equatable.dart';
import 'package:{{project_name.snakeCase()}}/models/Todo.dart';

enum AddTodoPageStatus { initial, loading, success, failure }

class AddTodoPageState extends Equatable {
  const AddTodoPageState({
    this.status = AddTodoPageStatus.initial,
    this.todos = const [],
  });

  final AddTodoPageStatus status;
  final List<Todo> todos;

  AddTodoPageState copyWith({
    AddTodoPageStatus Function()? status,
    List<Todo> Function()? todos,
  }) =>
      AddTodoPageState(
        status: status != null ? status() : this.status,
        todos: todos != null ? todos() : this.todos,
      );

  @override
  List<Object?> get props => [
        status,
        todos,
      ];
}
