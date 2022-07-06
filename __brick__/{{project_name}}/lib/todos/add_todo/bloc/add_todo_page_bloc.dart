import 'package:bloc/bloc.dart';
import 'package:{{project_name.snakeCase()}}/todos/add_todo/bloc/add_todo_page_events.dart';
import 'package:{{project_name.snakeCase()}}/todos/add_todo/bloc/add_todo_page_state.dart';
import 'package:{{project_name.snakeCase()}}/todos/domain/todos_repository.dart';

class AddTodoPageBloc extends Bloc<AddTodoPageEvents, AddTodoPageState> {
  AddTodoPageBloc({
    required TodosRepository todosRepository,
  })  : _todosRepository = todosRepository,
        super(const AddTodoPageState()) {
    on<TodoAdded>(_onTodoAdded);
  }

  final TodosRepository _todosRepository;

  Future<void> _onTodoAdded(
    TodoAdded event,
    Emitter<AddTodoPageState> emit,
  ) async {
    emit(state.copyWith(status: () => AddTodoPageStatus.loading));
    try {
      await _todosRepository.addTodo(todo: event.todo);
      emit(state.copyWith(status: () => AddTodoPageStatus.success));
    } on Exception catch(_) {
      emit(state.copyWith(status: () => AddTodoPageStatus.failure));
    }
  }
}
