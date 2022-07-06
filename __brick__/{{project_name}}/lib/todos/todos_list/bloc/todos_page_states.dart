import 'package:equatable/equatable.dart';
import 'package:{{project_name.snakeCase()}}/models/Todo.dart';

enum TodosPageStatus { initial, loading, success, failure }

class TodosPageState extends Equatable {
  const TodosPageState({
    this.status = TodosPageStatus.initial,
    this.todos = const [],
  });

  final TodosPageStatus status;
  final List<Todo> todos;

  TodosPageState copyWith({
    TodosPageStatus Function()? status,
    List<Todo> Function()? todos,
  }) =>
      TodosPageState(
        status: status != null ? status() : this.status,
        todos: todos != null ? todos() : this.todos,
      );

  @override
  List<Object?> get props => [
        status,
        todos,
      ];
}
