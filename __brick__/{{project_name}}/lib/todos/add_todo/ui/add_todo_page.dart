import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:{{project_name.snakeCase()}}/models/Todo.dart';
import 'package:{{project_name.snakeCase()}}/todos/add_todo/bloc/add_todo_page_bloc.dart';
import 'package:{{project_name.snakeCase()}}/todos/add_todo/bloc/add_todo_page_events.dart';
import 'package:{{project_name.snakeCase()}}/todos/add_todo/bloc/add_todo_page_state.dart';
import 'package:{{project_name.snakeCase()}}/todos/domain/todos_repository.dart';

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({Key? key}) : super(key: key);

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddTodoPageBloc>(
      create: (_) => AddTodoPageBloc(
        todosRepository: context.read<TodosRepository>(),
      ),
      child: BlocConsumer<AddTodoPageBloc, AddTodoPageState>(
        listener: (context, state) {
          if (state.status == AddTodoPageStatus.success) {
            Navigator.of(context).pop();
          }
        },
        builder: (context, state) {
          return Container(
            margin: const EdgeInsets.all(8),
            padding:
                MediaQuery.of(context).viewInsets + const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
              color: Colors.white,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter name of the todo';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      label: Text('Name'),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _descriptionController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter description of the todo';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      label: Text('Description'),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final todo = Todo(
                          name: _nameController.text,
                          description: _descriptionController.text,
                          isComplete: false,
                        );
                        context.read<AddTodoPageBloc>().add(TodoAdded(todo));
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Add Todo'),
                        if (state.status == AddTodoPageStatus.loading)
                          const CircularProgressIndicator(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
