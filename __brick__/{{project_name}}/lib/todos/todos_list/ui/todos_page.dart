import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:{{project_name.snakeCase()}}/models/Todo.dart';
import 'package:{{project_name.snakeCase()}}/profile/ui/profile_page.dart';
import 'package:{{project_name.snakeCase()}}/todos/add_todo/ui/add_todo_page.dart';
import 'package:{{project_name.snakeCase()}}/todos/domain/todos_repository.dart';
import 'package:{{project_name.snakeCase()}}/todos/todos_list/bloc/todos_page_bloc.dart';
import 'package:{{project_name.snakeCase()}}/todos/todos_list/bloc/todos_page_events.dart';
import 'package:{{project_name.snakeCase()}}/todos/todos_list/bloc/todos_page_states.dart';

class TodosPage extends StatelessWidget {
  const TodosPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TodosPageBloc>(
      create: (_) => TodosPageBloc(
        todosRepository: context.read<TodosRepository>(),
      )..add(const TodosSubscriptionRequested()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Todo List'),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ProfilePage(),
                  ),
                );
              },
              icon: const Icon(Icons.person),
            )
          ],
        ),
        body: const _TodosList(),
        floatingActionButton: Builder(
          builder: (context) {
            return FloatingActionButton.extended(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.transparent,
                  isScrollControlled: true,
                  builder: (context) => const AddTodoPage(),
                );
              },
              tooltip: 'Add Todo',
              label: Row(
                children: const [Icon(Icons.add), Text('Add todo')],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _TodosList extends StatelessWidget {
  const _TodosList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodosPageBloc, TodosPageState>(
      builder: (context, state) {
        if (state.status == TodosPageStatus.success) {
          final todos = state.todos;
          return todos.isNotEmpty
              ? ListView(
                  children: todos.map((todo) => _TodoItem(todo: todo)).toList(),
                )
              : const Center(child: Text('Tap button below to add a todo!'));
        } else if (state.status == TodosPageStatus.failure) {
          return const Center(
            child: Text('An error happened while retrieving todos'),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

class _TodoItem extends StatelessWidget {
  const _TodoItem({
    required this.todo,
    Key? key,
  }) : super(key: key);

  final Todo todo;

  @override
  Widget build(BuildContext context) {
    final todoPageBloc = context.read<TodosPageBloc>();
    return Dismissible(
      key: Key(todo.id),
      direction: DismissDirection.startToEnd,
      onDismissed: (_) => todoPageBloc.add(TodoDeleted(todo)),
      background: Container(
        color: Colors.blue,
        child: Row(
          children: const [
            SizedBox(width: 8),
            Icon(
              Icons.delete,
              color: Colors.white,
            ),
            SizedBox(width: 8),
            Text(
              'Delete',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
      child: CheckboxListTile(
        title: Text(todo.name),
        subtitle: todo.description == null ? null : Text(todo.description!),
        value: todo.isComplete,
        onChanged: (bool? value) => todoPageBloc.add(
          TodoCompletionToggled(
            todo: todo,
            isComplete: value ?? todo.isComplete,
          ),
        ),
      ),
    );
  }
}
