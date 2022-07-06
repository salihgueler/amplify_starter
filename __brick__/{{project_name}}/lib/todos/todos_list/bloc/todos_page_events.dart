import 'package:equatable/equatable.dart';
import 'package:{{project_name.snakeCase()}}/models/Todo.dart';

abstract class TodosPageEvents extends Equatable {
  const TodosPageEvents();

  @override
  List<Object> get props => [];
}

class TodosSubscriptionRequested extends TodosPageEvents {
  const TodosSubscriptionRequested();
}

class TodoCompletionToggled extends TodosPageEvents {
  const TodoCompletionToggled({
    required this.todo,
    required this.isComplete,
  });

  final Todo todo;
  final bool isComplete;

  @override
  List<Object> get props => [todo, isComplete];
}

class TodoDeleted extends TodosPageEvents {
  const TodoDeleted(this.todo);

  final Todo todo;

  @override
  List<Object> get props => [todo];
}