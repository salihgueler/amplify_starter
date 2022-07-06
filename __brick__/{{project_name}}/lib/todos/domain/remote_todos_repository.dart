import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:{{project_name.snakeCase()}}/models/Todo.dart';
import 'package:{{project_name.snakeCase()}}/todos/domain/todos_repository.dart';

class RemoteTodosRepository extends TodosRepository {
  @override
  Future<void> addTodo({required Todo todo}) {
    return Amplify.DataStore.save(todo);
  }

  @override
  Future<void> deleteTodo({required Todo todo}) {
    return Amplify.DataStore.delete(todo);
  }

  @override
  Stream<List<Todo>> listenToTodos() {
    return Amplify.DataStore.observeQuery(Todo.classType)
        .map((itemSnapshot) => itemSnapshot.items);
  }

  @override
  Future<void> updateTodo({required Todo todo}) async {
    Amplify.DataStore.save(todo);
  }
}
