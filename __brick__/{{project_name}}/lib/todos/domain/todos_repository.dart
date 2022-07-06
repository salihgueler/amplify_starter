import 'package:{{project_name.snakeCase()}}/models/ModelProvider.dart';

/// Repository to do all the todo related operations
///
/// The abstract class here will help you out with testing and mocking
/// When you write tests, if you want to mock a function, you can extend this
/// class on the mock class
abstract class TodosRepository {

  /// Adds a [Todo] object to the API
  Future<void> addTodo({required Todo todo});

  /// Updates the [Todo] object on the API
  Future<void> updateTodo({required Todo todo});

  /// Deletes the [Todo] object from the API
  Future<void> deleteTodo({required Todo todo});

  /// Listens to the updates for the list of [Todo] objects on the API
  Stream<List<Todo>> listenToTodos();
}