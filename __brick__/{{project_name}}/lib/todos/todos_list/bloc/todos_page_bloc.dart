import 'package:bloc/bloc.dart';
import 'package:{{project_name.snakeCase()}}/models/Todo.dart';
import 'package:{{project_name.snakeCase()}}/todos/domain/todos_repository.dart';
import 'package:{{project_name.snakeCase()}}/todos/todos_list/bloc/todos_page_events.dart';
import 'package:{{project_name.snakeCase()}}/todos/todos_list/bloc/todos_page_states.dart';

class TodosPageBloc extends Bloc<TodosPageEvents, TodosPageState> {
  TodosPageBloc({
    required TodosRepository todosRepository,
  })  : _todosRepository = todosRepository,
        super(const TodosPageState()) {
    on<TodosSubscriptionRequested>(_onSubscriptionRequested);
    on<TodoCompletionToggled>(_onTodoCompletionToggled);
    on<TodoDeleted>(_onTodoDeleted);
  }

  final TodosRepository _todosRepository;

  Future<void> _onSubscriptionRequested(
    TodosSubscriptionRequested event,
    Emitter<TodosPageState> emit,
  ) async {
    emit(state.copyWith(status: () => TodosPageStatus.loading));

    await emit.forEach<List<Todo>>(
      _todosRepository.listenToTodos(),
      onData: (todos) => state.copyWith(
        status: () => TodosPageStatus.success,
        todos: () => todos,
      ),
      onError: (_, __) => state.copyWith(
        status: () => TodosPageStatus.failure,
      ),
    );
  }

  Future<void> _onTodoCompletionToggled(
    TodoCompletionToggled event,
    Emitter<TodosPageState> emit,
  ) async {
    final newTodo = event.todo.copyWith(isComplete: event.isComplete);
    await _todosRepository.updateTodo(todo: newTodo);
  }

  Future<void> _onTodoDeleted(
    TodoDeleted event,
    Emitter<TodosPageState> emit,
  ) =>
      _todosRepository.deleteTodo(todo: event.todo);
}
