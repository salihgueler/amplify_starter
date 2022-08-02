import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:{{project_name.snakeCase()}}/models/ModelProvider.dart';
import 'package:{{project_name.snakeCase()}}/todos/todos_list/ui/todos_page.dart';
import 'package:{{project_name.snakeCase()}}/profile/domain/remote_user_repository.dart';
import 'package:{{project_name.snakeCase()}}/profile/domain/user_repository.dart';
import 'package:{{project_name.snakeCase()}}/todos/domain/remote_todos_repository.dart';
import 'package:{{project_name.snakeCase()}}/todos/domain/todos_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'amplifyconfiguration.dart';

void main() {
  runApp(const {{project_name.pascalCase()}}App());
}

class {{project_name.pascalCase()}}App extends StatelessWidget {
  const {{project_name.pascalCase()}}App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<TodosRepository>(
          create: (_) => RemoteTodosRepository(),
        ),
        RepositoryProvider<UserRepository>(
          create: (_) => RemoteUserRepository(),
        ),
      ],
      child: FutureBuilder<void>(
        future: _configureAmplify(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Authenticator(
              child: MaterialApp(
                builder: Authenticator.builder(),
                home: const TodosPage(),
              ),
            );
          } else {
            return MaterialApp(
              home: Center(
                child: snapshot.hasError
                    ? Text(
                        'Something went wrong while configuring Amplify: ${snapshot.error}',
                      )
                    : const CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }

  Future<void> _configureAmplify() async {
    final dataStore = AmplifyDataStore(modelProvider: ModelProvider.instance);
    final auth = AmplifyAuthCognito();
    final api = AmplifyAPI();
    await Amplify.addPlugins([
      auth,
      dataStore,
      api,
    ]);
    await Amplify.configure(amplifyconfig);
  }
}
