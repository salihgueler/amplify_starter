import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:{{project_name.snakeCase()}}/profile/bloc/profile_page_bloc.dart';
import 'package:{{project_name.snakeCase()}}/profile/bloc/profile_page_events.dart';
import 'package:{{project_name.snakeCase()}}/profile/bloc/profile_page_state.dart';
import 'package:{{project_name.snakeCase()}}/profile/domain/user_repository.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
      ),
      body: BlocProvider<ProfilePageBloc>(
        create: (_) =>
            ProfilePageBloc(userRepository: context.read<UserRepository>())
              ..add(const UserRequested()),
        child: BlocBuilder<ProfilePageBloc, ProfilePageState>(
          builder: (context, state) {
            if (state.status == ProfilePageStatus.success) {
              final user = state.user;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 16),
                    Text(
                      'Welcome ${user?.username}!',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 16),
                    const SignOutButton(),
                  ],
                ),
              );
            } else if (state.status == ProfilePageStatus.failure) {
              return const Center(
                child: Text('Failed to fetch user data'),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
