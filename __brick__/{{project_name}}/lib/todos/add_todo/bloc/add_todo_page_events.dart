import 'package:equatable/equatable.dart';
import 'package:{{project_name.snakeCase()}}/models/Todo.dart';

abstract class AddTodoPageEvents extends Equatable {
  const AddTodoPageEvents();

  @override
  List<Object> get props => [];
}

class TodoAdded extends AddTodoPageEvents {
  const TodoAdded(this.todo);

  final Todo todo;

  @override
  List<Object> get props => [todo];
}